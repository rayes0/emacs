(require 'general)

(add-hook 'text-mode-hook
  'flyspell-mode
  'variable-pitch-mode
  'visual-line-mode)
(add-hook 'prog-mode
  'flyspell-prog-mode)

(setq
  kill-ring-max 30
  view-read-only t)

;; make some usability changes
(setq-default sentence-end-double-space nil)
(setq compilation-scroll-output t)
(delete-selection-mode t)

(setq backward-delete-char-untabify-method 'hungry
  require-final-newline nil
	mode-require-final-newline nil)

;; flyspell
(global-set-key (kbd "C-`") 'flyspell-auto-correct-previous-word)

;; pair matching
(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                             ))
(add-hook 'org-mode-hook
  (lambda ()
    (setq-local electric-pair-pairs '(
                                       (?\{ . ?\})
                                       (?\( . ?\))
                                       (?\[ . ?\])
                                       (?\" . ?\")
                                       (?\$ . ?\$)
                                       ))
    (electric-pair-local-mode 1)))
(add-hook 'prog-mode-hook 'electric-pair-local-mode)

;; shell script
(require 'sh-script)
(set-face 'sh-quoted-exec     'face-keyword)
(set-face 'sh-heredoc           'face-faded)

;; set indentation settings to tab-width, important to do otherwise emacs screws up indents
(defvaralias 'c-basic-offset     'tab-width)
(defvaralias 'cperl-basic-offset 'tab-width)
(defvaralias 'smie-indent-basic  'tab-width)
(defvaralias 'sh-basic-offset    'tab-width)
(defvaralias 'css-indent-offset  'tab-width)
(defvaralias 'lisp-indent-offset 'tab-width)
(defvaralias 'octave-block-offset 'tab-width)

(provide 'init-text)
