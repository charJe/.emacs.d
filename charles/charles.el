;;; package charles.el
;;; Charles Jackson

(require 'dash)

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
(defmacro drag-buffer (to)
  (let ((to-string (symbol-name to)))
    `(defun ,(intern (concat "drag-buffer-" to-string)) ()
       (interactive)
       (let ((current-buffer (current-buffer))
             (current-window (selected-window)))
         (,(intern (concat "windmove-" to-string)))
         (let ((alternate-buffer (current-buffer)))
           (switch-to-buffer current-buffer)
           (select-window current-window)
           (switch-to-buffer alternate-buffer)
           (,(intern (concat "windmove-" to-string))))))))

(drag-buffer left)
(drag-buffer right)
(drag-buffer up)
(drag-buffer down)

;;; insert ticket in commits from branch name
(defgroup insert-ticket ()
  "Customization related to automatically inserting the ticket number into the commit message.")

(defcustom insert-ticket-commit-processor 'append-hyphen
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

(defun ticketp (string)
  (let* ((parts (split-string string "-" :omit-nulls))
         (number (cadr parts)))
    (/= 0 (string-to-number (or number "")))))

(defun current-branch ()
  (remove ?\n (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))

(defun current-ticket ()
  (let ((part-with-ticket
         (cl-find-if #'ticketp
                     (split-string (current-branch) "/"
                                   :omit-nulls))))
    (upcase
     (if (null part-with-ticket)
         insert-ticket-default-ticket
       (let* ((ticket-parts (split-string part-with-ticket
                                          "-" :omit-nulls))
              (ticket-number (cadr ticket-parts)))
         (concat (car ticket-parts)
                 "-"
                 ticket-number))))))

(defun insert-ticket ()
  "Insert the current ticket at point."
  (interactive)
  (when (and (= (point) (point-min))
             (looking-at (rx line-end)))
    (let* ((ticket-name (current-ticket)))
      (unless (string= "" ticket-name)
        (insert (funcall insert-ticket-commit-processor ticket-name))))))

;;; sql utility
(defun pg-connect (connection &optional buf-name)
  (interactive
   (if sql-connection-alist
       (list (sql-read-connection "Connection: ")
             current-prefix-arg)
     (user-error "No SQL Connections defined")))
  (->> sql-connection-alist
       (assoc connection) cdr
       (assoc 'sql-password) cadr
       (setenv "PGPASSWORD"))
  (sql-connect connection buf-name))

(provide 'charles)
;;; charles.el ends here
