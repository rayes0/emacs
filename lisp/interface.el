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
  mouse-wheel-scroll-amount '(1 ((shift) . 1))
  mouse-wheel-progressive-speed nil
  mouse-wheel-follow-mouse 't)

;; Other
(add-to-list 'default-frame-alist '(font . "SFMono-11:medium"))

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
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))

(setq-default mode-line-format
  '((:eval
      (mode-line-render
        (format-mode-line (list
                            " %b "
                            (if (and buffer-file-name (buffer-modified-p))
                              (propertize "(modified)" 'face `(:inherit face-faded)))))
        (format-mode-line
          (propertize "%4l:%2c | %m " 'face `(:inherit face-faded)))))))


;; use only the header line
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format'(""))

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

;; allow recursive minibuffer
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode t)

(provide 'interface)
