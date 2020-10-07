(progn ;package setup
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'load-path "~/.emacs.d/elpa/mmm-mode/")
  (package-initialize)
  (require 'use-package))
(setq inhibit-startup-screen t)
(tab-bar-mode -1)
(tool-bar-mode -1)
(setq tool-bar-position 'left)
(setq tool-bar-style 'image)
(scroll-bar-mode -1)
(menu-bar-mode -1)

