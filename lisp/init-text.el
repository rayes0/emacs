(add-hook 'text-mode-hook
		  'flyspell-mode
		  'variable-pitch-mode
		  'visual-line-mode)

(require 'general)

;; shell script
(require 'sh-script)
(set-face 'sh-quoted-exec     'face-keyword)
(set-face 'sh-heredoc           'face-faded)

;; set indentation settings to tab-width, important to do otherwise emacs screws up indents
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-basic-offset 'tab-width)
(defvaralias 'smie-indent-basic 'tab-width)
(defvaralias 'sh-basic-offset 'tab-width)

(provide 'init-text)
