;;; All interface settings
;;; NOTE: Some interface settings are also set in early-init.el, mainly to reduce startup time (percieved and actual)

;; change all yes-or-no prompts to y-or-n
;;(fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)

;; require confirmation to kill
(setq confirm-kill-emacs 'y-or-n-p)

;; enable ido-everywhere
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(setq ido-enable-flex-matching t
;;  ido-file-extensions-order '(".org")
;;  ido-use-virtual-buffers 'auto)
;;  show-help-function nil)

;; minibuffer and completion buffer tweaks
(setq completion-auto-help t
  completion-cycle-threshold 5
  completion-pcm-complete-word-inserts-delimiters t
  completion-styles '(basic flex initials)
  completion-ignore-case t
  completions-detailed t
  completions-format 'vertical
  enable-recursive-minibuffers t
  history-delete-duplicates t
  minibuffer-default-prompt-format " [%s]"
  minibuffer-eldef-shorten-default t
  minibuffer-follows-selected-frame 'hybrid
  minibuffer-prompt-properties '(read-only t cursor-intangible face minibuffer-prompt)
  icomplete-compute-delay 0.05
  icomplete-max-delay-chars 2)
(minibuffer-depth-indicate-mode t)
(minibuffer-electric-default-mode t)

(setq read-buffer-completion-ignore-case t
  read-file-name-completion-ignore-case t)

(fido-mode 1)
(fido-vertical-mode 1)

;; prettify symbols
(global-prettify-symbols-mode 1)

;; windmove bindings
(windmove-default-keybindings)

;; scroll step settings
(setq scroll-step 1
  scroll-conservatively 10000
  mouse-wheel-scroll-amount '(1 ((shift) . 1))
  mouse-wheel-progressive-speed t
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

;; winner mode
(winner-mode 1)

;; read only buffers in view mode
(setq view-read-only t
  help-window-select t)

;; window split function
;; https://www.emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-window-split ()
  "Toggle the window split"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-x |") 'toggle-window-split)

(provide 'interface)
