;;; home/config/doom/lsp.el -*- lexical-binding: t; -*-

(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-completion-provider :capf

        ;; Disable expensive/unnecessary overhead
        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil

        ;; KEEP these for a professional DX
        lsp-enable-snippet t
        lsp-enable-symbol-highlighting t
        lsp-enable-links t

        ;; Language Specifics: Go
        lsp-go-hover-kind "FullDocumentation"
        lsp-go-analyses '((nilness . t)
                          (unusedwrite . t)
                          (unusedparams . t))
        lsp-gopls-completeUnimported t
        lsp-gopls-staticcheck t))

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-max-height 10
        lsp-ui-doc-max-width 80
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-delay 0.5
        lsp-ui-sideline-enable nil
        lsp-ui-peek-enable t))
