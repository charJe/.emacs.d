;;; package extra-font-lock.el
;;; Charles Jackson

(defconst regexp-operators
  (eval-when-compile (regexp-opt '("\"" "\\" "{" "}" "[" "]" "^" "$" "<" ">" "?" "." "*" "+" "-" "|" "(" ")" "/"))))
(defconst c-like-operators
  (eval-when-compile (regexp-opt '("<" ">" "-" "+" "/" "*" "%" "^" "=" "!" "~" "[" "]" "&" "|" "?" ":" ","))))
(defconst python-operators
  (eval-when-compile (regexp-opt '("<" ">" "-" "+" "/" "*" "%" "^" "=" "!" "~" "[" "]" "&" "|" ":" "{" "}" ","))))
(defconst r-operators
  (eval-when-compile (regexp-opt '("<" ">" "-" "+" "/" "*" "%" "^" "=" "!" "~" "[" "]" "&" "|" "?" ":" "," "$"))))

(defface font-lock-extra-face
  '((t :inherit 'font-lock-function-name-face))
  "Font lock face to describe extra symbols and operators for programming")

(defun add-extra-syntax (regexp &rest modes)
  (dolist (mode modes)
    (font-lock-add-keywords mode `((,regexp . 'font-lock-extra-face)))))

(provide 'extra-font-lock)
;;; extra-font-lock.el ends here
