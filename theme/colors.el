; Colors

(defun set-modeline-faces ()
	"Mode line at top."
	(set-face 'header-line                                 'face-strong)
	(set-face-attribute 'header-line nil
	                              :underline (face-foreground 'default))
	(set-face-attribute 'mode-line nil
	                    :height 10
	                    :underline (face-foreground 'default)
	                    :overline nil
	                    :box nil 
	                    :foreground (face-background 'default)
	                    :background (face-background 'default))
	(set-face 'mode-line-inactive                            'mode-line)
	(set-face-attribute 'cursor nil
	                    :background (face-foreground 'default))

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
							:height 117)
	(set-face-attribute 'face-italic nil :foreground (face-foreground 'default)
							:font "Victor Mono Medium Italic"
							:height 117)
    (set-face-attribute 'face-subtle nil :background "#e3d0cb")

	;; Code specific faces
	(set-face-attribute 'face-identifier nil :foreground "#9e552f"
						:font "Victor Mono Semibold Italic"
						:height 117)
	;;(set-face-attribute 'face-keyword nil :foreground "#995c8c"
	(set-face-attribute 'face-keyword nil :foreground (face-foreground 'default)
						:font "Victor Mono Semibold Italic"
						:height 117)
	(set-face-attribute 'face-pre nil :foreground "#407680"
						:font "Victor Mono Medium Italic"
						:height 117)
	(set-face-attribute 'face-light nil :foreground "#938680")

    (set-face-attribute 'show-paren-match nil    :background "#dad3d0"
					                             :weight 'bold)

    (set-modeline-faces)

    ;; fonts
	(let* ((serif-font (cond ((x-list-fonts "ETBembo") "ETBembo")
				             ((x-list-fonts "Cormorant Garamond") "Cormorant Garamond")
				             ((x-family-fonts "Serif") "Serif")
							 (nil (warn "Can't find a font")))))
    (set-face-attribute 'variable-pitch nil
						:family serif-font
						:height 147))
    (set-face-attribute 'fixed-pitch nil :family "SFMono" :height 113)
    
    (with-eval-after-load 'cus-edit (set-button-faces)))

    ;; (set-face 'term-color-red nil  :foreground "#ce9c85")
    ;; (set-face 'term-color-green nil :foreground "#839773")
    ;; (set-face 'term-color-yellow nil :foreground "#a09c80")
    ;; (set-face 'term-color-blue nil :foreground "#8f8678")
    ;; (set-face 'term-color-magenta nil :foreground "#9c7b9c")
    ;; (set-face 'term-color-cyan nil :foreground "#75998e")

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

    (set-face-attribute 'show-paren-match nil    :background "#3a3a3a"
					                             :weight 'bold)

    (set-modeline-faces)

    ;; fonts
	(defun serif-font ()
			(cond ((x-list-fonts "ETBembo") '"ETBembo")
				  ((x-list-fonts "Cormorant Garamond") '"Cormorant Garamond")
				  ((x-family-fonts "Serif") '"Serif")))
    (set-face-attribute 'variable-pitch nil
						:family (serif-font)
						:height 147)
    (set-face-attribute 'fixed-pitch nil :family "SFMono" :height 113)
    (with-eval-after-load 'cus-edit (set-button-faces)))

(defun theme-toggle ()
  "Toggle between light adn dark theme"
  (interactive)
  (if (eq frame-background-mode 'light)
	  (sayo)
	(blossom)))

(provide 'colors)
