;;;; init.el
;;;; Charles Jackson
(progn ;package setup
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (require 'use-package))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(auto-save-file-name-transforms nil)
 '(auto-save-visited-mode t)
 '(backup-directory-alist (\` (("." . "~/.emacs.d/saves"))))
 '(battery-mode-line-format " [%b%p%%] ")
 '(beacon-color "#d33682")
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(delete-selection-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote light))
 '(frame-title-format "Emacs" t)
 '(gud-pdb-command-name "python -m pdb")
 '(hs-allow-nesting t t)
 '(hs-hide-comments-when-hiding-all nil)
 '(hs-isearch-open t)
 '(ido-mode (quote both) nil (ido))
 '(indent-tabs-mode nil)
 '(inferior-lisp-program "sbcl")
 '(inhibit-startup-screen t)
 '(initial-scratch-message
   "
;;    C-x        Hold Ctrl and press x
;;    M-x        Hold Meta (Alt) and press x
;;    C-x y      Hold Ctrl and press x then press just y

;;    C-Space    Select text
;;    C-w        Cut text
;;    M-w        Copy text
;;    C-y        Paste text
;;    M-y        Paste previous text

;;    C-x C-f    Open file
;;    C-x |      Split window vertically
;;    C-x _      Split window horizontally
;;    C-x b        Switch buffer in current window
;;    C-q        Move window into background
;;    C-o        Cycle focus between windows

;;    C-M-x      Eval last lisp s-exp
;;    C-j        Eval last lisp s-exp and display output
;;    C-M-t      Transpose s-exp
;;    Press F1 or C-? for further help.

")
 '(menu-bar-mode nil)
 '(org-agenda-default-appointment-duration 60)
 '(org-bullets-bullet-list (quote ("●")))
 '(org-hide-emphasis-markers t)
 '(org-icalendar-use-deadline (quote (event-if-not-todo event-if-todo todo-due)))
 '(org-icalendar-use-scheduled (quote (event-if-not-todo event-if-todo)))
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   (quote
    (diminish ivy cider clojure-mode polymode yasnippet yaml-mode windresize use-package typescript-mode treemacs togetherly sly rust-mode restclient rainbow-delimiters racket-mode pcre2el multiple-cursors mips-mode magit kotlin-mode htmlize go-mode gnuplot-mode expand-region ess es-windows es-lib elixir-mode eglot dart-mode company color-theme-sanityinc-solarized bnf-mode bison-mode bfbuilder auctex)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote left))
 '(tool-bar-style (quote image))
 '(tooltip-mode nil)
 '(treemacs-collapse-dirs 3)
 '(treemacs-display-in-side-window nil)
 '(treemacs-filewatch-mode t)
 '(treemacs-follow-mode t)
 '(treemacs-fringe-indicator-mode t)
 '(wdired-allow-to-change-permissions t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-marker-1 ((t (:inherit cursor))))
 '(company-scrollbar-bg ((t (:inherit (quote company-tooltip) :background "gray36"))))
 '(company-scrollbar-fg ((t (:background "gray50"))))
 '(company-tooltip ((t (:background "dim gray" :foreground "dark gray"))))
 '(company-tooltip-selection ((t (:background "gray44" :foreground "white smoke"))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(sly-error-face ((t (:inherit flymake-error))))
 '(sly-note-face ((t (:inherit flymake-note))))
 '(sly-style-warning-face ((t (:inherit flymake-warning))))
 '(sly-warning-face ((t (:inherit flymake-warning)))))
(use-package charles
  :load-path "~/.emacs.d/charles/"
  :hook ((prog-mode . add-prog-pretty-symbols)
         (prog-mode . prettify-symbols-mode))
  :bind (("C-M-y" . insert-lambda)
         ("H-y" . insert-lambda)
         ("C-x s" . save-all)
         ("C-c =" . increment-number-at-point)
         ("C-c -" . (lambda (arg) (interactive "p*") (increment-number-at-point (- arg))))
         ("H-=" . increment-number-at-point)
         ("H--" . (lambda (arg) (interactive "p*") (increment-number-at-point (- arg))))
         ("<M-up>" . move-line-up)
         ("<M-down>" . move-line-down)
         ("C-c C-f" . insert-file-name)
         ("H-f" . insert-file-name)))
(use-package quick-theme
  :load-path "~/.emacs.d/charles/"
  :config (progn ;themes
            (q-th sl 'sanityinc-solarized-light)
            (q-th sd 'sanityinc-solarized-dark)
            (q-th wom 'wombat)
            (sl)))
(use-package tool-bar-mode
  :bind ("<f9>" . tool-bar-mode))
(use-package window
  :functions other-window
  :bind (("C-o" . (lambda () (interactive) (other-window 1)))
         ("M-o" . (lambda () (interactive) (other-window -1)))
         ("C-q" . delete-window)
         ("s-q" . delete-window)
         ("M-q" . (lambda () (interactive) (kill-buffer (current-buffer))))
         ("s-b" . switch-to-buffer)
         ("C-x |" . split-window-right)
         ("C-x _" . split-window-below)))
(use-package windresize
  :bind (("s-w" . windresize)))
(use-package windmove
  :bind (("C-s-f" . windmove-right) ("<C-s-right>" . windmove-right)
         ("C-s-n" . windmove-down) ("<C-s-down>" . windmove-down)
         ("C-s-b" . windmove-left) ("<C-s-left>" . windmove-left)
         ("C-s-p" . windmove-up) ("<C-s-up>" . windmove-up)))
(use-package expand-region
  :bind (("C-=" . er/expand-region)))
(use-package treemacs
  :bind (("C-c d" . treemacs)))
(use-package multiple-cursors
  :bind (("C-c M-e" . mc/edit-lines)
         ("C->"     . mc/mark-next-like-this)
         ("C-c M->" . mc/skip-to-next-like-this)
         ("C-<"     . mc/mark-previous-like-this)
         ("C-c M-<" . mc/skip-to-previous-like-this)
         ("C-c C-a" . mc/mark-all-like-this)))
(use-package compile
  :bind (("ESC <f5>" . compile)
         ("<f5>"     . recompile)))
(use-package sgml-mode ;html
  :after (prog-mode)
  :functions sgml-close-tag
  :preface
  (progn
    (defun html-/-close-tag ()
      (interactive)
      (insert "/")
      (when (= ?< (char-before (1- (point))))
        (backward-delete-char 2)
        (sgml-close-tag)
        (when (= ?> (char-after))
          (delete-char 1))))
    (defun html-=-quotes ()
      (interactive)
      (insert "=")
      (when (save-excursion
              (beginning-of-line)
              (looking-at ".*<\\([^<>]\\|\n\\)*="))
        (insert "\"\"")
        (backward-char 1))))
  :bind (:map html-mode-map
              ("/" . html-/-close-tag)
              ("=" . html-=-quotes)
              ("C-M-f" . sgml-skip-tag-forward)
              ("C-M-b" . sgml-skip-tag-backward))
  :hook ((html-mode . flyspell-mode-off)
         (html-mode . sgml-electric-tag-pair-mode))
  :config
  ;; (setq html-mode-hook (append html-mode-hook prog-mode-hook))
  (dolist (mode '(html-mode mhtml-mode))
    (setf (alist-get mode hs-special-modes-alist)
          '("<[^</>]+>" "</[^<>]+>" "<!--" sgml-skip-tag-forward nil))))
(use-package apropos
  :bind (("<help> a" . apropos)))
(use-package simple
  :hook ((prog-mode . (lambda () (toggle-truncate-lines 1)))
         ;; (text-mode . (lambda () (visual-line-mode 1)))
         )
  :bind (("M-k" . kill-whole-line)
         ("M-'" . quoted-insert)
         ("C-M-h" . backward-kill-word))
  :config
  (progn
    (define-key key-translation-map (kbd "C-?") (kbd "<help>"))
    (define-key key-translation-map (kbd "C-h") (kbd "DEL"))))
(use-package subword
  :hook ((java-mode . subword-mode)
         (dart-mode . subword-mode)
         (web-mode . subword-mode)
         (c++-mode . subword-mode)
         (c-mode . subword-mode)))
(use-package yasnippet
  :hook ((prog-mode . yas-minor-mode)
         (org-mode . yas-minor-mode)))
(use-package company
  :diminish "co"
  :hook (((prog-mode sly-mrepl-mode) . company-mode))
  :bind (:map company-mode-map ("M-/" . company-complete)))
(use-package hideshow
  :hook ((prog-mode . hs-minor-mode))
  :bind (:map hs-minor-mode-map
              ("<C-tab>" . hs-toggle-hiding)
              ("C-c h a" . hs-hide-all)
              ("C-c h s" . hs-show-all)
              ("C-c h l" . hs-hide-level)))
(use-package misc
  :bind (("M-z" . zap-up-to-char)))
(use-package newcomment
  :bind (("C-;" . comment-line)))
(use-package cc-mode
  :hook ((c-mode . (lambda () (c-set-style "cc-mode")))
         (c++-mode .  (lambda () (c-set-style "cc-mode")))))
(use-package dart-mode
  :after (charles)
  :bind (("C-x C-r"   . flutter-hot-reload)
         ("C-x C-S-r" . flutter-state-reload)))
(use-package flyspell
  :hook ((text-mode . flyspell-mode))
  :bind (:map flyspell-mode-map
              ([mouse-3] . flyspell-correct-word)))
(use-package org
  :hook ((org-mode . org-indent-mode)
         (org-mode . org-toggle-pretty-entities)))
(use-package elisp-mode
  :bind (:map emacs-lisp-mode-map
              ("ESC <f5>" . emacs-lisp-byte-compile-and-load)
              ("<f5>"     . eval-buffer)))
(use-package rainbow-delimiters
  :hook ((lisp-mode emacs-lisp-mode clojure-mode) . rainbow-delimiters-mode))
(use-package togetherly)
(use-package magit
  :bind (("C-x v g" . magit)))
(use-package eglot
  :hook (((java-mode c-mode c++-mode python-mode html-mode css-mode clojure-mode) . eglot-ensure))
  :bind (:map eglot-mode-map
              ("<S-f6>" . eglot-rename))
  :config
  (progn
    (setenv "CLASSPATH"
            (concat (getenv "CLASSPATH") ":/home/charles/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.500.v20190715-1310.jar"))
    (add-to-list 'eglot-server-programs '(clojure-mode . ("bash" "-c" "clojure-lsp")))
    (add-to-list 'eglot-server-programs '(html-mode . ("html-languageserver" "--stdio")))
    (add-to-list 'eglot-server-programs '(css-mode . ("css-languageserver" "--stdio")))
    (add-to-list 'eglot-server-programs '(typescript-mode . ("javascript-typescript-stdio")))
    (add-to-list 'eglot-server-programs '(js-mode . ("javascript-typescript-stdio")))
    (add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
    (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
    (add-to-list 'eglot-server-programs '(rust-mode . ("rls")))
    (add-to-list 'eglot-server-programs '(elixir-mode . ("~/elixir-ls/release/language_server.sh")))))
(use-package extra-font-lock
  :load-path "~/.emacs.d/charles/"
  :config (progn ;extra highlighting
            (add-extra-syntax c-like-operators
                              'c-mode 'c++-mode 'java-mode 'rust-mode 'typescript-mode 'js-mode 'dart-mode 'sql-mode 'bison-mode)
            (add-extra-syntax regexp-operators 'flex-mode)
            (add-extra-syntax r-operators 'ess-r-mode 'inferior-ess-r-mode)
            (add-extra-syntax python-operators 'python-mode)))
(use-package poly-lisp-html
  :load-path "~/quicklisp/dists/quicklisp/software/markup-20191130-git/")
(use-package polymode
  :after (poly-lisp-html)
  :mode ("\\.htmlisp$" . poly-lisp-html-mode))
(use-package autorevert
  :diminish ""
  :config (global-auto-revert-mode))
(progn ;init
  (find-file "~/.emacs.d/init.el")
  (dolist (fun '(upcase-region down-case-region)) (put fun 'disabled nil))
  (let ((x (+ 14 (car (frame-position))))
        (y (+ 14 (cdr (frame-position))))
        (width (* 130 (frame-char-width)))
        (height (* 47 (frame-char-height))))
    (set-frame-position (selected-frame)
                        (abs (- x (/ (- width (frame-pixel-width)) 2) 32))
                        (abs (- y (- height (frame-pixel-height)))))
    (set-frame-size (selected-frame) width height :pixelwise))
  (set-frame-font "Borg Sans Mono 14")
  (setq-default line-spacing .2)
  (switch-to-buffer "*scratch*"))
