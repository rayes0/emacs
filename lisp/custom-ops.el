(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/Notes/org/todo.org"))
 '(package-selected-packages
    '(indent-guide org-noter persistent-scratch smartparens all-the-icons-ibuffer all-the-icons-dired shx org-bullets org-superstar evil-leader speed-type pdf-tools poly-R poly-markdown ess all-the-icons-ivy-rich ivy-rich flx ox-pandoc ytdious ivy-hydra counsel-world-clock counsel-codesearch counsel activity-watch-mode org-autolist undo-tree unicode-math-input math-symbols writegood-mode powerthesaurus ox-hugo centered-window org-fragtog org-download anki-editor gnuplot vterm which-key rustic writeroom-mode eglot evil))
 '(safe-local-variable-values '((org-time-stamp-custom-formats "%m/%d/%y" . "%m/%d/%y"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; undo tree
(global-undo-tree-mode)

;; markdown-mode
(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; evil-mode
;; need these before
(setq evil-disable-insert-state-bindings t)
(setq evil-default-state 'insert)
(defvaralias 'evil-shift-width 'tab-width)
(setq evil-want-fine-undo t)
(setq evil-undo-system 'undo-redo)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(require 'evil)
(set-cursor-color "#dad3d0")
(evil-mode 1)
;; make :q not kill emacs entirely, only the current buffer
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; must type :quit to close emacs entirely
(evil-ex-define-cmd "quit" 'evil-quit)
;; disable for some modes
(evil-set-initial-state 'help-mode 'emacs)
(evil-set-initial-state 'Info-mode 'emacs)
(evil-set-initial-state 'tabulated-list-mode 'emacs)
(evil-set-initial-state 'Buffer-menu-mode 'emacs)
(evil-set-initial-state 'vterm-mode 'emacs)

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
(which-key-mode t)

;; writegood-mode
(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

;; org-download
(require 'org-download)
(setq org-download-screenshot-method "maim -s %s")

;; org-fragtog
(add-hook 'org-mode-hook 'org-fragtog-mode)

;; org-latex
(setq org-latex-create-formula-image-program 'dvisvgm)

;; org-bullets
(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))

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

;; activity watch mode
(global-activity-watch-mode)

;; vterm
(setq vterm-buffer-name-string "%s | vterm")

;; swiper, counsel, ivy
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(counsel-mode t)
(global-set-key (kbd "C-s") 'swiper-isearch)
;; ivy fuzzy matching
(setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                               (t . ivy--regex-fuzzy))
  ivy-initial-inputs-alist nil)

(all-the-icons-ivy-rich-mode 1)
(ivy-rich-mode 1)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
(setq ivy-rich-path-style 'abbrev)

(set-face-attribute 'ivy-current-match nil
  :foreground 'unspecified
  :slant 'unspecified
  :background "#e7e0dd")
(set-face-attribute 'ivy-minibuffer-match-face-1 nil
  :weight 'bold
  :slant 'unspecified
  :background 'unspecified
  :foreground "#9c7b9c")
(set-face-attribute 'ivy-minibuffer-match-face-2 nil
  :weight 'bold
  :slant 'unspecified
  :background 'unspecified
  :foreground "#a09c80")
(set-face-attribute 'ivy-minibuffer-match-face-3 nil
  :weight 'bold
  :slant 'unspecified
  :background 'unspecified
  :foreground "#839773")
(set-face-attribute 'ivy-minibuffer-match-face-4 nil
  :weight 'bold
  :slant 'unspecified
  :background 'unspecified
  :foreground "#75998e")
(set-face-attribute 'ivy-org nil
  :height 110
  :weight 'bold
  :slant 'italic)
(set-face-attribute 'ivy-remote nil
  :foreground 'unspecified
  :slant 'italic
  :background 'unspecified
  :foreground "#9c7b9c")

;; ytdious
(setq ytdious-invidious-api-url "https://invidious.snopyta.org")

;; org-appt reminders
(defun talky-popup (title msg &optional icon)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"
  (interactive)
  
  (if (eq window-system 'x)
    (shell-command (concat "notify-send -u critical -t 1800000  " 
                     (if icon (concat "-i " icon) "")
                     " '" title "' '" msg "'"))
    ;; text only version
    (message (concat title ": " msg))))

;; the appointment notification facility
(setq appt-message-warning-time 10 ;; warn 10 min in advance
  appt-display-mode-line t     ;; show in the modeline
  appt-display-format 'window) ;; use our func
(appt-activate 1)              ;; active appt (appointment notification)
(display-time)                 ;; time display is required for this...

;; update appt each time agenda opened
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

;; our little façade-function for talky-popup
(defun talky-appt-display (min-to-app new-time msg)
  (talky-popup (format "In %s minute(s):" min-to-app) msg 
    ;;    "/usr/share/icons/gnome/32x32/status/appointment-soon.png"   ;; optional icon
    ))
(setq appt-disp-window-function (function talky-appt-display))

;; R markdown
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  (require 'poly-R)
  (require 'poly-markdown)     
  (poly-markdown+r-mode)
  (variable-pitch-mode 0)
  (setq-local markdown-hide-markup nil)
  (face-remap-add-relative 'markdown-header-face-1 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-2 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-3 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-4 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-5 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-6 '(:height 110 :underline t)))
(add-to-list 'auto-mode-alist '("\\.Rmd" . rmd-mode))

;; oxpandoc
(require 'ox-pandoc)

;; pdf-tools
(pdf-tools-install)

;; all-the-icons
(all-the-icons-ibuffer-mode 1)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(require 'all-the-icons-dired)
(set-face-attribute 'all-the-icons-dired-dir-face nil :foreground "#6c605a")

;; ibuffer custom buffers
(setq ibuffer-saved-filter-groups
  (quote (("main"
            ("MODIFIED" (and
                          (modified . t)
                          (visiting-file . t)))
            ("term" (or
                      (mode . vterm-mode)
                      (mode . eshell-mode)
                      (mode . term-mode)
                      (mode . shell-mode)))
            ("planning" (or
                          (name . "^\\*Calendar\\*$")
                          (name . "^diary$")
                          (mode . org-agenda-mode)))
            ("blog" (filename . "/sites/personal-site/"))
            ("notes" (and (filename . "/Notes/")
                       (or (mode . org-mode)
                         (mode . markdown-mode))))
            ("org" (mode . org-mode))
            ("books" (filename . "/Books/"))
            ("docs" (or
                      (mode . pdf-view-mode)
                      (mode . doc-view-mode)))
            ("img" (mode . image-mode))
            ("emacs.d" (or (filename . "/.emacs.d/")
                         (filename . "/.config/emacs/")))
            ("config" (or (filename . "/.config/")
                        (filename . "/.themes/")))
            ("code" (or
              (derived-mode . prog-mode)
              (mode . ess-mode)
              (filename . "/projects/")))
            ("dired" (mode . dired-mode))
            ("help" (or (name . "\*Help\*")
                      (name . "\*Apropos\*")
                      (name . "\*info\*")))
            ("internal" (name . "^\*.*$"))
            ("other" (name . "^.*$"))
            ))))
(setq ibuffer-expert t
  ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-auto-mode 1)
    (ibuffer-switch-to-saved-filter-groups "main")))

(setq diary-file "~/Notes/diary")

;; shx
(shx-global-mode 1)
(defun shx-cmd-rename (name)
  "(SAFE) Rename the current buffer to NAME."
  (if (not (ignore-errors (rename-buffer name)))
      (shx-insert 'error "Can't rename buffer.")
    (shx-insert "Renaming buffer to " name "\n")
    (shx--hint "Emacs won't save buffers starting with *")))

;; presistent scratch
(persistent-scratch-setup-default)

;; indent guide
(require 'indent-guide)
(indent-guide-global-mode)
(setq indent-guide-char "│")
(set-face 'indent-guide-face 'face-faded)
(dolist (mode '(org-mode
                 markdown-mode
                 fundamental-mode
                 shell-mode
                 vterm-mode))
          (add-to-list 'indent-guide-inhibit-modes mode))

(provide 'custom-ops)
