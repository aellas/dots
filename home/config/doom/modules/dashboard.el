;;; home/config/doom/modules/dashboard.el -*- lexical-binding: t; -*-

(after! dashboard
  (setq dashboard-navigation-cycle t
        dashboard-week-agenda t
        dashboard-agenda-prefix-format " %-4s - %t"
        dashboard-agenda-format-item-string "%s"
        dashboard-projects-backend 'projectile
        dashboard-startup-banner "~/.config/doom/modules/ascii.txt"
        dashboard-center-content t
        dashboard-items
        '((recents . 7)
          (projects . 5)
          (bookmarks . 3)
          (agenda . 5))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-icon-type 'nerd-icons))

(add-hook 'window-setup-hook #'dashboard-open)
