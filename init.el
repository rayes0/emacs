;; -*- lexical-binding: t; -*-
(setq gc-cons-threshold most-positive-fixnum)
(global-so-long-mode 1)

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./theme" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./data" user-emacs-directory))

(package-initialize)
(package-activate-all)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                          ("nongnu" . "https://elpa.nongnu.org/nongnu")
                          ("gnu" . "https://elpa.gnu.org/packages/")))

(defun my/require-all ()
  (require 'interface)
  (require 'colors)
  (require 'general)
  (require 'init-org)
  (require 'init-text)
  (require 'init-system)

  ;; Theme
  ;; (sayo)
  (blossom))
(load-file (expand-file-name "./data/splash.el" user-emacs-directory))
(show-splash)

;; ;; (defun my/get-window-system ()
;; ;;   (cond ((window-system) 'pgtk)
;; ;;     ))
;; (if (daemonp)
;;   (if (display-graphic-p)
;;     (let ((frame (make-frame '((window-system . pgtk)))))
;;       (select-frame frame)
;;       (my/require-all))
;;     (run-with-timer 0.5 nil #'my/require-all))
;;   (my/require-all))
;; (blossom)

(defun my/post-load ()
  (let ((custom-user-file (expand-file-name "./lisp/custom-ops.el"
                            user-emacs-directory)))
    (load-file custom-user-file)
    (setq custom-file custom-user-file)))

(defvar my/everything-is-loaded nil)
(if (daemonp)
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (with-selected-frame frame
        (unless my/everything-is-loaded
          (my/require-all)
          (my/post-load)
          (setq my/everything-is-loaded t)))))
  (progn
    (my/require-all)
    (my/post-load)))

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

(run-with-timer 10 nil
  (lambda ()
    (require 'midnight)
    (setq clean-buffer-list-delay-general 1)))

(setq gc-cons-threshold 1600000)

;; don't garbage collect when in minibuffer
(defun my/minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my/minibuffer-exit-hook ()
  (setq gc-cons-threshold 1600000))

(add-hook 'minibuffer-setup-hook 'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook 'my/minibuffer-exit-hook)

