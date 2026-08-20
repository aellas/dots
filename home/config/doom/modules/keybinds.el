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

;; Ghostel
(map! :leader
      :desc "ghostel"
      "o t" #'+ghostel/toggle)

(map! :leader
      :desc "SSH Serfor" 
      "es" (lambda () (interactive) 
             (find-file "/ssh:array@serfor:~/pods")))
