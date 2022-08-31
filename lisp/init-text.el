;; Text editing features -*- lexical-binding: t; -*-
(require 'general)

(global-so-long-mode 1)
(add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'variable-pitch-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(dolist (exception '(nxml-mode-hook))
  (add-hook exception (lambda () (variable-pitch-mode -1))))

(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)

(setq flyspell-use-meta-tab nil)
(with-eval-after-load 'flyspell
  (setq flyspell-prog-text-faces '(font-lock-comment-face font-lock-doc-face)))

;; folding
(with-eval-after-load 'hideshow
  (setq hs-allow-nesting t)
  (define-key hs-minor-mode-map (kbd "C-c f") (lookup-key hs-minor-mode-map (kbd "C-c @")))
  (define-key hs-minor-mode-map (kbd "C-c TAB") 'hs-toggle-hiding)
  (define-key hs-minor-mode-map (kbd "C-c <backtab>") 'hs-hide-level))

(global-set-key (kbd "C-`") 'flyspell-auto-correct-previous-word)

(setq kill-ring-max 30
      view-read-only t
      compilation-scroll-output t)

(setq-default fill-column 80)

(substitute-key-definition 'just-one-space 'cycle-spacing global-map)

(setq-default sentence-end-double-space nil)
(delete-selection-mode 1)

(setq backward-delete-char-untabify-method nil
      require-final-newline nil
	    mode-require-final-newline nil)

;; pair matching
(add-hook 'prog-mode-hook 'electric-pair-local-mode)
(setq electric-pair-pairs '((?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")))

(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode 1)
            (setq-local electric-pair-pairs '((?\{ . ?\})
                                              (?\( . ?\))
                                              (?\[ . ?\])
                                              (?\" . ?\")
                                              (?\$ . ?\$)))
            (electric-pair-local-mode 1)))

;; occur
(defun my/occur-run-or-raise ()
  (interactive)
  (if (get-buffer "*Occur*")
      (switch-to-buffer-other-window "*Occur*")
    (call-interactively 'occur)))
(global-set-key (kbd "C-c o") 'my/occur-run-or-raise)

;; shell script
(require 'sh-script)
(set-face 'sh-quoted-exec     'face-keyword)
(set-face 'sh-heredoc           'face-faded)

;; global indentation settings to tab-width
(defvaralias 'c-basic-offset     'tab-width)
(defvaralias 'cperl-basic-offset 'tab-width)
(defvaralias 'smie-indent-basic  'tab-width)
(defvaralias 'sh-basic-offset    'tab-width)
(defvaralias 'css-indent-offset  'tab-width)
(defvaralias 'octave-block-offset 'tab-width)

;; lisp indenting
(load-library "cl-indent")
;; (setq lisp-indent-function #'common-lisp-indent-function)
(setq lisp-indent-function #'lisp-indent-function)
;; (autoload 'common-lisp-indent-function "cl-indent" "Common Lisp indent.")
;; (cl-loop for symbol being the symbols
;;          for cl-indent-rule = (get symbol 'common-lisp-indent-function)
;;          for elisp-equivalent = (intern-soft (concat "cl-" (symbol-name symbol)))
;;          when (and cl-indent-rule elisp-equivalent (fboundp elisp-equivalent))
;;          do (put elisp-equivalent 'common-lisp-indent-function cl-indent-rule))

;; navigate subwords
(global-subword-mode 1)

;; dwim
(substitute-key-definition 'upcase-word 'upcase-dwim (current-global-map))
(substitute-key-definition 'downcase-word 'downcase-dwim (current-global-map))
(substitute-key-definition 'capitalize-word 'capitalize-dwim (current-global-map))

(provide 'init-text)
