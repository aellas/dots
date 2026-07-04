;;; modules/ui.el -*- lexical-binding: t; -*-

(setq doom-font
      (font-spec :family "Iosevka Nerd Font" :size 25)

      doom-variable-pitch-font
      (font-spec :family "Iosevka Nerd Font")

      doom-theme 'doom-tokyo-night

      display-line-numbers-type t
      confirm-kill-emacs nil
      auto-save-default t
      make-backup-files t)

(xterm-mouse-mode 1)

;; Maintain terminal transparency in Doom Emacs
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

;; remove top frame bar in emacs
(add-to-list 'default-frame-alist '(undecorated . t))
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-lsp-icon t)
(setq doom-modeline-major-mode-color-icon t)
(set-frame-parameter (selected-frame) 'alpha '(96 . 97))
(add-to-list 'default-frame-alist '(alpha . (96 . 97)))
(blink-cursor-mode 1)
(setq gc-cons-threshold (* 256 1024 1024))
(setq read-process-output-max (* 4 1024 1024))
(setq comp-deferred-compilation t)
(setq comp-async-jobs-number 8)

;; Garbage collector optimization
(setq gcmh-idle-delay 5)
(setq gcmh-high-cons-threshold (* 1024 1024 1024))

;; Version control optimization
(setq vc-handled-backends '(Git))

;; Fix x11 issues
(setq x-no-window-manager t)
(setq frame-inhibit-implied-resize t)
(setq focus-follows-mouse nil)
(setq delete-by-moving-to-trash t)
;; Save automatically
(setq auto-save-default t)
