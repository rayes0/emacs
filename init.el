;; -*- lexical-binding: t; -*-
(setq gc-cons-threshold most-positive-fixnum)

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./theme" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./data" user-emacs-directory))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

(package-initialize)
(package-activate-all)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

;; (defun my/require-all ()
;;   (require 'colors)
;;   ;; (sayo)
;;   (blossom)
;;   (require 'general)
;;   (require 'interface)
;;   (require 'init-text)
;;   (require 'init-system))

(defun my/load-all ()
  (load-file (expand-file-name "./theme/colors.el" user-emacs-directory))
  (load-file (expand-file-name "./theme/general.el" user-emacs-directory))
  (load-file (expand-file-name "./lisp/interface.el" user-emacs-directory))
  (load-file (expand-file-name "./lisp/init-text.el" user-emacs-directory))
  (load-file (expand-file-name "./lisp/init-system.el" user-emacs-directory))
  (load-file (expand-file-name "./lisp/init-org.el" user-emacs-directory))

  (let ((custom-user-file (expand-file-name "./lisp/custom-ops.el"
                                            user-emacs-directory)))
    (load-file custom-user-file)
    (setq custom-file custom-user-file))

  ;; set org agenda as initial buffer
  (with-eval-after-load 'org
    (setq initial-buffer-choice (lambda ()
                                  (let ((org-agenda-window-setup 'only-window))
                                    (org-agenda-list)
                                    org-agenda-buffer)))))

(load-file (expand-file-name "./data/splash.el" user-emacs-directory))
(show-splash)

;; (defun daemon-make-frame (_)
;;   (unless rayes/everything-loaded?
;;     (setq-default rayes/everything-loaded? t)
;;     ;; (with-selected-frame frame
;;     (my/require-all)
;;     (my/post-load)))
;; )

;; (defvar rayes/everything-loaded? nil)
;; (if (daemonp)
;; (add-hook 'server-after-make-frame-hook #'daemon-make-frame)
;; (my/require-all)
;; (my/post-load))

(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist '(("." . "~/.emacs_backups"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 2)

;; takes too long to start, so just run this after 10 sec
(run-with-timer 10 nil (lambda ()
                         (let ((inhibit-message t))
                           (require 'midnight)
                           (midnight-delay-set 'midnight-delay "3:00am")
                           (midnight-mode 1)
                           (setq clean-buffer-list-delay-general 1))))

(run-with-timer 3 nil
                (lambda ()
                  (let ((inhibit-message t))
                    (load-file (expand-file-name "macros.el" user-emacs-directory)))))

;; (setq gc-cons-threshold 1600000)
(setq gc-cons-threshold 4000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment "UTF-8")
(set-selection-coding-system 'utf-8)
