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

  ;; Basic settings
  (xterm-mouse-mode 1)
  (setq doom-theme 'doom-one)
  (setq display-line-numbers-type 'relative)

  ;; Change Nerd Font family
  (setq nerd-icons-font-family "Ubuntu Nerd Font")

  ;; Doom Dashboard customization
  (setq doom-fallback-buffer-name "► Doom"
        doom-dashboard-banner-padding '(1 . 1) ;; Less padding for ASCII
        doom-dashboard-menu-sections
        '(("Open org-agenda" :icon (nerd-icons-octicon "nf-oct-calendar") :action org-agenda)
          ("Recently opened files" :icon (nerd-icons-octicon "nf-oct-history") :action recentf-open-files)
          ("Open project" :icon (nerd-icons-octicon "nf-oct-briefcase") :action projectile-switch-project)
          ("Open config.el" :icon (nerd-icons-octicon "nf-oct-tools") :action (lambda () (find-file "~/.doom.d/config.el")))))

  ;; Custom ASCII banner
  (setq +doom-dashboard-ascii-banner-fn
        (lambda ()
          (insert
           "                        ██████╗ ███╗   ███╗██╗  ██╗\n"
           "                       ██╔════╝ ████╗ ████║██║  ██║\n"
           "                       ██║  ███╗██╔████╔██║███████║\n"
           "                       ██║   ██║██║╚██╔╝██║██╔══██║\n"
           "                       ╚██████╔╝██║ ╚═╝ ██║██║  ██║\n"
           "                        ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝\n"
           "                              Forever, always.\n\n")))'';

  home.file.".doom.d/packages.el".text = ''
    ;;; packages.el -*- lexical-binding: t; -*-
  '';
}
