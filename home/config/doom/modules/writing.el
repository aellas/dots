;;; home/config/doom/writing.el -*- lexical-binding: t; -*-

(setq sentence-end-double-space nil
      fill-column 80)

(add-hook 'text-mode-hook #'visual-line-mode)

(add-hook 'text-mode-hook #'variable-pitch-mode)
