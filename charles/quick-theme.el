;;; package quick-theme.el
;;; Charles Jackson

(defun disable-all-themes ()
  "Disable all custom themes."
  (interactive)
  (dolist (th custom-enabled-themes)
    (disable-theme th)))

(defmacro q-th (name theme)
  "Create a function named NAME that loads theme THEME."
  `(defun ,name ()
     ,(concat "Load theme: " (symbol-name (eval theme)))
     (interactive)
     (disable-all-themes)
     (load-theme ,theme)))

(provide 'quick-theme)
;;; quick-theme.el ends here
