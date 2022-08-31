;; -*- lexical-binding: t -*-
;;; Settings for various interaction with the host system and emacs ecosystem

(require 'general)

(setq eval-expression-print-level nil
      eval-expression-print-length nil)

(setq url-privacy-level 'paranoid
      url-mime-accept-string "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 "
      url-mime-language-string "en-US,en;q=0.5")
(url-setup-privacy-info)

(setq password-cache t
      password-cache-expiry 3600)

;; recentf
(recentf-mode 1)
(setq recentf-max-menu-items 20
      recentf-max-saved-items 50)
(run-at-time nil (* 5 60) (lambda ()
                            (let ((inhibit-message t))
                              (recentf-save-list))))

;; rename recentf entries from dired
;; (defun my/recentf-rename-notify (oldname newname &rest args)
;;   (if (file-directory-p newname)
;;       (my/recentf-rename-directory oldname newname)
;;     (my/recentf-rename-file oldname newname)))

;; (defun my/recentf-rename-file (oldname newname)
;;   (setq recentf-list
;;         (mapcar (lambda (name)
;;                   (if (string-equal name oldname)
;;                       newname
;;                     name))
;;                 recentf-list)))

;; (defun my/recentf-rename-directory (oldname newname)
;;   (setq recentf-list
;;         (mapcar (lambda (name)
;;                   (if (string-prefix-p oldname name)
;;                       (concat newname (substring name (length oldname)))
;;                     name))
;;                 recentf-list)))

;; (advice-add 'dired-rename-file :after #'my/recentf-rename-notify)

;; dired
(with-eval-after-load 'dired
  (setq dired-dwim-target t
        dired-listing-switches "-Alh"
        dired-use-ls-dired t
        ;; dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\|\\`[.].*\\'"
        dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\|\\`[.].*\\'\\|\\`.*.aria2\\'"
        dired-always-read-filesystem t
        dired-create-destination-dirs 'ask
        dired-hide-details-hide-symlink-targets nil
        dired-isearch-filenames 'dwim
        dired-free-space 'separate
        dired-mouse-drag-files t)
  ;; (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
  (set-face 'dired-header 'face-salient-cyan)
  (set-face-attribute 'dired-header nil :underline t)
  (set-face 'dired-broken-symlink 'face-critical)
  ;; (add-to-list 'completion-ignored-extensions ".aria2")
  )
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'dired-omit-mode)

;; tramp
(setq tramp-default-method "ssh"
      enable-remote-dir-locals t)

;; gnus
(setq gnus-init-file (expand-file-name ".gnus.el" user-emacs-directory))

;; docview
(setq doc-view-resolution 300)
(setq doc-view-continuous t)

;; set org agenda as initial buffer
(setq initial-buffer-choice (lambda ()
                              (let ((org-agenda-window-setup 'only-window))
                                (org-agenda-list)
                                org-agenda-buffer)))

;; ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (setq initial-buffer-choice (lambda ()
;;                               (let ((default-directory "~/")
;;                                     (buffer (get-buffer "*Ibuffer*")))
;;                                 (if buffer
;;                                     buffer
;;                                   (ibuffer)
;;                                   (get-buffer "*Ibuffer*")))))
(setq ibuffer-expert t
      ibuffer-show-empty-filter-groups nil
      ibuffer-use-header-line t
      ibuffer-always-show-last-buffer t
      ibuffer-formats
      '((mark modified " "
              (name 20 20 :left :elide) " "
              (size-custom 5 -1 :right) " "
              (mode 16 16 :left :elide) " "
              filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename)))

(define-ibuffer-column name-nolabel
  (:name "Buffer"
         :inline nil
         :summarizer
         (lambda (strings)
           (let ((bufs (length strings)))
             (cond ((zerop bufs) "No buffers")
                   ((= 1 bufs) "1 buffer")
                   (t (format "%s buffers" bufs))))))
  (let ((string (propertize (buffer-name)
                            'font-lock-face
                            (ibuffer-buffer-name-face buffer mark))))
    (if (not (seq-position string ?\n))
        string
      (string-replace
       "\n" (propertize "^J" 'font-lock-face 'escape-glyph) string))))

(define-ibuffer-column size-custom
  (:name "Size"
         :inline t
         :summarizer
         (lambda (column-strings)
           (let ((total 0))
             (dolist (string column-strings)
               (setq total
                     (+ (float (my/human-readable-file-sizes-to-bytes string))
                        total)))
             (file-size-human-readable total))))
  (file-size-human-readable (buffer-size)))

(defun my/human-readable-file-sizes-to-bytes (string)
  "Convert a human-readable file size into bytes."
  (interactive)
  (cond ((string-suffix-p "G" string t)
         (* 1000000000 (string-to-number (substring string 0 (- (length string) 1)))))
        ((string-suffix-p "M" string t)
         (* 1000000 (string-to-number (substring string 0 (- (length string) 1)))))
        ((string-suffix-p "K" string t)
         (* 1000 (string-to-number (substring string 0 (- (length string) 1)))))
        (t
         (string-to-number (substring string 0 (- (length string) 1))))))

;; ansi colors
(with-eval-after-load 'ansi-color
  (setq ansi-color-names-vector
        ["#ede6e3" "#ce9c85" "#839773" "#a09c80" "#8f8678" "#9c7b9c" "#75998e" "#685c56"])
  (setq ansi-color-map (ansi-color-make-color-map)))

(with-eval-after-load 'comint
  (ansi-color-for-comint-mode-on)
  (setq comint-terminfo-terminal "eterm-color"
        comint-prompt-read-only t
        comint-input-ignoredups t
        comint-completion-autolist t))
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output))

(with-eval-after-load 'compile
  (setq ansi-color-for-compilation-mode t)
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
  (setq compilation-save-buffers-predicate
        (lambda ()
          (string-prefix-p default-directory (file-truename (buffer-file-name))))))

;; eshell
(add-hook 'eshell-term-load-hook (lambda () (setenv "TERM" comint-terminfo-terminal)))
(with-eval-after-load 'eshell
  (add-to-list 'eshell-modules-list 'eshell-rebind)
  (add-to-list 'eshell-modules-list 'eshell-tramp)
  ;; (add-to-list 'eshell-modules-list 'eshell-smart)
  (add-to-list 'eshell-modules-list 'eshell-xtra)
  (add-to-list 'eshell-modules-list 'eshell-elecslash)
  (setq eshell-highlight-prompt nil
        eshell-prompt-function
        (lambda nil
          (propertize (concat
                       (if (string= (eshell/pwd) (getenv "HOME"))
                           (propertize "~" 'face '(:inherit face-faded :weight light))
                         (replace-regexp-in-string
                          (getenv "HOME")
                          (propertize "~" 'face '(:inherit face-faded :weight light))
                          (propertize (eshell/pwd) 'face '(:inherit face-faded :weight light))))
                       ;; (propertize "  λ" 'face '(:inherit face-faded :weight light))
                       (propertize "  *" 'face '(:inherit face-faded :weight light))
                       (propertize "  " 'face nil))
                      'front-sticky '(font-lock-face read-only)
                      'rear-nonsticky '(font-lock-face read-only)
                      'read-only t)))
  (setq eshell-banner-message ""
        eshell-prompt-regexp "^.*  .  "
        eshell-hist-ignoredups 'erase
        ;; eshell-review-quick-commands t
        ;; eshell-where-to-jump 'after
        eshell-default-target-is-dot nil
        eshell-cp-interactive-query t
        eshell-cp-overwrite-files nil
        eshell-ln-interactive-query t
        eshell-ln-overwrite-files nil
        eshell-mv-interactive-query t
        eshell-mv-overwrite-files nil
        eshell-prefer-lisp-functions t
        eshell-destroy-buffer-when-process-dies t)

  ;; (add-hook 'eshell-prepare-command-hook
  ;;           (lambda ()
  ;;             (set-frame-name (concat
  ;;                              eshell-last-command-name
  ;;                              " | "
  ;;                              (format-mode-line frame-title-format)))))

  (defun eshell/doas (&rest args)
    "Alias \"doas\" to call Tramp."
    (eshell-eval-using-options
     "doas" args
     '((?h "help" nil nil "show this usage screen")
       (?u "user" t user "execute command as another USER")
       :show-usage
       :parse-leading-options-only
       :usage "[(-u | --user) USER] COMMAND")
     (throw 'eshell-external
            (let* ((user (or user "root"))
                   (host (or (file-remote-p default-directory 'host)
                             tramp-default-host))
                   (dir (file-local-name (expand-file-name default-directory)))
                   (prefix (file-remote-p default-directory))
                   (default-directory
                    (if (and prefix
                             (or (not (string-equal
                                       "doas"
                                       (file-remote-p default-directory 'method)))
                                 (not (string-equal
                                       user
                                       (file-remote-p default-directory 'user)))))
                        (format "%s|doas:%s@%s:%s"
                                (substring prefix 0 -1) user host dir)
                      (format "/doas:%s@%s:%s" user host dir))))
              (eshell-named-command (car args) (cdr args))
              ;; (eshell-command (mapconcat 'identity args " ") t)
              ))))
  (put 'eshell/doas 'eshell-no-numeric-conversions t))

(with-eval-after-load 'em-term
  (setq eshell-visual-subcommands '(("git" "log" "diff" "show")
                                    ("dnf" "upgrade" "install" "remove")
                                    ("systemctl" "status")
                                    ("cargo" "build")
                                    ("rustup" "upgrade")))
  (dolist (cmd '("mpv" "bluetoothctl" "powertop" "nvtop" "unison" "cmus"
                 "wget" "curl" "aria2c" "nmcli"))
    (add-to-list 'eshell-visual-commands cmd)))

(with-eval-after-load 'em-ls
  ;;(set-face 'eshell-ls-clutter 'default)
  ;;(set-face 'eshell-ls-missing 'default)
  ;;(set-face 'eshell-ls-product 'default)
  ;;(set-face 'eshell-ls-special 'default)
  ;;(set-face 'eshell-ls-unreadable 'default)

  (set-face 'eshell-ls-directory 'face-identifier)
  (set-face 'eshell-ls-executable 'face-salient)
  (set-face 'eshell-ls-backup 'face-faded)
  (set-face 'eshell-ls-missing 'face-popout)
  (set-face 'eshell-ls-archive 'face-salient-cyan)
  (set-face 'eshell-ls-symlink 'face-subtle-purple)
  (set-face 'eshell-ls-readonly 'face-salient-green)
  (set-face 'eshell-ls-special 'face-italic))

(defun my/setup-eshell-external (&optional new)
  ;; (with-current-buffer
  ;; (prog1
  (if new
      (eshell 'U)
    (cl-loop for buf being the buffers
             if (and (eq (with-current-buffer buf major-mode) 'eshell-mode)
                     (not (get-buffer-process buf)))
             do (switch-to-buffer buf) and return nil
             finally do (eshell t)))
  (delete-other-windows)
  (setq mode-line-format nil)
  (set-frame-name nil))
;; (add-hook 'kill-buffer-hook (lambda () (set-frame-name nil)) 0 t)
;; (add-hook 'window-configuration-change-hook (lambda ()
;; (unless (eq major-mode 'eshell-mode)
;; (set-frame-name nil)))
;; 0 t)))

;; newsticker
(global-set-key (kbd "C-:") 'newsticker-show-news)
(with-eval-after-load 'newst-treeview
  (setq newsticker-treeview-date-format "%b %d, %I:%M %p  "
        newsticker-date-format "%a %b %d, %I:%M %p")
  (set-face 'newsticker-treeview-face 'default)
  ;; (set-face 'newsticker-treeview-selection-face 'default)
  ;; (set-face 'newsticker-treeview-new-face 'default)
  (set-face 'newsticker-treeview-selection-face 'default
            :weight 'bold
            :background (face-background 'face-block)
            :inherit 'face-salient)
  (set-face 'newsticker-treeview-new-face 'default
            :weight 'bold
            :inherit 'default)
  (set-face-attribute 'newsticker-treeview-old-face nil
                      :weight 'light
                      :inherit 'face-faded)
  (set-face-attribute 'newsticker-feed-face nil
                      :weight 'bold
                      :height 1.2
                      :foreground (face-foreground 'face-strong)
                      :underline t)
  (set-face-attribute 'newsticker-treeview-immortal-face nil
                      :slant 'italic
                      :foreground (face-foreground 'face-strong)))

;; shr html rendering
(with-eval-after-load 'shr
  (set-face 'shr-text 'variable-pitch)
  (set-face-attribute 'shr-text nil :height 1.1)
  (setq shr-bullet "•"
        shr-max-width 85
        ;;    shr-hr-line (kbd "─")))
        shr-hr-line 9472))

;; eww
(with-eval-after-load 'eww
  (setq eww-auto-rename-buffer 'title
        eww-header-line-format nil
        eww-use-external-browser-for-content-type "\\`\\(video/\\|audio/\\|application/ogg\\)")
  (set-face 'eww-form-text 'widget-field)
  (set-face 'eww-form-select 'face-block :box 1)
  (set-face 'eww-form-submit 'face-block :box 1))

(defvar shr-sans-serif-cookie)
(define-minor-mode shr-sans-serif
  "buffer local sans serif for shr"
  :init-value nil
  (if shr-sans-serif
      (setq shr-sans-serif-cookie (list (face-remap-add-relative 'shr-text
                                                                 :family "Cantarell"
                                                                 :height 1.0)
                                        (face-remap-add-relative 'shr-link
                                                                 :weight 'normal)))
    (dolist (face shr-sans-serif-cookie)
      (face-remap-remove-relative face))))

;; authinfo password entry
(setf epa-pinentry-mode 'loopback)

;; shell command
(setq history-length 30
      shell-command-prompt-show-cwd t
      async-shell-command-display-buffer nil
      async-shell-command-buffer 'new-buffer)

;; bookmarks
(with-eval-after-load 'bookmark
  (set-face-attribute 'bookmark-face nil
                      :foreground (face-foreground 'face-strong)
                      :background (face-background 'face-block))
  (setq bookmark-save-flag 1))

;; calc
;; (with-eval-after-load 'calc)
;; (calc-algebraic-mode 1))

;; compilation
(with-eval-after-load 'compile
  (set-face-attribute 'compilation-mode-line-exit nil
                      :weight 'bold
                      :inherit 'face-salient-yellow)
  (set-face-attribute 'compilation-mode-line-fail nil
                      :foreground 'unspecified
                      :weight 'normal
                      :inherit 'face-critical)
  (set-face-attribute 'compilation-mode-line-run nil
                      :inherit 'face-salient))

;; serif mono modes
(add-hook 'Info-mode-hook (lambda ()
                            (my/serif-monospace-fonts)
                            (face-remap-add-relative 'header-line :height 0.8)))
(add-hook 'help-mode-hook (lambda () (unless (string= (buffer-name) "*Faces*")
                                  (my/serif-monospace-fonts))))
(defun my/serif-monospace-fonts ()
  "Set serif monospace fonts for current buffer."
  (interactive)
  (face-remap-add-relative 'default :family "Go Mono")
  (face-remap-add-relative 'header-line :family "Go Mono"))

;; browse-url-handlers
(setq browse-url-handlers '(("https?://melpa\\.org/.*" (lambda (url &rest _args)
                                                         (describe-package (intern (file-name-base url)))))))


(provide 'init-system)