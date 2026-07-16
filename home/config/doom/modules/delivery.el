;;; hmrc-delivery.el --- HMRC Delivery Core System

;; --------------------------------------------------
;; CONFIG
;; --------------------------------------------------

(defvar hmrc-base-dir "~/org/work/"
  "Base directory for HMRC logs.")

(defconst hmrc-mileage-rate 0.45)
(defconst hmrc-tax-rate 0.20)

;; --------------------------------------------------
;; FILE LOCATION (/work/YYYY/month/weekN.org)
;; --------------------------------------------------

(defun hmrc--week-of-month ()
  "Return week number within the current month, starting at 1."
  (let ((day (string-to-number (format-time-string "%d"))))
    (1+ (/ (1- day) 7))))

(defun hmrc--file ()
  "Return current weekly HMRC org file."
  (let* ((year (format-time-string "%Y"))
         (month (downcase (format-time-string "%B")))
         (week (hmrc--week-of-month))
         (dir (expand-file-name (concat year "/" month "/") hmrc-base-dir)))
    (make-directory dir t)
    (expand-file-name (format "week%d.org" week) dir)))

(defun hmrc--month-name (month year)
  "Return lowercase month name for MONTH and YEAR."
  (downcase
   (format-time-string "%B" (encode-time 0 0 0 1 month year))))

(defun hmrc--month-dir (year month)
  "Return directory for YEAR and MONTH."
  (expand-file-name
   (format "%04d/%s/" year (hmrc--month-name month year))
   hmrc-base-dir))

(defun hmrc--month-files (year month)
  "Return all week org files for YEAR and MONTH."
  (let ((dir (hmrc--month-dir year month)))
    (when (file-directory-p dir)
      (directory-files dir t "^week[0-9]+\\.org$"))))

;; --------------------------------------------------
;; AGENDA FILE MANAGEMENT
;; --------------------------------------------------

(defun hmrc--ensure-agenda-file (file)
  (unless (member file org-agenda-files)
    (add-to-list 'org-agenda-files file)))

(defun hmrc-refresh-agenda-files ()
  "Add all existing HMRC weekly org files to `org-agenda-files'."
  (interactive)
  (let ((files (directory-files-recursively
                (expand-file-name hmrc-base-dir) "\\.org\\'")))
    (dolist (f files)
      (add-to-list 'org-agenda-files f))
    (message "Added %d HMRC file(s) to org-agenda-files" (length files))))

;; --------------------------------------------------
;; NEW SHIFT ENTRY
;; --------------------------------------------------

(defun hmrc-new-shift ()
  (interactive)
  (let* ((file (hmrc--file))
         (date (format-time-string "%Y-%m-%d %a")))

    (hmrc--ensure-agenda-file file)
    (find-file file)
    (goto-char (point-max))

    (insert
     (concat
      "* TODO Shift\n"
      "SCHEDULED: <" date ">\n"
      ":START_TIME:\n"
      ":END_TIME:\n"
      ":UBER:\n"
      ":UBER_TIPS:\n"
      ":DELIVEROO:\n"
      ":DELIVEROO_TIPS:\n"
      ":START_MILES:\n"
      ":END_MILES:\n"
      ":BUSINESS_MILES:\n\n"))

    (save-buffer)
    (message "Shift created ✔ — fill in via Org-note, then mark DONE")))

;; --------------------------------------------------
;; LOG SHIFT
;; --------------------------------------------------

(defun hmrc-log-shift ()
  (interactive)
  (let* ((file (hmrc--file))
         (date (format-time-string "%Y-%m-%d %a"))

         (start-time (read-string "Start time (e.g. 08:30): "))
         (end-time (read-string "End time (e.g. 17:30): "))

         (uber (read-number "Uber total (£): " 0))
         (uber-tips (read-number "Uber tips (£, already included in Uber total above — enter for reference only): " 0))

         (deliveroo (read-number "Deliveroo order fees (£): " 0))
         (deliveroo-tips (read-number "Deliveroo tips (£, reported separately — will be added to income): " 0))

         (start-miles (read-number "Start odometer (miles): " 0))
         (end-miles (read-number "End odometer (miles): " 0))
         (default-business-miles (max 0 (- end-miles start-miles)))
         (business-miles (read-number "Business miles: " default-business-miles)))

    (hmrc--ensure-agenda-file file)
    (find-file file)
    (goto-char (point-max))

    (insert
     (format
      (concat
       "* DONE Shift\n"
       "SCHEDULED: <%s>\n"
       ":START_TIME: %s\n"
       ":END_TIME: %s\n"
       ":UBER: %.2f\n"
       ":UBER_TIPS: %.2f\n"
       ":DELIVEROO: %.2f\n"
       ":DELIVEROO_TIPS: %.2f\n"
       ":START_MILES: %d\n"
       ":END_MILES: %d\n"
       ":BUSINESS_MILES: %d\n\n")
      date start-time end-time uber uber-tips deliveroo deliveroo-tips
      start-miles end-miles business-miles))

    (save-buffer)
    (message "Shift logged ✔")))

;; --------------------------------------------------
;; EXPENSE ENTRY
;; --------------------------------------------------

(defun hmrc-add-expense ()
  (interactive)
  (let* ((file (hmrc--file))
         (date (format-time-string "%Y-%m-%d %a"))
         (category (upcase
                    (replace-regexp-in-string
                     "[^A-Za-z0-9]+" "_"
                     (read-string "Expense category (e.g. Phone, Equipment): "))))
         (amount (read-number "Amount (£): ")))

    (hmrc--ensure-agenda-file file)
    (find-file file)
    (goto-char (point-max))

    (insert
     (format
      (concat
       "* DONE Expense: %s\n"
       "SCHEDULED: <%s>\n"
       ":EXPENSE_%s: %.2f\n\n")
      category date category amount))

    (save-buffer)
    (message "Expense logged ✔")))

;; --------------------------------------------------
;; PARSER & TIME HELPERS
;; --------------------------------------------------

(defun hmrc--sum (regex)
  (let ((sum 0))
    (goto-char (point-min))
    (while (re-search-forward regex nil t)
      (setq sum (+ sum (string-to-number (match-string 1)))))
    sum))

(defun hmrc--count ()
  (let ((c 0))
    (goto-char (point-min))
    (while (re-search-forward "^\\*+ \\(?:TODO\\|DONE\\) Shift\\_>" nil t)
      (setq c (1+ c)))
    c))

(defun hmrc--parse-hours ()
  (let ((total-hours 0.0))
    (goto-char (point-min))
    (while (re-search-forward "^\\*+ \\(?:TODO\\|DONE\\) Shift\\_>" nil t)
      (let ((end-of-entry
             (save-excursion
               (if (re-search-forward "^\\* " nil t)
                   (progn
                     (beginning-of-line)
                     (point))
                 (point-max))))
            start-str
            end-str)

        (save-excursion
          (when (re-search-forward ":START_TIME: *\\([0-2][0-9]:[0-5][0-9]\\)" end-of-entry t)
            (setq start-str (match-string 1)))
          (goto-char (match-beginning 0))
          (when (re-search-forward ":END_TIME: *\\([0-2][0-9]:[0-5][0-9]\\)" end-of-entry t)
            (setq end-str (match-string 1))))

        (when (and start-str end-str)
          (let* ((sh (string-to-number (substring start-str 0 2)))
                 (sm (string-to-number (substring start-str 3 5)))
                 (eh (string-to-number (substring end-str 0 2)))
                 (em (string-to-number (substring end-str 3 5)))
                 (start-mins (+ (* sh 60) sm))
                 (end-mins (+ (* eh 60) em))
                 (diff-mins (- end-mins start-mins)))
            (when (< diff-mins 0)
              (setq diff-mins (+ diff-mins 1440)))
            (setq total-hours (+ total-hours (/ (float diff-mins) 60.0)))))))
    total-hours))

;; --------------------------------------------------
;; CORE CALC
;; --------------------------------------------------

(defun hmrc--calc ()
  (let* ((uber-income (hmrc--sum ":UBER: *\\([0-9.]+\\)"))
         (deliveroo-fees (hmrc--sum ":DELIVEROO: *\\([0-9.]+\\)"))
         (deliveroo-tips (hmrc--sum ":DELIVEROO_TIPS: *\\([0-9.]+\\)"))
         (deliveroo-income (+ deliveroo-fees deliveroo-tips))
         (gross-income (+ uber-income deliveroo-income))

         (miles (hmrc--sum ":BUSINESS_MILES: *\\([0-9]+\\)"))
         (mileage-deduction (* miles hmrc-mileage-rate))
         (expenses (hmrc--sum ":EXPENSE_[A-Z0-9_]+: *\\([0-9.]+\\)"))
         (total-deductions (+ mileage-deduction expenses))

         (taxable-profit (max 0 (- gross-income total-deductions)))
         (estimated-tax (* taxable-profit hmrc-tax-rate))
         (after-tax-income (- gross-income estimated-tax))

         (total-hours (hmrc--parse-hours))
         (entries (hmrc--count)))

    (list :gross-income gross-income
          :uber-income uber-income
          :deliveroo-income deliveroo-income
          :miles miles
          :mileage-deduction mileage-deduction
          :expenses expenses
          :total-deductions total-deductions
          :taxable-profit taxable-profit
          :estimated-tax estimated-tax
          :after-tax-income after-tax-income
          :total-hours total-hours
          :entries entries)))

(defun hmrc--calc-files (files)
  "Calculate totals across multiple org FILES."
  (let ((gross-income 0.0)
        (uber-income 0.0)
        (deliveroo-income 0.0)
        (miles 0)
        (mileage-deduction 0.0)
        (expenses 0.0)
        (total-deductions 0.0)
        (taxable-profit 0.0)
        (estimated-tax 0.0)
        (after-tax-income 0.0)
        (total-hours 0.0)
        (entries 0))

    (dolist (file files)
      (when (file-exists-p file)
        (with-temp-buffer
          (insert-file-contents file)
          (let ((data (hmrc--calc)))
            (setq gross-income (+ gross-income (plist-get data :gross-income)))
            (setq uber-income (+ uber-income (plist-get data :uber-income)))
            (setq deliveroo-income (+ deliveroo-income (plist-get data :deliveroo-income)))
            (setq miles (+ miles (plist-get data :miles)))
            (setq mileage-deduction (+ mileage-deduction (plist-get data :mileage-deduction)))
            (setq expenses (+ expenses (plist-get data :expenses)))
            (setq total-deductions (+ total-deductions (plist-get data :total-deductions)))
            (setq taxable-profit (+ taxable-profit (plist-get data :taxable-profit)))
            (setq estimated-tax (+ estimated-tax (plist-get data :estimated-tax)))
            (setq after-tax-income (+ after-tax-income (plist-get data :after-tax-income)))
            (setq total-hours (+ total-hours (plist-get data :total-hours)))
            (setq entries (+ entries (plist-get data :entries)))))))

    (list :gross-income gross-income
          :uber-income uber-income
          :deliveroo-income deliveroo-income
          :miles miles
          :mileage-deduction mileage-deduction
          :expenses expenses
          :total-deductions total-deductions
          :taxable-profit taxable-profit
          :estimated-tax estimated-tax
          :after-tax-income after-tax-income
          :total-hours total-hours
          :entries entries)))

;; --------------------------------------------------
;; MONTHLY DASHBOARD
;; --------------------------------------------------

(defun hmrc-dashboard ()
  "Show dashboard for the current month, across all week files."
  (interactive)
  (let* ((year (string-to-number (format-time-string "%Y")))
         (month (string-to-number (format-time-string "%m")))
         (files (hmrc--month-files year month)))

    (if (not files)
        (message "No data for this month")
      (let* ((data (hmrc--calc-files files))
             (gross (plist-get data :gross-income))
             (hours (plist-get data :total-hours))
             (after-tax (plist-get data :after-tax-income))
             (uber (plist-get data :uber-income))
             (roo (plist-get data :deliveroo-income))
             (miles (plist-get data :miles))
             (mileage-ded (plist-get data :mileage-deduction))
             (expenses (plist-get data :expenses))
             (deductions (plist-get data :total-deductions))
             (profit (plist-get data :taxable-profit))
             (tax (plist-get data :estimated-tax))
             (entries (plist-get data :entries))
             (avg-gross (if (> hours 0) (/ gross hours) 0))
             (avg-net (if (> hours 0) (/ after-tax hours) 0)))

        (with-output-to-temp-buffer "*HMRC Dashboard*"
          (with-current-buffer "*HMRC Dashboard*"
            (cl-flet ((ins (str &optional face)
                        (if face
                            (insert (propertize str 'face face))
                          (insert str))))

              (ins "┌────────────────────────────────────────────────────────┐\n")
              (ins "│ 📊               HMRC MONTHLY DASHBOARD               │\n")
              (ins "└────────────────────────────────────────────────────────┘\n\n")

              (ins (format "  Entries: %-15d Hours Worked: %.2f hrs\n" entries hours) 'font-lock-comment-face)
              (ins "──────────────────────────────────────────────────────────\n\n")

              (ins " 💰 INCOME\n")
              (ins (format "  ├─ 🚗 Uber Income:                     £%7.2f\n" uber))
              (ins (format "  ├─ 🛵 Deliveroo Income:                £%7.2f\n" roo))
              (ins (format "  └─ 🎉 Gross Income:                    £%7.2f\n" gross) 'font-lock-function-name-face)
              (ins "\n")

              (ins " 📉 DEDUCTIONS & MILEAGE\n")
              (ins (format "  ├─ 🛣️  Business Miles:                  %7d mi\n" miles))
              (ins (format "  ├─ 💸 Mileage Allowance:               £%7.2f\n" mileage-ded))
              (ins (format "  ├─ 🧰 Non-Vehicle Expenses:            £%7.2f\n" expenses))
              (ins (format "  └─ ❌ Total Deductions:                £%7.2f\n" deductions) 'font-lock-warning-face)
              (ins "\n")

              (ins " 💷 TAX & NET SUMMARY\n")
              (ins (format "  ├─ 📈 Taxable Profit:                  £%7.2f\n" profit))
              (ins (format "  ├─ 🧾 Est. Tax Bill (20%%):             £%7.2f\n" tax) 'font-lock-keyword-face)
              (ins (format "  └─ 🔒 After-Tax Cash Net:              £%7.2f\n" after-tax) 'font-lock-type-face)
              (ins "\n")

              (ins " ──────────────────────────────────────────────────────────\n")
              (ins (format "  🚀 Gross Hourly Efficiency:            £%.2f/hr\n" avg-gross) 'font-lock-constant-face)
              (ins (format "  🛡️  Net Hourly Take-Home:              £%.2f/hr\n" avg-net) 'font-lock-string-face)
              (ins " ──────────────────────────────────────────────────────────\n"))))))))

;; --------------------------------------------------
;; WEEKLY SNAPSHOT
;; --------------------------------------------------

(defun hmrc-weekly ()
  "Show snapshot for the current week file."
  (interactive)
  (let ((file (hmrc--file)))
    (if (not (file-exists-p file))
        (message "No data for this week yet")
      (with-temp-buffer
        (insert-file-contents file)
        (let* ((data (hmrc--calc))
               (gross (plist-get data :gross-income))
               (hours (plist-get data :total-hours))
               (after-tax (plist-get data :after-tax-income))
               (miles (plist-get data :miles))
               (profit (plist-get data :taxable-profit))
               (tax (plist-get data :estimated-tax))
               (entries (plist-get data :entries))
               (avg-gross (if (> hours 0) (/ gross hours) 0))
               (avg-net (if (> hours 0) (/ after-tax hours) 0)))

          (with-output-to-temp-buffer "*HMRC Weekly*"
            (with-current-buffer "*HMRC Weekly*"
              (cl-flet ((ins (str &optional face)
                          (if face
                              (insert (propertize str 'face face))
                            (insert str))))

                (ins "┌────────────────────────────────────────────────────────┐\n")
                (ins "│ 📅                 WEEKLY SNAPSHOT                    │\n")
                (ins "└────────────────────────────────────────────────────────┘\n\n")

                (ins (format "  Entries: %-15d Hours Worked: %.2f hrs\n" entries hours) 'font-lock-comment-face)
                (ins "──────────────────────────────────────────────────────────\n\n")

                (ins (format "  💰 Gross Income:                       £%7.2f\n" gross) 'font-lock-function-name-face)
                (ins (format "  🛣️  Miles Driven:                       %7d mi\n" miles))
                (ins (format "  📈 Taxable Profit:                     £%7.2f\n" profit))
                (ins (format "  🧾 Est. Tax:                           £%7.2f\n" tax) 'font-lock-keyword-face)
                (ins (format "  🔒 Est. After-Tax Income:              £%7.2f\n\n" after-tax) 'font-lock-type-face)

                (ins " ──────────────────────────────────────────────────────────\n")
                (ins (format "  🚀 Avg. Gross / Hour:                  £%.2f/hr\n" avg-gross) 'font-lock-constant-face)
                (ins (format "  🛡️  Avg. After-Tax / Hour:              £%.2f/hr\n" avg-net) 'font-lock-string-face)
                (ins " ──────────────────────────────────────────────────────────\n")))))))))

;; --------------------------------------------------
;; YEARLY REPORT APRIL → APRIL
;; --------------------------------------------------

(defun hmrc-yearly-report ()
  "Show yearly report across weekly files from April to April."
  (interactive)
  (let* ((current-year (string-to-number (format-time-string "%Y")))
         (current-month (string-to-number (format-time-string "%m")))
         (tax-start (if (>= current-month 4)
                        current-year
                      (1- current-year)))
         (all-files nil)
         (months 0))

    (dotimes (i 12)
      (let* ((month (+ 4 i))
             (year (if (> month 12) (1+ tax-start) tax-start))
             (real-month (if (> month 12) (- month 12) month))
             (files (hmrc--month-files year real-month)))

        (when files
          (setq all-files (append all-files files))
          (setq months (1+ months)))))

    (if (not all-files)
        (message "No yearly HMRC data found")
      (let* ((data (hmrc--calc-files all-files))
             (gross-income (plist-get data :gross-income))
             (uber-income (plist-get data :uber-income))
             (deliveroo-income (plist-get data :deliveroo-income))
             (miles (plist-get data :miles))
             (expenses (plist-get data :expenses))
             (entries (plist-get data :entries))
             (hours (plist-get data :total-hours))
             (mileage-deduction (* miles hmrc-mileage-rate))
             (total-deductions (+ mileage-deduction expenses))
             (taxable-profit (max 0 (- gross-income total-deductions)))
             (estimated-tax (* taxable-profit hmrc-tax-rate))
             (after-tax-income (- gross-income estimated-tax))
             (avg-gross (if (> hours 0) (/ gross-income hours) 0))
             (avg-net (if (> hours 0) (/ after-tax-income hours) 0)))

        (with-output-to-temp-buffer "*HMRC YEARLY REPORT*"
          (with-current-buffer "*HMRC YEARLY REPORT*"
            (cl-flet ((ins (str &optional face)
                        (if face
                            (insert (propertize str 'face face))
                          (insert str))))

              (ins "┌────────────────────────────────────────────────────────┐\n")
              (ins "│ 📊            HMRC ANNUAL REPORT (APR → APR)           │\n")
              (ins "└────────────────────────────────────────────────────────┘\n\n")

              (ins (format "  Months Logged: %-9d Total Shifts: %d\n" months entries) 'font-lock-comment-face)
              (ins (format "  Total Hours worked: %.2f hrs\n" hours) 'font-lock-comment-face)
              (ins "──────────────────────────────────────────────────────────\n\n")

              (ins " 💰 ANNUAL REVENUE\n")
              (ins (format "  ├─ 🚗 Total Uber Income:               £%7.2f\n" uber-income))
              (ins (format "  ├─ 🛵 Total Deliveroo Income:          £%7.2f\n" deliveroo-income))
              (ins (format "  └─ 🎉 Total Gross Income:              £%7.2f\n" gross-income) 'font-lock-function-name-face)
              (ins "\n")

              (ins " 📉 BUSINESS WRITE-OFFS\n")
              (ins (format "  ├─ 🛣️  Total Miles Logged:              %7d mi\n" miles))
              (ins (format "  ├─ 💸 Total Mileage Allowance:         £%7.2f\n" mileage-deduction))
              (ins (format "  ├─ 🧰 Non-Vehicle Expenses:            £%7.2f\n" expenses))
              (ins (format "  └─ ❌ Total Annual Deductions:         £%7.2f\n" total-deductions) 'font-lock-warning-face)
              (ins "\n")

              (ins " 💷 NET PROFILE\n")
              (ins (format "  ├─ 📈 Net Taxable Profit:              £%7.2f\n" taxable-profit))
              (ins (format "  ├─ 🧾 Est. Annual Tax (20%%):           £%7.2f\n" estimated-tax) 'font-lock-keyword-face)
              (ins (format "  └─ 🔒 Estimated Net Take-Home:         £%7.2f\n" after-tax-income) 'font-lock-type-face)
              (ins "\n")

              (ins " ──────────────────────────────────────────────────────────\n")
              (ins (format "  🚀 Hourly Gross Efficiency:            £%.2f/hr\n" avg-gross) 'font-lock-constant-face)
              (ins (format "  🛡️  Hourly Net Efficiency:              £%.2f/hr\n" avg-net) 'font-lock-string-face)
              (ins " ──────────────────────────────────────────────────────────\n"))))))))

(provide 'hmrc-delivery)
