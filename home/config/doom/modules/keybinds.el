;; home/config/doom/modules/keybinds.el -*- lexical-binding: t; -*-

;; Comment Line
(map! :leader
      :desc "Comment line" "-" #'comment-line)

;; Orgnote
(map! :leader
      :desc "orgnote"
      "o n s" #'orgnote-sync
      "o n f" #'orgnote-force-sync
      "o n c" #'orgnote-open-configuration)

;; Calander
(map! :leader
      :desc "calendar"
      "@" #'calendar)

;; Calculator
(map! :leader
      :desc "quick-calc"
      "=" #'quick-calc)

;; Empv
(map! :leader
      :desc "empv-seach"
      "m s" #'empv-subsonic-search
      "m a" #'empv-subsonic-artists
      "m x" #'empv-subsonic-albums
      "m c" #'empv-display-current
      "m m" #'empv-toggle
      "m n" #'empv-playlist-next
      "m p" #'empv-playlist-prev
      "m q" #'empv-exit)

;; Ghostel
(map! :leader
      :desc "ghostel"
      "o t" #'ghostel)
