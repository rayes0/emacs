(setq gc-cons-threshold (* 100 1000 100))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/theme")
(add-to-list 'load-path "~/.emacs.d/data")

(require 'interface)
(require 'colors)
(require 'general)

(require 'init-text)
(require 'init-org)
(require 'init-mdown)

(setq custom-file "~/.emacs.d/lisp/custom-ops.el")
;;(load custom-file 'noerror)
(require 'custom-ops)

;; Backup to temp dir instead of littering the file tree with files
(setq
  backup-directory-alist '(("." . "~/.emacs.d/backups"))
  backup-by-copying t
  version-control t
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq require-final-newline nil
	  mode-require-final-newline nil)

(ido-mode t)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
         '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(load-file "~/.emacs.d/data/Splash.el")
(show-splash)
(setq initial-buffer-choice (lambda () (get-buffer-create "*splash*")))

;; set theme
(blossom)
;;(sayo)

(setq gc-cons-threshold (* 2 1000 100))
