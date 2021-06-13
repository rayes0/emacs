(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/Notes/Org/events.org" "~/.todo/todo.org"))
 '(package-selected-packages
	 '(which-key eglot evil-collection evil vue-mode god-mode smart-tabs-mode flx-ido easy-hugo ein tree-sitter texfrag writegood-mode company discover-my-major gnuplot eaf pdf-tools writeroom-mode vterm rustic))
 '(writeroom-major-modes '(text-mode org-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; (god-mode)
;; (global-set-key (kbd "<escape>") #'god-local-mode)
;; (setq god-exempt-major-modes nil)
;; (setq god-exempt-predicates nil)
;; (defun my-god-mode-update-cursor-type ()
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

(setq evil-want-keybinding nil)
(require 'evil)
(require 'evil-collection)
(evil-mode 1)
(evil-collection-init)
;; make :q not kill emacs entirely, only the current buffer
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; must type :quit to close emacs entirely
(evil-ex-define-cmd "quit" 'evil-quit)

(global-set-key "\C-ca" 'org-agenda)
(setq confirm-kill-emacs 'y-or-n-p)

(setq rustic-lsp-client 'eglot)

(require 'eglot)
(add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
(define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
(define-key eglot-mode-map (kbd "C-c h") 'eldoc)
(define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)

(setq eglot-sync-connect 0)
(add-hook 'rustic-mode-hook 'eglot-ensure)

(which-key-mode)

(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

(setq easy-hugo-basedir "~/sites/personal-site/")
(setq easy-hugo-url "https://rayes0.github.io/")
(setq easy-hugo-postdir "content/blog")

(provide 'custom-ops)
