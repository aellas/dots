;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company +auto)
 (vertico +icons)

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
 vi-tilde-fringe
 window-select
 
 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 multiple-cursors

 :emacs
 tramp
 vc
 (dired +icons)
 electric
 (ibuffer +icons)
 (undo +tree)

 :term
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
 pdf
 tree-sitter

 :lang
 bash
 sh
 (c +lsp)
 css
 docker
 html
 (json +lsp)
 markdown
 (nix +tree-sitter +lsp)
 toml
 yaml
 (lua +lsp +treesitter)
 (python +lsp +treesitter)
 (org +brain +dragndrop +noter +pomodoro +present +roam2)
 emacs-lisp

 :config
 (default +bindings +smartparens))
