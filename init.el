(setq gc-cons-threshold (* 100 1000 100))

(add-to-list 'load-path (expand-file-name "./lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./theme" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "./data" user-emacs-directory))

(require 'interface)
(require 'colors)
(require 'general)

(require 'init-text)
(require 'init-org)

(require 'custom-ops)
(setq custom-file (expand-file-name "./lisp/custom-ops.el" user-emacs-directory))
(defadvice en/disable-command (around put-in-custom-file activate)
  "Put declarations in `custom-file'."
  (let ((user-init-file custom-file))
	ad-do-it))

;; autosave to temp dir instead of littering the file tree with files
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; backup files, I ain't living dangerously
(setq
  backup-directory-alist '(("." . "~/.emacs_backups"))
  backup-by-copying t
  version-control t
  delete-old-versions t
  kept-new-versions 10
  kept-old-versions 2)

(setq require-final-newline nil
	  mode-require-final-newline nil)
(setq backward-delete-char-untabify-method 'hungry)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)

(setq completion-ignore-case t)
(ido-mode 1)
(ido-everywhere 1)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
         '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(load-file (expand-file-name "./data/Splash.el" user-emacs-directory))
(show-splash)
(setq initial-buffer-choice (lambda () (get-buffer-create "*splash*")))

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; set theme
(blossom)
;;(sayo))

(setq gc-cons-threshold (* 2 1000 100))
