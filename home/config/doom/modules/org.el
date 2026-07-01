;;; home/config/doom/org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org")

(after! org
  (setq org-hide-emphasis-markers t
        org-pretty-entities t
        org-adapt-indentation t

        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0

        org-agenda-files '("~/org")))

(use-package! olivetti
  :hook (org-mode . olivetti-mode)

  :config
  (setq olivetti-body-width 100))

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode))

(setq display-fill-column-indicator-column 80)

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(use-package! org-modern
  :hook (org-mode . org-modern-mode)

  :config
  (setq org-modern-star 'replace
        org-modern-hide-stars t
        org-modern-table t
        org-modern-block-fringe t))
