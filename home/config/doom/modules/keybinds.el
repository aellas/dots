;; home/config/doom/modules/keybinds.el -*- lexical-binding: t; -*-

;; Comment Line
(map! :leader
      :desc "Comment line" "-" #'comment-line)

;; Orgnote
(map! :leader
      :desc "orgnote"
      "o n s" #'orgnote-sync
      "o n f" #'orgnote-force-sync
      "o n c" #'orgnote-open-configuration)

;; Calander
(map! :leader
      :desc "calendar"
      "@" #'calendar)

;; New shift
(map! :leader
      :desc "new shift"
      "o s n" #'new-delivery-shift-with-confirmation)

;; Calculator
(map! :leader
      :desc "quick-calc"
      "=" #'quick-calc)

;; Ghostel
(map! :leader
      :desc "ghostel"
      "o g" #'+ghostel/toggle)
