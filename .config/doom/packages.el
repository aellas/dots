;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! dashboard)
(package! ligature)
(package! multi-vterm)
(package! treemacs)
(package! git-cliff)
(package! org-superstar)
(package! format-all)
(package! json-mode)
(package! rainbow-mode)
(package! gptel :recipe (:nonrecursive t))
(package! gptel-autocomplete
  :recipe (:host github
           :repo "JDNdeveloper/gptel-autocomplete"))
(package! olivetti)
(package! orgnote
  :recipe (:host github :repo "Artawower/orgnote.el" :branch "dev"))
