;; Colors

(defun set-modeline-faces ()
  "Mode line at top."
  (set-face 'header-line 'face-strong)
  (set-face-attribute 'header-line nil
    :underline (face-foreground 'default))
  (set-face-attribute 'mode-line nil
    :height 10
    :underline (face-foreground 'default)
    :overline nil
    :box nil 
    :foreground (face-background 'default)
    :background (face-background 'default))
  (set-face 'mode-line-inactive 'mode-line)
  (set-face-attribute 'cursor nil
    :background (face-foreground 'default))

  (set-face-attribute 'window-divider nil
    :foreground (face-background 'mode-line))
  (set-face-attribute 'window-divider-first-pixel nil
    :foreground (face-background 'default))
  (set-face-attribute 'window-divider-last-pixel nil
    :foreground (face-background 'default)))

;;(defun my-update-header ()
;;  (mapc
;;    (lambda (window)
;;      (with-current-buffer (window-buffer window)
;;        ;; don't mess with buffers that don't have a header line
;;        (when header-line-format
;;          (let ((original-format (get 'header-line-format 'original))
;;                 (inactive-face 'face-faded)) ; change this to your favorite inactive header line face
;;            ;; if we didn't save original format yet, do it now
;;            (when (not original-format)
;;              (put 'header-line-format 'original header-line-format)
;;              (setq original-format header-line-format))
;;            ;; check if this window is selected, set faces accordingly
;;            (if (eq window (selected-window))
;;              (setq header-line-format original-format)
;;              (setq header-line-format `(:propertize ,original-format face ,inactive-face)))))))
;;    (window-list)))
;;(add-hook 'buffer-list-update-hook #'my-update-header)

(defun blossom ()
  (setq frame-background-mode 'light)
  (set-background-color "#ede6e3")
  (set-foreground-color "#6c605a")
  (set-face-attribute 'default nil
    :foreground (face-foreground 'default)
    :background (face-background 'default))
  (set-face-attribute 'face-critical nil :foreground "#6c605a"
    :background "#fccec1")
  (set-face-attribute 'face-popout nil :foreground "#9e552f"
    :weight 'bold)
  (set-face-attribute 'face-strong nil :foreground "#574b45"
    :weight 'regular)
  (set-face-attribute 'face-salient nil :foreground "#407680"
    :weight 'light)
  (set-face-attribute 'face-faded nil :foreground "#938680"
    :weight 'light)
  (set-face-attribute 'face-italic-faded nil :foreground "#8f8678"
    :font "Victor Mono Medium Italic"
    :height 113)
  (set-face-attribute 'face-italic nil :foreground (face-foreground 'default)
    :font "Victor Mono Medium Italic"
    :height 113)
  (set-face-attribute 'face-subtle nil :background "#e3d0cb")

  ;; Code specific faces
  (set-face-attribute 'face-identifier nil :foreground "#9e552f"
    :font "Victor Mono Semibold Italic"
    :height 113)
  ;;(set-face-attribute 'face-keyword nil :foreground "#995c8c"
  (set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
    :font "Victor Mono Semibold Italic"
    :height 113)
  (set-face-attribute 'face-pre nil :foreground "#407680"
    :font "Victor Mono Medium Italic"
    :height 113)
  (set-face-attribute 'face-light nil :foreground "#6c605a" :weight 'semi-light)

  (set-face-attribute 'show-paren-match nil    :background "#dad3d0"
    :weight 'bold)

  (set-modeline-faces)

  ;; fonts
  (set-face-attribute 'variable-pitch nil
    :family "ETBembo"
    :height 147)
  (set-face-attribute 'fixed-pitch nil :family "SFMono" :height 113)
  
  (with-eval-after-load 'cus-edit (set-button-faces)))

;; Term
(with-eval-after-load 'term
  ;; (setq eterm-256color-disable-bold nil)
  (set-face 'term-bold 'face-strong)
  (set-face-attribute 'term-color-black nil
    :foreground (face-foreground 'default)
    :background (face-foreground 'default))
  (set-face-attribute 'term-color-white nil
    :foreground "white" :background "white")
  (set-face-attribute 'term-color-blue nil
    :foreground "#8f8678" :background "#8f8678")
  (set-face-attribute 'term-color-cyan nil
    :foreground "#75998e" :background "#75998e")
  (set-face-attribute 'term-color-green nil
    :foreground "#839773" :background "#839773")
  (set-face-attribute 'term-color-magenta nil
    :foreground "#9c7b9c" :background "#9c7b9c")
  (set-face-attribute 'term-color-red nil
    :foreground "#ce9c85" :background "#ce9c85")
  (set-face-attribute 'term-color-yellow nil
    :foreground "#a09c80" :background "#a09c80"))

;; Dark theme
(defun sayo ()
  (setq frame-background-mode 'dark)
  (set-background-color "#2a2a2a")
  (set-foreground-color "#bebebe")

  (set-face-attribute 'default nil
    :foreground (face-foreground 'default)
    :background (face-background 'default))
  (set-face-attribute 'face-critical nil :foreground "#937f74"
    :background "#3a3a3a")
  (set-face-attribute 'face-popout nil :foreground "#aa8f7c"
    :weight 'bold)
  (set-face-attribute 'face-strong nil :foreground "#987a6b"
    :weight 'regular)
  (set-face-attribute 'face-salient nil :foreground "#bebebe"
    :weight 'light)
  (set-face-attribute 'face-faded nil :foreground "#877979"
    :weight 'light)
  (set-face-attribute 'face-italic-faded nil :foreground "#877979"
    :font "Victor Mono Medium Italic"
    :height 117)
  (set-face-attribute 'face-italic nil :foreground (face-foreground 'default)
    :font "Victor Mono Medium Italic"
    :height 117)
  (set-face-attribute 'face-subtle nil :background "#877979")

  ;; Code specific faces
  (set-face-attribute 'face-identifier nil :foreground "#aa8f7c"
    :font "Victor Mono Semibold Italic"
    :height 117)
  ;;(set-face-attribute 'face-keyword nil :foreground "#995c8c"
  (set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
    :font "Victor Mono Semibold Italic"
    :height 117)
  (set-face-attribute 'face-pre nil :foreground "#637a8a"
    :font "Victor Mono Medium Italic"
    :height 117)
  (set-face-attribute 'face-light nil :foreground "#8b8f7e")

  (set-face-attribute 'show-paren-match nil :background "#3a3a3a"
    :weight 'bold)

  (set-modeline-faces)

  ;; fonts
  (set-face-attribute 'variable-pitch nil
    :family "ETBembo"
    :height 147)
  (set-face-attribute 'fixed-pitch nil :family "SFMono" :height 113)
  (with-eval-after-load 'cus-edit (set-button-faces)))

(defun theme-toggle ()
  "Toggle between light and dark theme"
  (interactive)
  (if (eq frame-background-mode 'light)
			(sayo)
		(blossom)))

(provide 'colors)
