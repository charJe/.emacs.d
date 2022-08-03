;;;; init.el
;;;; Charles Jackson
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms nil)
 '(auto-save-visited-mode t)
 '(backup-directory-alist `(("." . "~/.emacs.d/saves")))
 '(column-number-mode t)
 '(comint-process-echoes t)
 '(corfu-auto t)
 '(corfu-auto-delay 0.0)
 '(corfu-auto-prefix 0)
 '(corfu-on-exact-match 'quit)
 '(custom-safe-themes
   '("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(default-text-scale-mode t nil (default-text-scale))
 '(delete-selection-mode t)
 '(dired-sidebar-width 50)
 '(dired-use-ls-dired nil)
 '(electric-pair-mode t)
 '(frame-title-format "Emacs" t)
 '(global-corfu-mode t)
 '(hs-allow-nesting t t)
 '(hs-hide-comments-when-hiding-all t)
 '(hs-isearch-open t)
 '(icomplete-mode t)
 '(icomplete-vertical-mode t)
 '(indent-tabs-mode nil)
 '(initial-scratch-message "")
 '(insert-ticket-default-ticket "N/A")
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   '(restclient markdown-mode dockerfile-mode yaml-mode default-text-scale marginalia exec-path-from-shell diminish corfu drag-stuff dired-sidebar haskell-mode yasnippet windresize use-package multiple-cursors magit expand-region color-theme-sanityinc-solarized))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(uniquify-buffer-name-style 'forward nil (uniquify))
 '(use-package-always-demand t)
 '(use-package-always-ensure t)
 '(vc-annotate-background nil)
 '(vc-annotate-very-old-color nil)
 '(wdired-allow-to-change-permissions t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#fdf6e3" :foreground "#657b83" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "PlemolJP"))))
 '(completions-common-part ((t (:inherit minibuffer-prompt)))))
(use-package diminish)
(use-package charles
  :load-path "~/.emacs.d/charles/"
  :bind (("C-x s" . save-all)
         ("C-c =" . increment-number-at-point)
         ("C-c -" . (lambda (arg) (interactive "p") (increment-number-at-point (- arg))))
         ("H-=" . increment-number-at-point)
         ("H--" . (lambda (arg) (interactive "p") (increment-number-at-point (- arg))))
         ("C-c C-f" . insert-file-name)
         ("H-c f" . insert-buffer-name)
         ("s-<" . (lambda () (interactive) (scroll-right 8)))
         ("s->" . (lambda () (interactive) (scroll-left 8)))
         ;; drag buffer
         ("M-s-<left>" . drag-buffer-left)
         ("M-s-<right>" . drag-buffer-right)
         ("M-s-<up>" . drag-buffer-up)
         ("M-s-<down>" . drag-buffer-down)))
(use-package quick-theme
  :load-path "~/.emacs.d/charles/"
  :config (progn ;themes
            (q-th sl 'sanityinc-solarized-light)
            (q-th sd 'sanityinc-solarized-dark)
            (q-th wom 'wombat)
            (q-th adt 'adwaita)
            (sl)))
(use-package window
  :ensure nil
  :commands (other-window split-window-right split-window-below)
  :preface (progn
            (defun other-window-reverse (count)
              (interactive "p") (other-window count))
            (defun split-right-switch ()
              (interactive)
              (split-window-right)
              (other-window 1)
              (call-interactively #'switch-to-buffer))
            (defun split-below-switch ()
              (interactive)
              (split-window-below)
              (other-window 1)
              (call-interactively #'switch-to-buffer)))
  :bind (("C-o" . other-window)
         ("M-o" . other-window-reverse)
         ("C-q" . delete-window)
         ("s-q" . delete-window)
         ("M-q" . (lambda () (interactive) (kill-buffer (current-buffer))))
         ("s-b" . switch-to-buffer)
         ("C-x |" . split-right-switch)
         ("C-x _" . split-below-switch)))
(use-package windresize
  :bind (("C-x w" . windresize)))
(use-package windmove
  :bind (("C-s-f" . windmove-right) ("<C-s-right>" . windmove-right)
         ("C-s-n" . windmove-down) ("<C-s-down>" . windmove-down)
         ("C-s-b" . windmove-left) ("<C-s-left>" . windmove-left)
         ("C-s-p" . windmove-up) ("<C-s-up>" . windmove-up)))
(use-package expand-region
  :bind (("C-M-SPC" . er/expand-region)))
(use-package multiple-cursors
  :bind (("C-M-m" . mc/edit-lines)
         ("C-M->" . mc/mark-next-like-this)
         ("C-M-<" . mc/mark-previous-like-this)
         ("C-c m" . mc/mark-all-like-this)
         ("C-M-<mouse-1>" . mc/add-cursor-on-click)))
(use-package compile
  :hook ((compilation-start . end-of-buffer))
  :bind (("ESC <f5>" . compile)
         ("<f5>"     . recompile)))
(use-package apropos
  :ensure nil
  :bind (("<help> a" . apropos)))
(use-package simple
  :ensure nil
  :hook ((prog-mode . (lambda () (toggle-truncate-lines 1)))
         (text-mode . (lambda () (visual-line-mode 1))))
  :bind (("M-k" . kill-whole-line)
         ("M-'" . quoted-insert))
  :config (progn
            (bind-key* "C-M-h" #'backward-kill-word)
            (define-key key-translation-map (kbd "C-?") (kbd "<help>"))
            (define-key key-translation-map (kbd "C-h") (kbd "DEL"))))
(use-package subword
  :after (haskell-mode)
  :hook ((haskell-mode . subword-mode)))
(use-package yasnippet
  :hook ((prog-mode . yas-minor-mode)
         (org-mode . yas-minor-mode)
         (yas-minor-mode . yas-reload-all)))
(use-package hideshow
  :hook ((prog-mode . hs-minor-mode))
  :bind (:map hs-minor-mode-map
              ("<C-tab>" . hs-toggle-hiding)
              ("C-c h a" . hs-hide-all)
              ("C-c h s" . hs-show-all)
              ("C-c h l" . hs-hide-level)))
(use-package misc
  :ensure nil
  :bind (("M-z" . zap-up-to-char)))
(use-package newcomment
  :ensure nil
  :bind (("C-;" . comment-line)))
(use-package flyspell
  :hook ((text-mode . flyspell-mode))
  :bind (:map flyspell-mode-map
              ([mouse-3] . flyspell-correct-word)))
(use-package org
  :hook ((org-mode . org-indent-mode)
         (org-mode . org-toggle-pretty-entities)))
(use-package magit
  :after (charles)
  :bind (("C-x v g" . magit))
  :hook ((git-commit-setup . insert-ticket)))
(use-package extra-font-lock
  :load-path "~/.emacs.d/charles/"
  :after (haskell-mode)
  :config (progn ;extra highlighting
            (add-extra-syntax haskell-operators 'haskell-mode)))
(use-package autorevert
  :diminish ""
  :config (global-auto-revert-mode))
(use-package haskell-mode
  :hook ((haskell-mode . interactive-haskell-mode)))
(use-package dired-sidebar
  :bind (("C-c d" . dired-sidebar-toggle-sidebar)))
(use-package drag-stuff
  :diminish ""
  :bind (("<M-left>" . drag-stuff-left)
         ("<M-right>" . drag-stuff-right)
         ("<M-up>" . drag-stuff-up)
         ("<M-down>" . drag-stuff-down))
  :config (drag-stuff-global-mode t))
(use-package corfu
  :diminish "co"
  :bind (("M-/" . completion-at-point))
  :config (global-corfu-mode))
(use-package exec-path-from-shell
  :config (progn
            (exec-path-from-shell-initialize)
            (dolist (var '("PATH"))
              (exec-path-from-shell-copy-env var))))
(use-package marginalia
  :config (marginalia-mode))
(use-package default-text-scale)
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package markdown-mode)
(use-package restclient)
(use-package icomplete
  :bind ((:map icomplete-minibuffer-map
               ("RET" . icomplete-force-complete-and-exit)
               ("M-/" . icomplete-force-complete))))
(use-package display-line-numbers
  :bind (("C-x x d" . display-line-numbers-mode)))
(progn ;init
  (find-file "~/.emacs.d/init.el")
  (dolist (fun '(upcase-region downcase-region scroll-left scroll-right))
    (put fun 'disabled nil))
  (setq-default line-spacing .2)
  (switch-to-buffer "*scratch*"))
