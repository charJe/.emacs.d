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
 '(backup-directory-alist `(("." . "~/.emacs.d/saves")))
 '(battery-mode-line-format " [%b%p%%] ")
 '(beacon-color "#d33682")
 '(column-number-mode t)
 '(custom-safe-themes
   '("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(delete-selection-mode t)
 '(display-battery-mode t)
 '(display-line-numbers-type 'visual)
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'light)
 '(frame-title-format "Emacs" t)
 '(geiser-default-implementation 'gambit)
 '(gud-pdb-command-name "python -m pdb")
 '(hs-allow-nesting t t)
 '(hs-hide-comments-when-hiding-all nil)
 '(hs-isearch-open t)
 '(ido-mode 'both nil (ido))
 '(ido-separator "
")
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

;;    C-M-x      Eval current lisp s-exp
;;    C-j        Eval last lisp s-exp and display output
;;    C-M-t      Transpose s-exp
;;    Press F1 or C-? for further help.

")
 '(menu-bar-mode nil)
 '(org-agenda-default-appointment-duration 60)
 '(org-bullets-bullet-list '("●"))
 '(org-hide-emphasis-markers t)
 '(org-icalendar-use-deadline '(event-if-not-todo event-if-todo todo-due))
 '(org-icalendar-use-scheduled '(event-if-not-todo event-if-todo))
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   '(geiser yasnippet yaml-mode windresize use-package typescript-mode treemacs togetherly sly rust-mode restclient rainbow-delimiters racket-mode polymode pcre2el multiple-cursors mips-mode magit kotlin-mode julia-mode htmlize go-mode gnuplot-mode expand-region es-windows es-lib elixir-mode eglot diminish dart-mode company color-theme-sanityinc-solarized cider bnf-mode bison-mode bfbuilder auctex))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tool-bar-position 'left)
 '(tool-bar-style 'image)
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
 '(default ((t (:family "Borg Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 139 :width normal))))
 '(column-marker-1 ((t (:inherit cursor))))
 '(company-scrollbar-bg ((t (:inherit 'company-tooltip :background "gray36"))))
 '(company-scrollbar-fg ((t (:background "gray50"))))
 '(company-tooltip ((t (:background "dim gray" :foreground "dark gray"))))
 '(company-tooltip-selection ((t (:background "gray44" :foreground "white smoke"))))
 '(completions-common-part ((t (:inherit minibuffer-prompt))))
 '(diff-context ((t (:inherit default))))
 '(geiser-font-lock-autodoc-current-arg ((t (:inherit font-lock-keyword-face :weight bold))))
 '(geiser-font-lock-autodoc-identifier ((t (:inherit font-lock-function-name-face))))
 '(geiser-font-lock-doc-link ((t (:inherit link))))
 '(geiser-font-lock-doc-title ((t (:inherit org-document-title))))
 '(geiser-font-lock-error-link ((t (:inherit link))))
 '(geiser-font-lock-repl-output ((t (:inherit font-lock-string-face))))
 '(geiser-font-lock-xref-link ((t (:inherit link))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(sly-error-face ((t (:inherit flymake-error))))
 '(sly-note-face ((t (:inherit flymake-note))))
 '(sly-style-warning-face ((t (:inherit flymake-warning))))
 '(sly-warning-face ((t (:inherit flymake-warning))))
 '(tab-bar ((t (:inherit mode-line))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive)))))
(use-package charles
  :load-path "~/.emacs.d/charles/" 
  :hook ((prog-mode . prettify-symbols-mode)
         (prog-mode . add-prog-pretty-symbols))
  :bind (("C-M-y" . insert-lambda)
         ("H-y" . insert-lambda)
         ("C-x s" . save-all)
         ("C-c =" . increment-number-at-point)
         ("C-c -" . (lambda (arg) (interactive "p") (increment-number-at-point (- arg))))
         ("H-=" . increment-number-at-point)
         ("H--" . (lambda (arg) (interactive "p") (increment-number-at-point (- arg))))
         ("<M-up>" . move-line-up)
         ("<M-down>" . move-line-down)
         ("C-c C-f" . insert-file-name)
         ("H-c f" . insert-buffer-name)
         ("s-<" . #'scroll-right) 
         ("s->" . #'scroll-left))
  :config (progn
            (tie '("!=" "!=="))
            (tie '("/="))
            (tie '("==" "===" "=>"))
            (tie '("->"))
            (tie '("<-"))))
(use-package quick-theme
  :load-path "~/.emacs.d/charles/"
  :config (progn ;themes
            (q-th sl 'sanityinc-solarized-light)
            (q-th sd 'sanityinc-solarized-dark)
            (q-th wom 'wombat)
            (sd)))
(use-package tool-bar
  :bind ("<f9>" . tool-bar-mode))
(use-package window
  :commands (split-window-right split-window-below)
  :preface (progn
            (defun other-window-reverse (count)
              (interactive "p") (other-window count))
            (defun split-right-switch ()
              (interactive)
              (split-window-right)
              (other-window 1)
              (call-interactively
               (if ido-mode #'ido-switch-buffer
                 #'switch-to-buffer )))
            (defun split-below-switch ()
              (interactive)
              (split-window-below)
              (other-window 1)
              (call-interactively
               (if ido-mode #'ido-switch-buffer
                 #'switch-to-buffer ))))
  :bind (("C-o" . other-window)
         ("M-o" . other-window-reverse)
         ("C-q" . delete-window)
         ("s-q" . delete-window)
         ("M-q" . (lambda () (interactive) (kill-buffer (current-buffer))))
         ("s-b" . switch-to-buffer)
         ("C-x |" . split-right-switch)
         ("C-x _" . split-below-switch)))
(use-package windresize
  :bind (("s-w" . windresize)))
(use-package windmove
  :bind (("C-s-f" . windmove-right) ("<C-s-right>" . windmove-right)
         ("C-s-n" . windmove-down) ("<C-s-down>" . windmove-down)
         ("C-s-b" . windmove-left) ("<C-s-left>" . windmove-left)
         ("C-s-p" . windmove-up) ("<C-s-up>" . windmove-up)))
(use-package expand-region
  :bind (("C-M-SPC" . er/expand-region)))
(use-package treemacs
  :bind (("C-c d" . treemacs)))
(use-package multiple-cursors
  :bind (("H-c H-c" . mc/edit-lines)
         ("H->"     . mc/mark-next-like-this)
         ("H-c H->" . mc/skip-to-next-like-this)
         ("H-<"     . mc/mark-previous-like-this)
         ("H-c M-<" . mc/skip-to-previous-like-this)
         ("H-c C-a" . mc/mark-all-like-this)))
(use-package compile
  :bind (("ESC <f5>" . compile)
         ("<f5>"     . recompile)))
(use-package sgml-mode ;html
  :after (prog-mode)
  :commands sgml-close-tag
  :preface (progn
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
  :config (progn
            (setq html-mode-hook (append prog-mode-hook html-mode-hook))
            (dolist (mode '(html-mode mhtml-mode))
              (setf (alist-get mode hs-special-modes-alist)
                    '("<[^</>]+>" "</[^<>]+>" "<!--" sgml-skip-tag-forward nil)))))
(use-package apropos
  :bind (("<help> a" . apropos)))
(use-package simple
  :hook ((prog-mode . (lambda () (toggle-truncate-lines 1)))
         (text-mode . (lambda () (visual-line-mode 1))))
  :bind (("M-k" . kill-whole-line)
         ("M-'" . quoted-insert))
  :config (progn
            (bind-key* "C-M-h" #'backward-kill-word)
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
  :hook ((c-mode   . (lambda () (c-set-style "cc-mode")))
         (c++-mode . (lambda () (c-set-style "cc-mode")))))
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
              ("<f5>"     . eval-buffer)
              ("C-M-s-x"  . edebug-defun)))
(use-package rainbow-delimiters
  :hook ((lisp-mode emacs-lisp-mode scheme-mode clojure-mode) . rainbow-delimiters-mode))
(use-package togetherly)
(use-package magit
  :bind (("C-x v g" . magit)))
(use-package eglot
  :hook (((java-mode c-mode c++-mode python-mode html-mode css-mode clojure-mode) . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c r" . eglot-rename)
              ("H-r"     . eglot-rename))
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
(use-package ido
  :bind (("C-x C-d" . ido-dired)
         :map ido-common-completion-map
              ("C-n"    . ido-next-match)
              ("<down>" . ido-next-match)
              ("C-p"    . ido-prev-match)
              ("<up>"   . ido-prev-match)))
(use-package geiser)
(use-package tab-bar
  :bind (("C-S-t" . (lambda () (interactive) (tab-bar-mode 1) (tab-bar-new-tab)))
         ("M-1" . (lambda () (interactive) (tab-bar-select-tab 1)))
         ("M-2" . (lambda () (interactive) (tab-bar-select-tab 2)))
         ("M-3" . (lambda () (interactive) (tab-bar-select-tab 3)))
         ("M-4" . (lambda () (interactive) (tab-bar-select-tab 4)))
         ("M-5" . (lambda () (interactive) (tab-bar-select-tab 5)))
         ("M-6" . (lambda () (interactive) (tab-bar-select-tab 6)))
         ("M-7" . (lambda () (interactive) (tab-bar-select-tab 7)))
         ("M-8" . (lambda () (interactive) (tab-bar-select-tab 8)))
         ("M-9" . (lambda () (interactive) (tab-bar-select-tab 9)))
         ("M-<left>" . (lambda () (interactive) (tab-bar-move-tab -1)))
         ("M-<right>" . tab-bar-move-tab))
  :config (progn
            (bind-key* "C-M-q" (lambda () (interactive) (tab-bar-close-tab)
                                 (when (= (length (tab-bar-tabs)) 1)
                                   (tab-bar-mode 0))))
            (setf tab-bar-close-button
                #(" ×" 0 2 (display (image :type xpm :file "tabs/close.xpm"
                                           :margin (2 . 0) :ascent center)
                                    close-tab t :help "Click to close tab")))))
(progn ;init
  (find-file "~/.emacs.d/init.el")
  (dolist (fun '(upcase-region down-case-region scroll-left scroll-right))
    (put fun 'disabled nil))
  (let ((x (+ 14 (car (frame-position))))
        (y (+ 14 (cdr (frame-position))))
        (width (* 130 (frame-char-width)))
        (height (* 47 (frame-char-height))))
    (set-frame-position (selected-frame)
                        (abs (- x (/ (- width (frame-pixel-width)) 2) 32))
                        (abs (- y (- height (frame-pixel-height)))))
    (set-frame-size (selected-frame) width height :pixelwise))
  (setq-default line-spacing .2)
  (switch-to-buffer "*scratch*"))
 
(use-package gudder-jdb :load-path "~/Desktop/Gudder/")
