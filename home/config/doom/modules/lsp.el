;;; home/config/doom/lsp.el -*- lexical-binding: t; -*-

(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-completion-enable-additional-text-edit t
        lsp-modeline-code-actions-enable t))
