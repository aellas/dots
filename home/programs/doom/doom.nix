{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs-pgtk
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
     treemacs

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
     (c +lsp)
     css
     docker
     html
     (jsom +lsp)
     markdown
     (nix +tree-sitter +lsp)
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
  (setq doom-theme 'doom-nord)
  (setq display-line-numbers-type 'relative)
  ;; Force vterm to use the same font as your terminal
(add-hook 'vterm-mode-hook
          (lambda ()
            (set (make-local-variable 'buffer-face-mode-face) '(:family "JetBrainsMono Nerd Font" :height 110))
            (buffer-face-mode t)))

;; Make sure fixed-pitch uses Nerd Font too
(set-face-attribute 'fixed-pitch nil :family "JetBrainsMono Nerd Font")


  ;; Change Nerd Font family
  (setq nerd-icons-font-family "Ubuntu Nerd Font")
  (setq doom-font "JetBrainsMono Nerd Font:pixelsize=14:weight=semi-bold")

  ;; Hide hidden files by default
  (setq treemacs-show-hidden-files nil)
  ;; Ensure images open in image-mode
  (add-to-list 'auto-mode-alist '("\\.png\\'" . image-mode))
  (add-to-list 'auto-mode-alist '("\\.jpg\\'" . image-mode))
  (add-to-list 'auto-mode-alist '("\\.jpeg\\'" . image-mode))
  (add-to-list 'auto-mode-alist '("\\.gif\\'" . image-mode))
 ;; Show image previews
   (setq dired-listing-switches "-alh --group-directories-first")
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered by Doom Emacs")))

(defun ghost ()
  (let* ((banner '( "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⡤⣤⢤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠉⠻⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠏⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠈⢻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠯⠀⠀⠀⢰⣿⣿⣿⣆⡀⣴⣾⣿⣦⡈⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣏⠀⠀⠀⠀⢸⣿⣿⣿⡿⠇⣿⣿⣿⣿⠆⠘⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠈⠿⠿⡿⠃⠀⢿⣿⣿⠏⠀⠀⢹⣗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⡐⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠘⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⡁⡿⠄⠀⢀⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠂⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⣻⡷⠀⠠⣼⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣦⠀⠘⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⢠⡿⠃⠀⢡⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠸⣿⠆⠀⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⢀⣿⠓⠀⠀⣼⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡧⠀⠀⠹⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⢰⣾⡃⠀⠀⠀⣿⡄⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⡀⠀⢮⠿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⣨⡿⠃⠀⠀⠀⢠⡿⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠁⠚⣷⡀⠀⣀⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⣠⡾⠋⠀⠀⠀⠰⠀⢸⣇⠀⠀⠀⠀⠀⠀⠈⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⡿⠛⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠐⠿⠶⠶⠶⢤⣤⣤⣤⣼⣇⠀⠀⠀⠀⠀⡀⠀⡘⣷⠀⠀⠀⠀⠀⠀⠀⠈⢀⠀⠈⣿⣄⠀⠃⠀⠀⠀⠀⠀⠀ ⠀"
                    "⠀⠀⠀⢀⠀⠀⠁⢻⣏⠉⣿⡀⠀⠀⠀⠘⠅⠀⣈⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⡄⠀⠀⠀⠀⠀⠀⠀ ⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⢻⣶⡿⠃⠀⠀⢀⣬⣾⣿⡻⠋⣿⡆⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⡿⠯⠶⠾⠛⠁⠈⠘⣷⣿⠏⠀⢀⣴⠾⠋⠉⠉⠉⠙⠉⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⣮⠷⠟⠉⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                    "                                           "
                    "                                           "
                    "                                           "
                    "                                           "

  ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'ghost)
'';

  home.file.".doom.d/packages.el".text = ''
    ;;; packages.el -*- lexical-binding: t; -*-
     (package! ligature)
  '';
}
