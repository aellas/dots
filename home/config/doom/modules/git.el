;;; home/config/doom/git.el -*- lexical-binding: t; -*-

(after! magit
  (setq git-commit-summary-max-length 72))
(defun my/magit-stage-commit-push ()
  "Stage all, commit with quick message, and push with no questions"
  (interactive)
  (magit-stage-modified)
  (let ((msg (read-string "Commit message: ")))
    (magit-commit-create (list "-m" msg))
    (magit-run-git "push" "origin" (magit-get-current-branch))))
