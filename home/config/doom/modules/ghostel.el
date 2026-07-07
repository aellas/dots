;;; home/config/doom/modules/ghostel.el -*- lexical-binding: t; -*-

(use-package ghostel
  :ensure t)
(use-package ghostel-eshell
  :hook (eshell-load . ghostel-eshell-visual-command-mode))
(use-package ghostel-compile
  :hook (after-init . ghostel-compile-global-mode))
(use-package ghostel-comint
  :hook (after-init . ghostel-comint-global-mode))
