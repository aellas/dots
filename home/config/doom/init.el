;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company +auto)
 (vertico +icons)
 vertico           ; includes consult
 (embark +vertico)
 
 :app
 (media +mpd)

 :ui
 doom
 doom-quit
 hl-todo
 modeline
 nav-flash
 ophints
 (popup +defaults)
 ligatures
 smooth-scroll
 treemacs
 window-select

 
 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 multiple-cursors
 snippets

 :emacs
 tramp
 vc
 (dired +dirvish +icons)
 electric
 (ibuffer +icons)
 (undo +tree)

 :term
 ghostel
 vterm

 :checkers
 (syntax +flymake)
 (spell +flyspell)
 grammar

 :tools
 (eval +overlay)
 (lookup +docsets)
 lsp
 (magit +forge)
 tree-sitter
 
 :lang
 bash
 sh
 docker
 (json +lsp)
 markdown
 (nix +tree-sitter +lsp)
 toml
 yaml
 (lua +lsp +treesitter)
 (python +lsp +treesitter)
 (emacs-lisp +lsp +treesitter)
 (org +dragndrop +hugo +pandoc +pomodoro +present +modern +pretty +capture +journal)
 
 :config
 (default +bindings +smartparens))

