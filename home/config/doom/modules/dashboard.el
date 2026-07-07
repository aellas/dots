;;; home/config/doom/modules/dashboard.el -*- lexical-binding: t; -*-

(use-package! dashboard
  :ensure t 
  :config

  (setq dashboard-navigation-cycle t
        dashboard-week-agenda t
        dashboard-set-init-info nil
        dashboard-set-footer nil
        dashboard-agenda-prefix-format " %-4s - %t"
        dashboard-agenda-format-item-string "%s"
        dashboard-projects-backend 'projectile
        dashboard-startup-banner "~/.config/doom/modules/ascii.txt"
        dashboard-center-content t
        dashboard-items
        '((recents . 7)
          (projects . 5)
          (bookmarks . 3)
          (agenda    . 3))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-icon-type 'nerd-icons))

(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-init-info
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-items))

(setq dashboard-item-names '(("Recent Files:"               . "Recently opened files:")
                             ("Agenda for today:"           . "Today's agenda:")
                             ("Agenda:" . "Agenda:")))

