;;; home/config/doom/modules/orgnote.el -*- lexical-binding: t; -*-

(use-package! orgnote
  :hook (org-mode . orgnote-autosync-mode)
  :init
  (setq orgnote-debug-p t)
  
  :config
  (map! :map org-mode-map
        "C-c n p" #'orgnote-publish-file
        "C-c n f" #'orgnote-force-sync
        "C-c n s" #'orgnote-sync))
