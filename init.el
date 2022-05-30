;; -*- lexical-binding: t; -*-
(setq gc-cons-threshold most-positive-fixnum)

(global-so-long-mode 1)

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./theme" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./data" user-emacs-directory))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

(package-initialize)
(package-activate-all)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(defun my/require-all ()
  (dolist (file '("./lisp/interface.el" "./theme/colors.el" 
                  "./theme/general.el" "./lisp/init-text.el"
                  "./lisp/init-system.el"))
    (load-file (expand-file-name file user-emacs-directory)))

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
    (setq custom-file custom-user-file))
  (load-file (expand-file-name "./lisp/init-org.el" user-emacs-directory)))

(defvar my/everything-is-loaded nil)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (unless my/everything-is-loaded
                    (my/require-all)
                    (my/post-load)
                    (setq my/everything-is-loaded t)))))
  (my/require-all)
  (my/post-load))

(defadvice en/disable-command (around put-in-custom-file activate)
  "Put declarations in `custom-file'."
  (let ((user-init-file custom-file))
    ad-do-it))

;; backup files and prevent autosave littering file tree
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist '(("." . "~/.emacs_backups"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 2)

;; takes too long to start, so just run this after 10 sec
(run-with-timer 10 nil (lambda ()
                         (require 'midnight)
                         (midnight-delay-set 'midnight-delay "3:00am")
                         (midnight-mode 1)
                         (setq clean-buffer-list-delay-general 1)))

(run-with-timer 3 nil
                (lambda () (load-file (expand-file-name "macros.el" user-emacs-directory))))

(setq gc-cons-threshold 1600000)

;; don't garbage collect when in minibuffer
;; (add-hook 'minibuffer-setup-hook (lambda () (setq gc-cons-threshold most-positive-fixnum)))
;; (add-hook 'minibuffer-exit-hook (lambda () (setq gc-cons-threshold 1600000)))

