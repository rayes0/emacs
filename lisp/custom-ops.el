(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages
     '(evil-leader org-fragtog org-download anki-editor gnuplot vterm which-key rustic evil-collection writeroom-mode eglot easy-hugo evil)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

;; smart tabs
(require 'smart-tabs-mode)

(smart-tabs-add-language-support lisp lisp-mode-hook
  ((lisp-indent-line . lisp-indent-offset)
    (lisp-indent-region . lisp-indent-offset)))

(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml ;; builtin
  'lisp) ;; custom

;; markdown-mode
(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; god-mode
;; (god-mode)
;; (global-set-key (kbd "<escape>") #'god-local-mode)
;; (setq god-exempt-major-modes nil)
;; (setq god-exempt-predicates nil)
;; (defun my-god-mode-update-cursor-type ()
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

;; evil-mode
(global-evil-leader-mode) ;; need this before enabling evil mode
(evil-leader/set-leader "<SPC>")
(require 'evil)
;;(require 'evil-collection)
;;(setq evil-want-keybinding nil)
(evil-mode 1)
;;(evil-collection-init)
;;;; make :q not kill emacs entirely, only the current buffer
(evil-ex-define-cmd "q" 'kill-this-buffer)
;;;; must type :quit to close emacs entirely
(evil-ex-define-cmd "quit" 'evil-quit)

;; org-agenda
(global-set-key "\C-ca" 'org-agenda)

;; rustic-mode
(setq rustic-lsp-client 'eglot)

;; eglot
(require 'eglot)
(add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
(define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
(define-key eglot-mode-map (kbd "C-c h") 'eldoc)
(define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)

(setq eglot-sync-connect 0)
(add-hook 'rustic-mode-hook 'eglot-ensure)

;; which-key-mode
(which-key-mode)

;; writegood-mode
(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

;; easy-hugo
(setq easy-hugo-basedir "~/sites/personal-site/")
(setq easy-hugo-url "https://rayes0.github.io/")
(setq easy-hugo-postdir "content/blog")

;; org-download
(require 'org-download)
(setq org-download-screenshot-method "maim -s %s")

;; org-fragtog
(add-hook 'org-mode-hook 'org-fragtog-mode)

;; org-latex
(setq org-latex-create-formula-image-program 'dvisvgm)

;; anki-editor
(require 'anki-editor)
(defun filter-out-p (str _ _)
  (replace-regexp-in-string "\n<p>\\|</p>\n\\|<p>\\|</p>" "" str))
(setq anki-editor--ox-anki-html-backend
  (org-export-create-backend
    :parent 'html
    :filters
    '((:filter-paragraph . filter-out-p))))
(evil-leader/set-key "ap" #'anki-editor-push-notes)
(evil-leader/set-key "ai" #'anki-editor-insert-note)
(evil-leader/set-key "ac" #'anki-editor-cloze-region)

(provide 'custom-ops)
