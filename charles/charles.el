;;; package charles.el
;;; Charles Jackson

(defun round-money (n)
  "Truncate a N to two decimal places"
  (/ (ceiling (* 100 n)) 100.0))

(defun insert-buffer-name ()
  (interactive)
  (insert (buffer-name (current-buffer))))

(defun increment-number-at-point (&optional arg)
  "Increment the number at point by ARG."
  (interactive "p*")
  (let ((spot (point)))
    (skip-chars-backward "[[:digit:]]")
    (when (looking-at "[[:digit:]]")
      (let ((num (buffer-substring-no-properties (point) (progn (skip-chars-forward "[[:digit:]]") (point)))))
        (delete-char (- (length num)))
        (insert (number-to-string (+ (string-to-number num) (if arg arg 1))))))
    (goto-char spot)))

(defun save-all ()
  "Save all buffers."
  (interactive)
  (message "Saving all changes...")
  (if (save-some-buffers t)
      (message "Saved")
    (message "(No changes need to be saved)")))

(defun pop-to-recent-buffer ()
  "Move point to the buffer that it was in last."
  (interactive)
  (pop-to-buffer (other-buffer (current-buffer) t)))


;;; cli-mode
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

;;; drag buffer
(defmacro drag-buffer (to from)
  (let ((to-string (symbol-name to))
        (from-string (symbol-name from)))
    `(defun ,(intern (concat "drag-buffer-" to-string)) ()
       (interactive)
       (let ((current-buffer (current-buffer)))
         (,(intern (concat "windmove-" to-string)))
         (let ((alternate-buffer (current-buffer)))
           (switch-to-buffer current-buffer)
           (,(intern (concat "windmove-" from-string)))
           (switch-to-buffer alternate-buffer)
           (,(intern (concat "windmove-" to-string))))))))

(drag-buffer left right)
(drag-buffer right left)
(drag-buffer up down)
(drag-buffer down up)

;;; insert ticket in commits from branch name
(defgroup insert-ticket ()
  "Customization related to automatically inserting the ticket number into the commit message.")

(defcustom insert-ticket-commit-processor 'surround-brackets
  "The function to be used on the ticket string before inserting into the commit message."
  :type 'symbol
  :group 'insert-ticket)

(defcustom insert-ticket-default-ticket ""
  "The ticket to use if there is no ticket in the branch name."
  :type 'string
  :group 'insert-ticket)

(defun append-hyphen (string)
  (concat string " - "))

(defun surround-brackets (string)
  (concat "[" string "] "))

(defun current-ticket ()
  (let* ((branch-name (remove ?\n (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))
         (first-hyphen (or (seq-position branch-name ?-) 0))
         (after-first-hyphen (substring branch-name (+ first-hyphen 1)))
         (second-hyphen (or (seq-position after-first-hyphen ?/)
                            (seq-position after-first-hyphen ?-)))
         (second-hyphen (if second-hyphen
                            (+ first-hyphen second-hyphen 1)
                          (length branch-name)))
         (ticket-name (substring branch-name 0 second-hyphen))
         (ticket-number (substring ticket-name (+ first-hyphen 1) second-hyphen)))
    (if (or (/= 0 (string-to-number ticket-number))
            (string= ticket-number "0"))
        ticket-name
      insert-ticket-default-ticket)))

(defun insert-ticket ()
  (interactive)
  (when (= (point) (point-min))
    (let* ((ticket-name (current-ticket)))
      (unless (string= "" insert-ticket-default-ticket)
        (insert (funcall ticket-insert-commit-processor
                         insert-ticket-default-ticket))))))

(provide 'charles)
;;; charles.el ends here
