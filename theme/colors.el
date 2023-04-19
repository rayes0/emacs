;; core colors and faces  -*- lexical-binding: t; -*-

(defun set-face (face style &rest extra)
  "Make a FACE inherit STYLE, with EXTRA attributes if provided."
  (when style
    (set-face-attribute face nil
                        :foreground 'unspecified :background 'unspecified
                        :family     'unspecified :slant      'unspecified
                        :weight     'unspecified :height     'unspecified
                        :underline  'unspecified :overline   'unspecified
                        :box        'unspecified :inverse-video 'unspecified
                        :extend     'unspecified :inherit style))
  (when extra
    (apply #'set-face-attribute face nil extra)))

(defgroup blossom nil
  "Faces for the blossom theme"
  :prefix "face-")

(setq custom-unlispify-remove-prefixes t)

(defface face-critical nil
  "Face requiring immmediate attention"
  :group 'blossom)

(defface face-popout nil
  "Attention grabbing face"
  :group 'blossom)

(defface face-strong nil
  "Bold face, titles, keywords, etc."
  :group 'blossom)

(defface face-salient nil
  "Important face, with a different hue"
  :group 'blossom)

(defface face-salient-green nil
  "Alternative to `face-salient' with different hue"
  :group 'blossom)

(defface face-salient-cyan nil
  "Alternative to `face-salient' with different hue"
  :group 'blossom)

(defface face-salient-yellow nil
  "Alternative to `face-salient' with different hue"
  :group 'blossom)

(defface face-faded nil
  "Less important face"
  :group 'blossom)

(defface face-italic-faded nil
  "faded italic version"
  :group 'blossom)

(defface face-italic nil
  "normal italic face"
  :group 'blossom)

(defface face-subtle nil
  "background face for suggesting physical areas"
  :group 'blossom)

(defface face-subtle-purple nil
  "purple face for certain physical areas"
  :group 'blossom)

(defface face-block nil
  "face with background tint for block"
  :group 'blossom)

;; Code faces

(defface face-identifier nil
  "Code face for identifiers such as function names"
  :group 'blossom)

(defface face-keyword nil
  "Code face for keywords, if, else, let, fn, etc."
  :group 'blossom)

(defface face-pre nil
  "Code face for other special things like preprocessors"
  :group 'blossom)

(defface face-light nil
  "Code face for demphasized things, but not as light as face-faded"
  :group 'blossom)

(defun blossom ()
  (setq frame-background-mode 'light)
  (set-background-color "#ede6e3")
  (set-foreground-color "#6c605a")
  (set-face-attribute 'default nil
                      :foreground "#6c605a"
                      ;; (face-foreground 'default)
                      :background "#ede6e3"
                      ;; (face-background 'default)
                      )
  (set-face-attribute 'face-critical nil :foreground "#6c605a" :background "#fccec1")
  (set-face-attribute 'face-popout nil :foreground "#9e552f")
  (set-face-attribute 'face-strong nil :foreground "#574b45")
  (set-face-attribute 'face-salient nil :foreground "#407680" :weight 'light)
  (set-face-attribute 'face-salient-green nil :foreground "#8a5958" :weight 'light)
  (set-face-attribute 'face-salient-cyan nil :foreground "#75998e" :weight 'normal)
  (set-face-attribute 'face-salient-yellow nil :foreground "#a09c80")
  (set-face-attribute 'face-faded nil :foreground "#938680" :weight 'light)
  (set-face-attribute 'face-italic-faded nil :foreground "#8f8678" :slant 'italic :weight 'light)
  (set-face-attribute 'face-italic nil :foreground (face-foreground 'default) :weight 'normal :slant 'italic)
  ;; (set-face-attribute 'face-subtle nil :background "#f5cbcd")
  ;; (set-face-attribute 'face-subtle nil :background "#f5d8d8")
  (set-face-attribute 'face-subtle nil :background "#f5dad8")
  (set-face-attribute 'face-subtle-purple nil :background "#f0d8f5")
  (set-face-attribute 'face-block  nil :background "#e7e0dd")

  ;; Code specific faces
  ;; (set-face-attribute 'face-identifier nil :foreground "#9e552f"
  (set-face-attribute 'face-identifier nil :foreground "#9c7b9c"
                      :weight 'bold
                      :slant 'normal)
  (set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
                      :weight 'normal
                      :slant 'italic)
  (set-face-attribute 'face-pre nil :foreground "#407680"
                      :weight 'normal
                      :slant 'italic)
  (set-face-attribute 'face-light nil :foreground "#82756f"))

;; (with-eval-after-load 'cus-edit (set-button-faces)))

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

(with-eval-after-load 'ansi-color
  (set-face-attribute 'ansi-color-black nil
                      :foreground "#ede6e3" :background "#ede6e3")
  (set-face-attribute 'ansi-color-bright-black nil
                      :foreground "#dad3d0" :background "#dad3d0")
  (set-face-attribute 'ansi-color-white nil
                      :foreground "#6c605a" :background "#6c605a")
  (set-face-attribute 'ansi-color-blue nil
                      :foreground "#8f8678" :background "#8f8678")
  (set-face-attribute 'ansi-color-cyan nil
                      :foreground "#75998e" :background "#75998e")
  (set-face-attribute 'ansi-color-green nil
                      :foreground "#839773" :background "#839773")
  (set-face-attribute 'ansi-color-magenta nil
                      :foreground "#9c7b9c" :background "#9c7b9c")
  (set-face-attribute 'ansi-color-red nil
                      :foreground "#ce9c85" :background "#ce9c85")
  (set-face-attribute 'ansi-color-yellow nil
                      :foreground "#a09c80" :background "#a09c80")

  (set-face 'ansi-color-bright-white 'ansi-color-white)
  (set-face 'ansi-color-bright-blue 'ansi-color-blue)
  (set-face 'ansi-color-bright-cyan 'ansi-color-cyan)
  (set-face 'ansi-color-bright-green 'ansi-color-green)
  (set-face 'ansi-color-bright-magenta 'ansi-color-magenta)
  (set-face 'ansi-color-bright-red 'ansi-color-red)
  (set-face 'ansi-color-bright-yellow 'ansi-color-yellow))

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
  
  ;; (with-eval-after-load 'cus-edit (set-button-faces))
  )

(defun theme-toggle ()
  "Toggle between light and dark theme"
  (interactive)
  (if (eq frame-background-mode 'light)
			(sayo)
		(blossom)))

;; default theme
(blossom)

(provide 'colors)
