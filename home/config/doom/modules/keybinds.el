;; home/config/doom/modules/keybinds.el -*- lexical-binding: t; -*-

;; Comment Line
(map! :leader
      :desc "Comment line" "-" #'comment-line)

;; Orgnote
(map! :leader
      :desc "Orgnote Sync"
      "o n s" #'orgnote-sync
      "o n f" #'orgnote-force-sync
      "o n c" #'orgnote-open-configuration)

;; Calander
(map! :leader
      :desc "Calendar"
      "@" #'calendar)

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
