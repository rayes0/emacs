;;; Text editing, spacing, and all interface settings
;;; NOTE: Some interface settings are also set in early-init.el, mainly to reduce startup time (percieved and actual)

;; don't auto add newline at end of file
(setq require-final-newline nil
  mode-require-final-newline nil)

;; change all yes-or-no prompts to y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; enable ido-everywhere
(ido-mode 1)
(ido-everywhere 1)

;; icomplete mode
(icomplete-mode 1)

;; windmove bindings
(windmove-default-keybindings)

;; scroll step settings
(setq scroll-step 1
  scroll-conservatively 10000
  mouse-wheel-scroll-amount '(3 ((shift) . 1))
  mouse-wheel-progressive-speed nil
  mouse-wheel-follow-mouse t)

;; Other
(add-to-list 'default-frame-alist '(font . "Cascadia Code 11"))
(set-face-attribute 'default nil :font "Cascadia Code 11")

;; Line spacing
(setq-default line-spacing 0.15)

;; Tab settings, use spaces by default
(setq-default indent-tabs-mode nil
  tab-stop-list ()
  tab-width 2)
(setq backward-delete-char-untabify-method 'hungry)

;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)

;; No ugly button for checkboxes
(setq widget-image-enable nil)

;; Line cursor and no blink
(set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)

;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Paren mode is part of the theme
(show-paren-mode t)

;; mode line
(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (append left
    (list (format (format "%%%ds" (- (window-total-width)
                      (+ (length (format-mode-line left))
                        (length (format-mode-line right)))))
            ""))
    right))

;;(defun mode-line-right-render (text)
;;  (format "%s%s"
;;    (propertize " "
;;      'display
;;      `((space :align-to (- right, (length (format-mode-line text))))))
;;    (format-mode-line text)))

(setq-default mode-line-format
  '((:eval (mode-line-render
             (list " %I %P")
             (list
               (propertize "%b" 'face `(:slant italic))
               (if (and buffer-file-name (buffer-modified-p))
                 (propertize "*" 'face `(:inherit face-faded)))
               (propertize " (%m)" 'face `(:inherit face-faded))
               )))))


;; use only the header line
;;(setq-default header-line-format mode-line-format)
;;(setq-default mode-line-format nil)

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

;; allow recursive minibuffer
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode t)

;; replace list-buffers with ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

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
      (string-to-number (substring string 0 (- (length string) 1))))
    )
  )

(defun my/bytes-to-human-readable-file-sizes (bytes)
  "Convert number of bytes to human-readable file size."
  (interactive)
  (cond
    ((> bytes 1000000000) (format "%10.1fG" (/ bytes 1000000000.0)))
    ((> bytes 100000000) (format "%10.0fM" (/ bytes 1000000.0)))
    ((> bytes 1000000) (format "%10.1fM" (/ bytes 1000000.0)))
    ((> bytes 100000) (format "%10.0fk" (/ bytes 1000.0)))
    ((> bytes 1000) (format "%10.1fk" (/ bytes 1000.0)))
    (t (format "%10d" bytes)))
  )

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
       " " filename)))

(provide 'interface)
