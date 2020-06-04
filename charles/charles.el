;;; package charles.el
;;; Charles Jackson

(defun insert-lambda ()
  "Insert lambda."
  (interactive)
  (insert "lambda"))

(defun round-money (n)
  "Truncate a N to two decimal places"
  (/ (ceiling (* 100 n)) 100.0))

(defun move-line-up ()
  "Swap the line at point with the previous line."
  (interactive)
  (beginning-of-line)
  (unless (bobp)
    (forward-line 1)
    (transpose-lines -1)
    (forward-line -1))
  (end-of-line nil))

(defun move-line-down ()
  "Swap the line at point with the next line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (end-of-line nil))

(defun save-all ()
  "Save all buffers."
  (interactive)
  (message "Saving all changes...")
  (if (save-some-buffers t)
      (message "Saved")
    (message "(No changes need to be saved)")))

(defun flutter-hot-reload ()
  (interactive)
  (save-all)
  (insert-char-compilation "r")
  (message "Reloading..."))

(defun flutter-state-reload ()
  (interactive)
  (save-all)
  (insert-char-compilation "R")
  (message "Reloading state..."))

(defun cli-mode ()
  "Set the compile buffer to be editable for interative CLIs."
  (interactive)
  (if (not (member 'cli-mode-start-bait compilation-start-hook))
      (progn
        (add-hook 'compilation-start-hook #'cli-mode-start-bait)
        (add-hook 'compilation-finish-functions #'cli-mode-finish-bait))
    (remove-hook 'compilation-start-hook #'cli-mode-start-bait)
    (remove-hook 'compilation-finish-functions #'cli-mode-finish-bait)))

(defun cli-mode-start-bait (process)
  "This is the function that should be added to `compilation-start-mode-hook' for cli mode."
  (pop-to-buffer (get-buffer "*compilation*"))
  (comint-mode)
  (setq inhibit-read-only t)
  (goto-char (point-max)))

(defun cli-mode-finish-bait (process report)
  (pop-to-buffer (get-buffer "*compilation*"))
  (compilation-mode))

(defun insert-char-compilation (character)
  "Jump to compilation buffer, \"press\" CHARACTER, jump back to previous buffer."
  (with-current-buffer (current-buffer)
    (unless (get-buffer "*compilation*")
      (compile "flutter run"))
    (pop-to-buffer (get-buffer "*compilation*"))
    (shell-mode)
    (setq inhibit-read-only t)
    (insert character)
    (comint-send-input)
    (setq inhibit-read-only nil)
    (compilation-mode)
    (delete-window)))

(defun pop-to-recent-buffer ()
  "Move point to the buffer that it was in last."
  (interactive)
  (pop-to-buffer (other-buffer (current-buffer) t)))

(defun sync-org-cal ()
  "Export all org-agenda files to iCal format and move the .ics files to ~/Calendars."
  (interactive)
   (let ((current-buffers (copy-tree (buffer-list)))
         (org-agenda-default-appointment-duration 60))
    (dolist (filename org-agenda-files)
      (save-window-excursion
        (when (file-exists-p filename)
          (let ((buffer (find-file filename)))
            (with-current-buffer buffer
              (org-icalendar-export-to-ics)
              (shell-command "mv *.ics ~/Calendars/"))
            (when (not (member buffer current-buffers))
              (kill-buffer buffer))))))))

(defun ess-compile-r-html ()
  (interactive)
  (compile
   (concat "R --slave -e \"rmarkdown::render('" (buffer-file-name (current-buffer)) "')\"")))

(defun ess-compile-r-pdf ()
  (interactive)
  (compile
   (concat "R --slave -e \"rmarkdown::render('" (buffer-file-name (current-buffer)) "', output_format = 'pdf_document')\"")))

(defun increment-number-at-point (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

;;; pretty symbols
(defun add-pretty-symbols (symbols)
  "Remove the boilerplate of adding symbols."
  (when symbols
    (progn
      (push `(,(car symbols) . ,(cadr symbols)) prettify-symbols-alist)
      (add-pretty-symbols (cddr symbols)))))

(defun add-prog-pretty-symbols ()
  "The usual pretty symbols for programming."
  (add-pretty-symbols
   '("lambda" ?λ
     "->" ?→
     "=>" ?⇒
     "<=" ?≤
     ">=" ?≥)))

(provide 'charles)
;;; charles.el ends here
