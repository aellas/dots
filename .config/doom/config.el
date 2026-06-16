;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Zac Pizzey"
      user-mail-address "zacpi@pm.me")

(use-package! dashboard
  :config
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-items '((recents   . 7)
                          (projects  . 5)
                          (bookmarks . 3)
                          (agenda    . 5))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-icon-type 'nerd-icons)
  (dashboard-setup-startup-hook))
;; Font settings
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 24))
(setq doom-theme 'doom-tokyo-night)
;; Line numbers
(setq display-line-numbers-type t)
(custom-set-faces!
  '(variable-pitch :family "Iosevka Nerd Font"))
;; Mouse support in terminal
(xterm-mouse-mode 1)

;; Dired settings
(setq dired-listing-switches "-alh --group-directories-first")

;; Treemacs
(setq treemacs-show-hidden-files t)

;; Image file handling
(add-to-list 'auto-mode-alist '("\\.png\\'"  . image-mode))
(add-to-list 'auto-mode-alist '("\\.jpe?g\\'" . image-mode))
(add-to-list 'auto-mode-alist '("\\.gif\\'"  . image-mode))
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . json-mode))
(add-to-list 'auto-mode-alist '("waybar/config\\'" . json-mode))


;; Vterm
(use-package! multi-vterm
  :after vterm)

;; Misc
(setq confirm-kill-emacs nil)
(setq auto-save-default t
      make-backup-files t)
(add-hook 'prog-mode-hook #'rainbow-mode)

;; Modeline
(setq doom-modeline-enable-word-count t)

;; Org
(setq org-directory "~/org/")
(after! org (setq org-hide-emphasis-markers t))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(add-hook 'emacs-startup-hook
          (lambda ()
            (let ((mgs-list '("Welcome to emacs, the thermonuclear editor."
                              "You enter to Out Space. Emacs on."
                              "Nice day for Emacsing!")))
              (message (nth (random (length mgs-list)) mgs-list)))))

;; AI - gptel
(use-package! gptel
  :config
  (gptel-make-openai "OpenWebUI"
    :host "serfor:3001"
    :protocol "http"
    :key "sk-1c85fa6c50d148b7bb0966468fd66101"
    :endpoint "/api/chat/completions"
    :stream t
    :models '(lfm2.5:latest))
  (setq! gptel-backend (gptel-get-backend "OpenWebUI")
         gptel-model 'lfm2.5:latest
         gptel-default-mode 'markdown-mode))

(use-package! gptel-autocomplete
  :after gptel
  :config
  (setq gptel-autocomplete-before-context-lines 100
        gptel-autocomplete-after-context-lines 20
        gptel-autocomplete-temperature 0.1
        gptel-autocomplete-idle-delay 0.5)

  (keymap-set gptel-autocomplete-completion-map "TAB"   #'gptel-accept-completion)
  (keymap-set gptel-autocomplete-completion-map "<tab>" #'gptel-accept-completion)
  (keymap-set gptel-autocomplete-completion-map "M-f"   #'gptel-accept-word)

  (add-hook 'prog-mode-hook #'gptel-autocomplete-mode))

(map! :leader
      (:prefix ("k" . "AI")
       :desc "gptel chat"           "c" #'gptel
       :desc "gptel send"           "s" #'gptel-send
       :desc "gptel rewrite"        "r" #'gptel-rewrite
       :desc "gptel add context"    "a" #'gptel-add
       :desc "gptel add file"       "f" #'gptel-add-file
       :desc "gptel menu"           "m" #'gptel-menu
       :desc "gptel abort"          "x" #'gptel-abort
       :desc "gptel toggle log"     "l" #'gptel-toggle-log
       :desc "gptel system prompt"  "p" #'gptel-system-prompt))
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'olivetti-mode)

(setq gptel-include-reasoning nil)
;; Org settings
(after! org
  (setq org-directory "~/org/"
        org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-pretty-entities t
        org-ellipsis "  ·"
        org-adapt-indentation t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)

  ;; Resize headings - using your Iosevka font
  (dolist (face '((org-level-1 . 1.35)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :weight 'bold :height (cdr face)))

  ;; Keep code blocks in fixed-pitch
  (set-face-attribute 'org-block nil        :foreground nil :inherit 'fixed-pitch :height 0.85)
  (set-face-attribute 'org-code nil         :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-verbatim nil     :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-checkbox nil     :inherit 'fixed-pitch)
  (set-face-attribute 'org-meta-line nil    :inherit '(font-lock-comment-face fixed-pitch))

  (require 'org-indent)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch)))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿")
        org-modern-table t
        org-modern-checkbox '((?X . "✅") (?- . "➖") (?\s . "☐"))))
(after! org
  (setq org-startup-indented t
        org-cycle-separator-lines 2))

(add-hook 'org-mode-hook (lambda ()
                           (setq line-spacing 0.3)))
(after! org
  (setq org-startup-indented t
        org-cycle-separator-lines 2))

(add-hook 'org-mode-hook (lambda ()
                           (setq line-spacing 0.3)))
(after! org
  (setq org-hide-drawer-startup t
        org-startup-folded 'content))
;; olivetti - centered text width
(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

(use-package! orgnote
  :hook (org-mode . orgnote-autosync-mode)
  :custom
  (orgnote-debug-p t))

(map! :leader
      :prefix ("n" . "notes")
      :desc "Publish file"     "p" #'orgnote-publish-file
      :desc "Force sync"       "s" #'orgnote-force-sync
      :desc "Sync"             "s" #'orgnote-sync)

(setq treesit-language-source-alist
      '((toml "https://github.com/tree-sitter/tree-sitter-toml")))

