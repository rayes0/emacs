(setq gc-cons-threshold most-positive-fixnum)

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./theme" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./data" user-emacs-directory))

(require 'interface)
(require 'colors)
(require 'general)
(run-with-timer 0.5 nil
  (lambda ()
    (require 'init-org)
    (require 'init-text)
    (require 'init-system)))

(package-initialize)
(package-activate-all)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                          ("nongnu" . "https://elpa.nongnu.org/nongnu")
                          ("gnu" . "https://elpa.gnu.org/packages/")))
                          ;;("org" . "https://orgmode.org/elpa/")))
(require 'custom-ops)
(setq custom-file (expand-file-name "./lisp/custom-ops.el" user-emacs-directory))
(defadvice en/disable-command (around put-in-custom-file activate)
  "Put declarations in `custom-file'."
  (let ((user-init-file custom-file))
    ad-do-it))

;; backup files and prevent autosave littering file tree
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t))
  backup-directory-alist '(("." . "~/.emacs_backups"))
  backup-by-copying t
  version-control t
  delete-old-versions t
  kept-new-versions 10
  kept-old-versions 2)

(load-file (expand-file-name "./data/splash.el" user-emacs-directory))
(show-splash)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; set theme
(blossom)
;;(sayo)

(setq gc-cons-threshold 1600000)

;; don't garbage collect when in minibuffer
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 1600000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)
