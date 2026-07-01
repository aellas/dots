;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; UI & Fonts
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 25)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font")
      doom-theme 'modern-catppuccin-latte
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

;;; Org
(setq org-directory "~/org/")

(after! org
  (setq org-hide-emphasis-markers t
        org-pretty-entities t
        org-adapt-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-agenda-prefix-format '((agenda . "  %i %-12:c%?-12t% s")
                                   (todo   . "  %i %-12:c")
                                   (tags   . "  %i %-12:c")
                                   (search . "  %i %-12:c"))
        org-agenda-files '("~/org/")))

;; Olivetti
(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star 'replace
        org-modern-hide-stars t
        org-modern-table t
        org-modern-block-fringe t))

;;; Tree-sitter
(setq treesit-language-source-alist
      '((toml "https://github.com/tree-sitter/tree-sitter-toml")))

(after! flycheck (setq flycheck-idle-change-delay 0.1))
(after! lsp-mode
  (setq lsp-idle-delay 0.1)
  (setq lsp-completion-enable-additional-text-edit t)
  (setq lsp-modeline-code-actions-enable t))
