;; Markdown config

(require 'markdown-mode)

(add-hook 'markdown-mode-hook (lambda ()
								(visual-line-mode t)
								(variable-pitch-mode t)
								(flyspell-mode t)))

(setq-default
 markdown-hide-markup t)

;; The set-face function is designed in theme/general.el
(require 'general)
(set-face 'markdown-header-face 'face-strong)
;;(set-face 'markdown-header-face-1 'face-strong)
;;(set-face 'markdown-header-face-2 'face-strong)
;;(set-face 'markdown-header-face-3 'face-strong)
;;(set-face 'markdown-header-face-4 'face-strong)
;;(set-face 'markdown-header-face-5 'face-strong)
;;(set-face 'markdown-header-face-6 'face-strong)

(set-face-attribute 'markdown-header-face-1 nil :height 200 :weight 'bold)
(set-face-attribute 'markdown-header-face-2 nil :height 190 :slant 'italic)
(set-face-attribute 'markdown-header-face-3 nil :height 185 :slant 'italic)
(set-face-attribute 'markdown-header-face-4 nil :height 175 :slant 'italic)
(set-face-attribute 'markdown-header-face-5 nil :height 175 :slant 'italic)
(set-face-attribute 'markdown-header-face-6 nil :height 175 :slant 'italic)

(set-face-attribute 'markdown-metadata-key-face nil :inherit '(fixed-pitch face-faded))
(set-face-attribute 'markdown-metadata-value-face nil :inherit '(fixed-pitch face-faded))

(provide 'init-mdown)