;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load! "modules/ui")
(load! "modules/dashboard")
(load! "modules/dired")
(load! "modules/org")
(load! "modules/treesit")
(load! "modules/lsp")
(load! "modules/git")
(load! "modules/writing")
(load! "modules/keybinds.el")
(load! "modules/caldav.el")
(setq initial-buffer-choice 'dashboard-open)
(load "~/.config/doom/modules/delivery.el")
(load! "modules/empv.el")
(use-package! pdf-tools
  :config
  (pdf-tools-install :no-query))
