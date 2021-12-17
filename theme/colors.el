;; Colors

(defun set-modeline-faces ()
  "Mode line at top."
  (set-face 'mode-line 'default)
  (set-face 'mode-line-inactive 'face-faded)
  (set-face-attribute 'mode-line nil
    :underline (face-foreground 'face-faded)
    :inherit 'fixed-pitch)
  (set-face-attribute 'mode-line-inactive nil
    :underline (face-foreground 'face-faded)
    :weight 'light
    :inherit 'fixed-pitch)
  (set-face 'header-line 'face-faded)
  (set-face-attribute 'header-line nil
    :slant 'italic
    :inherit 'face-block)
    ;;:underline (face-foreground 'face-faded))
  ;;(set-face-attribute 'mode-line nil
  ;;  :height 10
  ;;  :underline (face-foreground 'default)
  ;;  :overline nil
  ;;  :box nil 
  ;;  :foreground (face-background 'default)
  ;;  :background (face-background 'default))
  ;;(set-face 'mode-line-inactive 'mode-line)

  (set-face-attribute 'window-divider nil
    :foreground (face-background 'mode-line))
  (set-face-attribute 'window-divider-first-pixel nil
    :foreground (face-background 'default))
  (set-face-attribute 'window-divider-last-pixel nil
    :foreground (face-background 'default)))

(defun blossom ()
  (setq frame-background-mode 'light)
  (set-background-color "#ede6e3")
  (set-foreground-color "#6c605a")
  (set-face-attribute 'default nil
    :foreground (face-foreground 'default)
    :background (face-background 'default))
  (set-face-background 'cursor "#6c605a")
  (set-face-attribute 'face-critical nil :foreground "#6c605a"
    :background "#fccec1")
  (set-face-attribute 'face-popout nil :foreground "#9e552f")
    ;;:weight 'bold)
  (set-face-attribute 'face-strong nil :foreground "#574b45")
    ;;:weight 'regular)
  (set-face-attribute 'face-salient nil :foreground "#407680"
    :weight 'light)
  (set-face-attribute 'face-faded nil :foreground "#938680"
    :weight 'light)
  (set-face-attribute 'face-italic-faded nil :foreground "#8f8678"
    :slant 'italic
    :weight 'light)
  (set-face-attribute 'face-italic nil :foreground (face-foreground 'default)
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-subtle nil :background "#e3d0cb")
  (set-face-attribute 'face-block  nil :background "#e7e0dd")

  ;; Code specific faces
  (set-face-attribute 'face-identifier nil :foreground "#9e552f"
    :weight 'bold
    :slant 'italic)
  ;;(set-face-attribute 'face-keyword nil :foreground "#995c8c"
  (set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-pre nil :foreground "#407680"
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-light nil :foreground "#6c605a")

  (set-face-attribute 'show-paren-match nil    :background "#dad3d0"
    :weight 'bold)

  (set-modeline-faces)

  ;; fonts
  (set-face-attribute 'variable-pitch nil
    :family "ETBembo"
    :inherit 'unspecified)
    ;;:height 135)
  (add-to-list 'face-font-rescale-alist '("ETBembo" . 1.2))
  (set-face-attribute 'fixed-pitch nil :family "Cascadia Code")
  
  (with-eval-after-load 'cus-edit (set-button-faces)))

;; Term
(with-eval-after-load 'term
  (set-face 'term-bold 'face-strong)
  (set-face-attribute 'term-color-black nil
    :foreground "#ede6e3"
    :background "#dad3d0")
  (set-face-attribute 'term-color-white nil
    :foreground "#6c605a" :background "#ede6e3")
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
  (set-face-attribute 'face-popout nil :foreground "#aa8f7c")
  (set-face-attribute 'face-strong nil :foreground "#987a6b")
  (set-face-attribute 'face-salient nil :foreground "#bebebe"
    :weight 'light)
  (set-face-attribute 'face-faded nil :foreground "#877979"
    :weight 'light)
  (set-face-attribute 'face-italic-faded nil :foreground "#877979"
    :slant 'italic
    :weight 'light)
  (set-face-attribute 'face-italic nil :foreground (face-foreground 'default)
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-subtle nil :background "#877979")
  (set-face-attribute 'face-block nil :background "#3a3a3a")

  ;; Code specific faces
  (set-face-attribute 'face-identifier nil :foreground "#aa8f7c"
    :weight 'bold
    :slant 'italic)
  ;;(set-face-attribute 'face-keyword nil :foreground "#995c8c"
  (set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-pre nil :foreground "#637a8a"
    :weight 'normal
    :slant 'italic)
  (set-face-attribute 'face-light nil :foreground "#8b8f7e")

  (set-face-attribute 'show-paren-match nil :background "#3a3a3a"
    :weight 'bold)

  (set-modeline-faces)

  ;; fonts
  (set-face-attribute 'variable-pitch nil
    :family "ETBembo"
    :height 135)
  (set-face-attribute 'fixed-pitch nil :family "Cascadia Code" :height 110)

  (with-eval-after-load 'cus-edit (set-button-faces)))

(defun theme-toggle ()
  "Toggle between light and dark theme"
  (interactive)
  (if (eq frame-background-mode 'light)
			(sayo)
		(blossom)))

(provide 'colors)
