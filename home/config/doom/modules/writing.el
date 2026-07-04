;;; home/config/doom/writing.el -*- lexical-binding: t; -*-

(setq sentence-end-double-space nil
      fill-column 80)

(add-hook 'text-mode-hook #'visual-line-mode)

(add-hook 'text-mode-hook #'variable-pitch-mode)

(custom-theme-set-faces!
  'doom-tokyo-night
  '(org-level-8 :inherit outline-3 :height 1.2)
  '(org-level-7 :inherit outline-3 :height 1.2)
  '(org-level-6 :inherit outline-3 :height 1.2)
  '(org-level-5 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-3 :height 1.3)
  '(org-level-3 :inherit outline-3 :height 1.4)
  '(org-level-2 :inherit outline-2 :height 1.5)
  '(org-level-1 :inherit outline-1 :height 1.6)
  '(org-document-title  :height 1.8 :bold t :underline nil))
