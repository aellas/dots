;;; home/config/doom/modules/dired.el -*- lexical-binding: t; -*-

(setq dired-listing-switches "-alh --group-directories-first"
      treemacs-show-hidden-files t)
(after! dired
  (setq mouse-1-click-follows-link nil))
