;; -*- lexical-binding: t -*-
;;; Settings for various interaction with the host system and emacs ecosystem

(setq eval-expression-print-level nil
  eval-expression-print-length nil)

;; dired
(with-eval-after-load 'dired
  (setq dired-dwim-target t
    dired-listing-switches "-Alh"
    dired-use-ls-dired t
    dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\|\\`[.].*\\'"
    dired-always-read-filesystem t
    dired-create-destination-dirs 'ask
    dired-hide-details-hide-symlink-targets nil
    dired-isearch-filenames 'dwim)
  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))))
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'dired-omit-mode)

;; tramp
(setq tramp-default-method "ssh")

;; docview
(setq doc-view-resolution 300)
(setq doc-view-continuous t)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(with-eval-after-load 'ibuffer
  (setq ibuffer-expert t
    ibuffer-show-empty-filter-groups nil)
  (defun my/human-readable-file-sizes-to-bytes (string)
    "Convert a human-readable file size into bytes."
    (interactive)
    (cond
      ((string-suffix-p "G" string t)
        (* 1000000000 (string-to-number (substring string 0 (- (length string) 1)))))
      ((string-suffix-p "M" string t)
        (* 1000000 (string-to-number (substring string 0 (- (length string) 1)))))
      ((string-suffix-p "K" string t)
        (* 1000 (string-to-number (substring string 0 (- (length string) 1)))))
      (t
        (string-to-number (substring string 0 (- (length string) 1))))))

  (defun my/bytes-to-human-readable-file-sizes (bytes)
    "Convert number of bytes to human-readable file size."
    (interactive)
    (cond
      ((> bytes 1000000000) (format "%10.1fG" (/ bytes 1000000000.0)))
      ((> bytes 100000000) (format "%10.0fM" (/ bytes 1000000.0)))
      ((> bytes 1000000) (format "%10.1fM" (/ bytes 1000000.0)))
      ((> bytes 100000) (format "%10.0fk" (/ bytes 1000.0)))
      ((> bytes 1000) (format "%10.1fk" (/ bytes 1000.0)))
      (t (format "%10d" bytes))))

  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size"
      :inline t
      :summarizer
      (lambda (column-strings)
        (let ((total 0))
          (dolist (string column-strings)
            (setq total
              (+ (float (my/human-readable-file-sizes-to-bytes string))
                total)))
          (my/bytes-to-human-readable-file-sizes total)))
      )
    (my/bytes-to-human-readable-file-sizes (buffer-size)))

  ;; Modify the default ibuffer-formats
  (setq ibuffer-formats
    '((mark modified read-only locked " "
        (name 20 20 :left :elide)
        " "
        (size-h 11 -1 :right)
        " "
        (mode 16 16 :left :elide)
        " "
        filename-and-process)
       (mark " "
         (name 16 -1)
         " " filename))))

;; ansi colors
(with-eval-after-load 'ansi-color
  (setq ansi-color-names-vector
    ["#ede6e3" "#ce9c85" "#839773" "#a09c80" "#8f8678" "#9c7b9c" "#75998e" "#685c56"])
  (setq ansi-color-map (ansi-color-make-color-map)))

(with-eval-after-load 'comint
  (ansi-color-for-comint-mode-on)
  (setq comint-prompt-read-only t
    comint-input-ignoredups t
    comint-completion-autolist t))
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output))

(with-eval-after-load 'compile
  (setq ansi-color-for-compilation-mode t)
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter))

;; eshell
(with-eval-after-load 'eshell
  (setq eshell-highlight-prompt nil)
  (setq eshell-prompt-function
    (lambda nil
      (propertize (concat
                    (if (string= (eshell/pwd) (getenv "HOME"))
                      (propertize "~" 'face '(:inherit face-faded :weight light))
                      (replace-regexp-in-string
                        (getenv "HOME")
                        (propertize "~" 'face '(:inherit face-faded :weight light))
                        (propertize (eshell/pwd) 'face '(:inherit face-faded :weight light))))
                    (propertize "  λ" 'face '(:inherit face-faded :weight light))
                    (propertize "  " 'face nil))
        'front-sticky '(font-lock-face read-only)
        'rear-nonsticky '(font-lock-face read-only)
        'read-only t)))
  (setq eshell-banner-message ""
    eshell-prompt-regexp "^.*  λ  "
    eshell-hist-ignoredups 'erase
    eshell-review-quick-commands t
    eshell-where-to-jump 'after
    eshell-cp-interactive-query t
    eshell-cp-overwrite-files nil
    eshell-ln-interactive-query t
    eshell-ln-overwrite-files nil
    eshell-mv-interactive-query t
    eshell-mv-overwrite-files nil))

(with-eval-after-load 'em-term
  (setq eshell-visual-subcommands '(("git" "log" "diff" "show")
                                     ("sudo" "dnf" "upgrade")
                                     ("doas" "dnf" "upgrade")
                                     ("systemctl" "status")
                                     ("cargo" "build")
                                     ("rustup" "upgrade")))
  (dolist (cmd '("mpv" "bluetoothctl" "powertop" "nvtop" "unison" "cmus"
                  "wget" "curl" "aria2c"))
    (add-to-list 'eshell-visual-commands cmd)))

(with-eval-after-load 'em-ls
  ;;(set-face 'eshell-ls-backup 'default)
  ;;(set-face 'eshell-ls-clutter 'default)
  ;;(set-face 'eshell-ls-symlink 'default)
  ;;(set-face 'eshell-ls-missing 'default)
  ;;(set-face 'eshell-ls-archive 'default)
  ;;(set-face 'eshell-ls-product 'default)
  ;;(set-face 'eshell-ls-special 'default)
  ;;(set-face 'eshell-ls-readonly 'default)
  ;;(set-face 'eshell-ls-unreadable 'default)

  (set-face 'eshell-ls-directory 'default)
  (set-face-attribute 'eshell-ls-directory nil :weight 'bold)
  (set-face 'eshell-ls-executable 'face-salient)
  (set-face-attribute 'eshell-ls-executable nil :weight 'normal))

;; newsticker
(global-set-key (kbd "C-:") 'newsticker-show-news)
(with-eval-after-load 'newst-treeview
  (setq newsticker-treeview-date-format "%b %d, %I:%M %p  "
    newsticker-date-format "%a %b %d, %I:%M %p")
  (set-face 'newsticker-treeview-face 'default)
  (set-face 'newsticker-treeview-selection-face 'default)
  (set-face 'newsticker-treeview-new-face 'default)
  (set-face-attribute 'newsticker-treeview-selection-face nil
    :weight 'bold
    :background (face-background 'face-block)
    :inherit 'face-salient)
  (set-face-attribute 'newsticker-treeview-new-face nil
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
  (setq shr-bullet "•"
    shr-max-width 80
    ;;    shr-hr-line (kbd "─")))
    shr-hr-line 9472))

;; authinfo password entry
(setf epa-pinentry-mode 'loopback)

;; shell command
(setq history-length 30
  shell-command-prompt-show-cwd t
  async-shell-command-display-buffer nil
  async-shell-command-buffer 'new-buffer)

;; Based off https://emacs.stackexchange.com/questions/48954/the-elisp-function-to-run-the-shell-command-in-specific-file-path#
(defun ad-read-default-directory-args (interactive-spec)
  "Read default directory and apply INTERACTIVE-SPEC.
  Return a list (DIRECTORY PREFIX-ARG RESULT-OF-INTERACTIVE-SPEC).
  The default directory is only read with numeric `current-prefix-arg'."
  (let ((default-directory (or
                             (and
                               (numberp current-prefix-arg)
                               (expand-file-name (read-directory-name "Default directory: " nil nil t)))
                             default-directory))
         (current-prefix-arg (and (numberp current-prefix-arg)
                               (null (< current-prefix-arg 0))
                               current-prefix-arg)))
    (append
      (list
        current-prefix-arg ;; never a string
        default-directory)
      (advice-eval-interactive-spec interactive-spec))))

(defun ad-read-default-directory-&-call (fun &rest args)
  "Run FUN with ARGS with `default-directory' set to DIRECTORY and PREFIX-ARG.
  Only change `default-directory' if the prefix arg is numeric.
  Positive prefix args are passed to FUN negative are not."
  (interactive #'ad-read-default-directory-args)
  (if (stringp (car args))
    (apply fun args)
    (let ((default-directory (or (cl-second args) default-directory))
           (current-prefix-arg (cl-first args)))
      (apply fun (nthcdr 2 args)))))

(advice-add 'shell-command :around #'ad-read-default-directory-&-call)
(advice-add 'async-shell-command :around #'ad-read-default-directory-&-call)

;; bookmarks
(with-eval-after-load 'bookmark
  (set-face-attribute 'bookmark-face nil
    :foreground (face-foreground 'face-strong)
    :background (face-background 'face-block))
  (setq bookmark-save-flag 1))

(provide 'init-system)