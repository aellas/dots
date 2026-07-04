;;; home/config/doom/lsp.el -*- lexical-binding: t; -*-

;; LSP Performance optimizations and settings
(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-completion-provider :capf
        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil
        lsp-enable-snippet nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-links nil
        ;; Go-specific settings
        lsp-go-hover-kind "FullDocumentation"  ; CHANGED: was "Synopsis"
        lsp-go-analyses '((nilness . t)        ; CHANGED: removed fieldalignment
                          (unusedwrite . t)
                          (unusedparams . t))
        ;; Register custom gopls settings
        lsp-gopls-completeUnimported t
        lsp-gopls-staticcheck t
        lsp-gopls-analyses '((unusedparams . t)
                             (unusedwrite . t))))
;; LSP UI settings for better performance
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 72
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-delay 0.5
        lsp-ui-sideline-enable nil
        lsp-ui-peek-enable t))

(after! project
  ;; Master project detection function - extensible for all project types
  (add-hook 'project-find-functions
            (lambda (dir)
              (cond
               ;; Go projects
               ((locate-dominating-file dir "go.mod")
                (cons 'transient (locate-dominating-file dir "go.mod")))

               ;; Rust projects
               ((locate-dominating-file dir "Cargo.toml")
                (cons 'transient (locate-dominating-file dir "Cargo.toml")))

               ;; Node.js projects
               ((locate-dominating-file dir "package.json")
                (cons 'transient (locate-dominating-file dir "package.json")))

               ;; Python projects (multiple markers)
               ((or (locate-dominating-file dir "pyproject.toml")
                    (locate-dominating-file dir "setup.py")
                    (locate-dominating-file dir "requirements.txt"))
                (cons 'transient (or (locate-dominating-file dir "pyproject.toml")
                                     (locate-dominating-file dir "setup.py")
                                     (locate-dominating-file dir "requirements.txt"))))

               ;; Generic git projects (fallback)
               ((locate-dominating-file dir ".git")
                (cons 'transient (locate-dominating-file dir ".git")))))))
