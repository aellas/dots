{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs-nox
    git
    ripgrep
    libtool
    cmake
    pkg-config
    ispell
    gcc 
    gnumake 
    cmake
  ];

  

  home.file.".doom.d/init.el".text = ''
    ;;; init.el -*- lexical-binding: t; -*-

    (doom!
     :completion
     (company +auto)
     (vertico +icons)

     :ui
     doom
     doom-dashboard
     doom-quit
     hl-todo
     modeline
     nav-flash
     ophints
     (popup +defaults)
     (ligatures +extra)
     tabs
     vi-tilde-fringe
     window-select

     :editor
     (evil +everywhere)
     file-templates
     fold
     multiple-cursors
     snippets
     word-wrap

     :emacs
     (dired +icons)
     electric
     (ibuffer +icons)
     (undo +tree)
     vc

     :term
     vterm

     :checkers
     (syntax +flymake)
     (spell +flyspell)
     grammar

     :tools
     (eval +overlay)
     (lookup +docsets)
     (magit +forge)
    pdf
     tree-sitter

     :lang
     bash
     c
     css
     docker
     html
     json
     markdown
     (nix +tree-sitter)
     toml
     yaml
     python

     :config
     (default +bindings +smartparens))
  '';

  home.file.".doom.d/config.el".text = ''
    ;;; config.el -*- lexical-binding: t; -*-
    (xterm-mouse-mode 1)
    (setq doom-theme 'doom-one)
    (setq display-line-numbers-type 'relative)
    (setq nerd-icons-font-family "JetBrainsMono Nerd Font")
  '';

  home.file.".doom.d/packages.el".text = ''
    ;;; packages.el -*- lexical-binding: t; -*-
  '';
}
