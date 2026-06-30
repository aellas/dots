;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; UI & Fonts
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 25)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font")
      doom-theme 'doom-tokyo-night
      display-line-numbers-type t
      confirm-kill-emacs nil
      auto-save-default t
      make-backup-files t)

;; Mouse support in terminal only
(add-hook 'tty-setup-hook #'xterm-mouse-mode)

;;; Dashboard
(use-package! dashboard
  :config
  (setq 
   dashboard-navigation-cycle t
   dashboard-week-agenda t
   dashboard-agenda-prefix-format " %-4s - %t"
   dashboard-agenda-format-item-string "%s"
   dashboard-projects-backend 'projectile
   dashboard-startup-banner "~/.config/doom/ascii.txt"
   dashboard-center-content t
   dashboard-items '((recents   . 7)
                     (projects  . 5)
                     (bookmarks . 3)
                     (agenda    . 5))
   dashboard-set-heading-icons t
   dashboard-set-file-icons t
   dashboard-icon-type 'nerd-icons
   dashboard-startupify-list '(dashboard-insert-banner
                               dashboard-insert-navigator
                               dashboard-insert-newline
                               dashboard-insert-items
                               dashboard-insert-newline))

  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

  (add-hook 'server-after-make-frame-hook
            (lambda ()
              (when (display-graphic-p)
                (switch-to-buffer dashboard-buffer-name)
                (dashboard-mode)
                (dashboard-insert-startupify-lists)
                (dashboard-refresh-buffer)))))

;;; Dired & Treemacs
(setq dired-listing-switches "-alh --group-directories-first"
      treemacs-show-hidden-files t)

;;; File associations
(dolist (ext '("\\.png\\'" "\\.jpe?g\\'" "\\.gif\\'"))
  (add-to-list 'auto-mode-alist (cons ext 'image-mode)))

(add-to-list 'auto-mode-alist '("waybar/config\\'" . json-mode))

;;; Misc
(add-hook 'prog-mode-hook #'rainbow-mode)

;;; Modeline
(setq doom-modeline-enable-word-count t)

;;; Startup message
(add-hook 'emacs-startup-hook
          (lambda ()
            (message (seq-random-elt '("For Those That Wish to Exist")))))

;;; GPTel
(load! "secrets")
(use-package! gptel
  :config
  (gptel-make-openai "OpenWebUI"
    :host "serfor:3001"
    :protocol "http"
    :key my-openwebui-key
    :endpoint "/api/chat/completions"
    :stream t
    :models '(ornith:latest))
  (setq! gptel-backend (gptel-get-backend "OpenWebUI")
         gptel-model 'ornith:latest
         gptel-default-mode 'org-mode
         gptel-include-reasoning nil))

(map! :leader
      (:prefix ("k" . "AI")
       :desc "gptel chat"           "c" #'gptel
       :desc "gptel send"           "s" #'gptel-send
       :desc "gptel rewrite"        "r" #'gptel-rewrite
       :desc "gptel add context"    "a" #'gptel-add
       :desc "gptel add file"       "f" #'gptel-add-file
       :desc "gptel menu"           "m" #'gptel-menu
       :desc "gptel abort"          "x" #'gptel-abort
       :desc "gptel toggle log"     "l" #'gptel-toggle-log
       :desc "gptel system prompt"  "p" #'gptel-system-prompt))

;;; Org
(setq org-directory "~/org/")

(after! org
  (setq org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-pretty-entities t
        org-ellipsis "  ·"
        org-adapt-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-agenda-prefix-format '((agenda . "  %i %-12:c%?-12t% s")
                                   (todo   . "  %i %-12:c")
                                   (tags   . "  %i %-12:c")
                                   (search . "  %i %-12:c"))
        org-agenda-files '("~/org/"))

  ;; Headings
  (dolist (face '((org-level-1 . 1.35)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :weight 'bold :height (cdr face)))

  ;; Fixed-pitch for code blocks
  (set-face-attribute 'org-block nil     :foreground nil :inherit 'fixed-pitch :height 0.85)
  (set-face-attribute 'org-code nil      :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-verbatim nil  :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))

  (require 'org-indent)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch)))

(add-hook 'org-mode-hook #'variable-pitch-mode)
(add-hook 'org-mode-hook #'visual-line-mode)

(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

;;; Tree-sitter
(setq treesit-language-source-alist
      '((toml "https://github.com/tree-sitter/tree-sitter-toml")))

(after! flycheck (setq flycheck-idle-change-delay 0.1))
(after! lsp-mode
  (setq lsp-idle-delay 0.1)
  (setq lsp-completion-enable-additional-text-edit t)
  (setq lsp-modeline-code-actions-enable t))
