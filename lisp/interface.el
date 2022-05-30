;; All interface settings  -*- lexical-binding: t; -*-
;; Some interface settings are also set in early-init.el, mainly to reduce startup time (percieved and actual)

(require 'general)

(setq use-short-answers t
      confirm-kill-emacs
      (lambda (&optional _)
        (yes-or-no-p
         (concat (propertize "I-it's not like I'll miss you or anything, b-baka! "
                             'face 'face-italic-faded)
                 (propertize "Really quit emacs?"
                             'face 'face-salient))))
      custom-raised-buttons nil)
;; (set-face-attribute 'custom-button nil
;; :background )

;; enable ido-everywhere
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(setq ido-enable-flex-matching t
;;  ido-file-extensions-order '(".org")
;;  ido-use-virtual-buffers 'auto)
;;  show-help-function nil)

;; minibuffer and completion buffer tweaks
(setq completion-auto-help t
      completion-cycle-threshold 5
      completion-pcm-complete-word-inserts-delimiters t
      completion-styles '(basic flex initials)
      completion-ignore-case t
      completions-detailed t
      completions-format 'vertical
      enable-recursive-minibuffers t
      history-delete-duplicates t
      minibuffer-default-prompt-format " [%s]"
      minibuffer-eldef-shorten-default t
      minibuffer-follows-selected-frame 'hybrid
      minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)
      icomplete-compute-delay 0.05
      icomplete-max-delay-chars 2)

(minibuffer-depth-indicate-mode t)
(minibuffer-electric-default-mode t)

(setq read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

(fido-mode 1)
(fido-vertical-mode 1)

(global-prettify-symbols-mode 1)
(windmove-default-keybindings)

(setq scroll-step 1
      scroll-conservatively 10000
      mouse-wheel-scroll-amount '(2 ((shift) . 1))
      mouse-wheel-progressive-speed t
      mouse-wheel-follow-mouse t)
(show-paren-mode t)

(require 'pixel-scroll)
(setq pixel-wait 1
      pixel-resolution-fine-flag 1
      pixel-dead-time 0
      pixel-scroll-precision-initial-velocity-factor 0.008375
      pixel-scroll-precision-interpolate-page t
      pixel-scroll-precision-large-scroll-height 40
      pixel-scroll-precision-interpolation-factor 4
      pixel-scroll-precision-interpolation-total-time 0.06
      pixel-scroll-precision-interpolation-between-scroll 0.003

      pixel-scroll-precision-use-momentum nil
      pixel-scroll-precision-momentum-min-velocity 15.0)
(pixel-scroll-precision-mode 2)

(setq eldoc-idle-delay 0.1)

;; fonts
(add-to-list 'default-frame-alist '(font . "Cascadia Code 11"))
(set-face-attribute 'default nil :font "Cascadia Code 11")
(set-face-attribute 'fixed-pitch nil :family "Cascadia Code")
(set-face-attribute 'variable-pitch nil :family "ETBembo" :inherit 'unspecified)
(set-face-attribute 'variable-pitch-text nil
                    :family "Cantarell"
                    :height 120)
(add-to-list 'face-font-rescale-alist '("ETBembo" . 1.2))
;; (add-to-list 'face-font-rescale-alist '("Cantarell" . 1.2))
(set-fontset-font "fontset-default" 'han (font-spec :size 16 :name "Noto Serif CJK JP") nil 'prepend)
(set-fontset-font "fontset-default" 'kana (font-spec :size 16 :name "Noto Serif CJK JP") nil 'prepend)
(set-fontset-font "fontset-default" 'cjk-misc (font-spec :size 16 :name "Noto Serif CJK JP") nil 'prepend)

(setq-default line-spacing 0.15)
(setq-default indent-tabs-mode nil
              tab-stop-list ()
              tab-width 2
              widget-image-enable nil)

;; line cursor and no blink
(set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(column-number-mode -1)
(line-number-mode -1)
(size-indication-mode -1)

(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (let* ((current-left-margin (or (car (window-margins)) 0))
         (current-right-margin (or (cdr (window-margins)) 0))
         (available-width (- (window-width)
                             (+ (- (length (format-mode-line left)) current-left-margin)
                                (- (length (format-mode-line right)) current-right-margin)))))
    (append left
            (list (format (format "%%%ds" available-width) ""))
            right)))

(with-eval-after-load 'custom-ops
  (if (featurep 'all-the-icons)
      (setq-default mode-line-format
                    '((:eval (mode-line-render
                              '(" %I "
                                mode-line-position
                                mode-line-misc-info
                                (vc-mode vc-mode)
                                (:eval (if (bound-and-true-p vc-mode) "  "))
                                (:eval (custom-modeline-pyvenv-check))
                                (:eval (if (bound-and-true-p pyvenv-virtual-env-name) "  "))
                                (:eval (custom-modeline-flycheck-status))
                                mode-line-process)
                              '((:eval (propertize "%b" 'face `(:slant italic)))
                                (:eval (if (and buffer-file-name (buffer-modified-p))
                                           (propertize "*" 'face `(:inherit face-faded))))
                                (:eval (if (buffer-narrowed-p)
                                           (propertize "-" 'face `(:inherit face-faded))))
                                " "
                                (:eval (custom-modeline-mode-icon))
                                ;; (:eval mode-name)
                                "   ")))))
    (setq-default mode-line-format
                  '((:eval (mode-line-render
                            '(" %I "
                              mode-line-position
                              mode-line-misc-info
                              (vc-mode vc-mode))
                            '((:eval (propertize "%b" 'face `(:slant italic)))
                              (:eval (if (and buffer-file-name (buffer-modified-p))
                                         (propertize "*" 'face `(:inherit face-faded))))
                              (:eval (if (buffer-narrowed-p)
                                         (propertize "-" 'face `(:inherit face-faded))))
                              (:eval (propertize " (%m)  " 'face `(:inherit face-faded))))))))))

;; (defun custom-modeline-mode-icon ()
;;   (format "%s" (all-the-icons-icon-for-mode major-mode :height 0.8 :v-adjust 0.01)))

(defun custom-modeline-flycheck-status ()
  (when (and (featurep 'flycheck) flycheck-mode)
    (let* ((text (pcase flycheck-last-status-change
                   (`finished (if flycheck-current-errors
                                  (let ((count (let-alist (flycheck-count-errors flycheck-current-errors)
                                                 (+ (or .warning 0) (or .error 0)))))
                                    (format "✖ Err: %s" count))
                                "✔"))
                   (`running     "⟲")
                   (`no-checker  "⚠ No Checker")
                   (`not-checked "")
                   (`errored     "⚠ Error")
                   (`interrupted "⛔ Interrupted")
                   (`suspicious  ""))))
      (propertize text
                  'help-echo "Show Flycheck Errors"
                  'mouse-face '(:weight 'bold)
                  'local-map (make-mode-line-mouse-map
                              'mouse-1 (lambda () (interactive) (flycheck-list-errors)))))))

(defun custom-modeline-pyvenv-check ()
  (when (and (featurep 'pyvenv) pyvenv-virtual-env-name)
    (format "[%s venv: %s]"
            (all-the-icons-icon-for-mode 'python-mode :height 0.9 :v-adjust 0.01)
            pyvenv-virtual-env-name)))

;; use only the header line
;;(setq-default header-line-format mode-line-format)
;;(setq-default mode-line-format nil)

;; Vertical window divider
(setq window-divider-default-right-width 3
      window-divider-default-places 'right-only)
(window-divider-mode 1)
(winner-mode 1)

;; read only buffers in view mode
(setq view-read-only t
      help-window-select t)

;; window split function
;; https://www.emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-window-split ()
  "Toggle the window split"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-x |") 'toggle-window-split)

(provide 'interface)
