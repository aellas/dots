;;; home/config/doom/org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org")

(after! org
  (setq org-agenda-files (list org-directory)
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-adapt-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0))

(use-package! olivetti
  :hook (org-mode . olivetti-mode))

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star 'replace
        org-modern-hide-stars t
        org-modern-table t
        org-modern-block-fringe t))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))
(add-hook 'org-mode-hook (lambda () (setq-local mode-line-format nil)))

(setq org-agenda-files
      (list (concat org-directory "notes.org")
            (concat org-directory "agenda.org")
            (concat org-directory "tasks.org")))
