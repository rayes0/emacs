;;; Text editing, spacing, and all interface settings
;;; NOTE: Some interface settings are also set in early-init.el, mainly to reduce startup time (percieved and actual)

(set-frame-parameter (selected-frame)
                     'internal-border-width 24)

;; Other
(add-to-list 'default-frame-alist '(font . "SFMono-11:medium"))

;; Line spacing
(setq-default line-spacing 0.15)

;; Tab stop width
(setq-default tab-width 4)

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

;; this is a purposefully long line that I hope will show some things in the fringe
;;(fringe-mode '(0 . 0))
;;(defface fallback '((t :family "SFMono 11"
;;                      :inherit 'face-faded)) "Fallback")
;;(set-display-table-slot standard-display-table 'truncation
;;                        (make-glyph-code ?… 'fallback))
;;(set-display-table-slot standard-display-table 'wrap
;;                        (make-glyph-code ?↩ 'fallback))

;; simplified mode line
(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))
(setq-default mode-line-format
     '((:eval
       (mode-line-render
       (format-mode-line (list
         ;; (propertize "☰" 'face `(:inherit mode-line-buffer-id)
         ;;                 'help-echo "Mode(s) menu"
         ;;                 'mouse-face 'mode-line-highlight
         ;;                 'local-map   mode-line-major-mode-keymap)
         " %b "
         (if (and buffer-file-name (buffer-modified-p))
             (propertize "(modified)" 'face `(:inherit face-faded)))))
       (format-mode-line
         (propertize "%4l:%2c | %m " 'face `(:inherit face-faded)))))))

;; move modeline to the top of the buffer
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format'(""))

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

(provide 'interface)
