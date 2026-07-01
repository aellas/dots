;;; modules/ui.el -*- lexical-binding: t; -*-

(setq doom-font
      (font-spec :family "Iosevka Nerd Font" :size 25)

      doom-variable-pitch-font
      (font-spec :family "Iosevka Nerd Font")

      doom-theme 'modern-catppuccin-latte

      display-line-numbers-type t
      confirm-kill-emacs nil
      auto-save-default t
      make-backup-files t)

(add-hook 'tty-setup-hook #'xterm-mouse-mode)
