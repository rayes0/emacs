;; All interface settings  -*- lexical-binding: t; -*-
;; Some interface settings are also set in early-init.el, mainly to reduce startup time (percieved and actual)

(require 'general)

(setq use-short-answers t
      confirm-kill-emacs
      (lambda (&optional _)
        (yes-or-no-p
         ;; prompt stolen from doom
         (concat (propertize "I-it's not like I'll miss you or anything, b-baka! "
                             'face 'face-italic-faded)
                 (propertize "Really quit emacs?"
                             'face 'face-salient))))
      custom-raised-buttons nil
      echo-keystrokes 0.15)

(tooltip-mode t)
(setq tooltip-delay 0
      tooltip-resize-echo-area t
      tooltip-frame-parameters `((name . "tooltip")
                                 (background-color . ,(face-background 'face-block))
                                 (internal-border-width . 6)
                                 (border-width . 2)
                                 (border-color . ,(face-foreground 'face-salient-yellow))
                                 (no-special-glyphs . t)))

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
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t
      ido-file-extensions-order '(".org")
      ido-use-virtual-buffers t
      ido-use-filename-at-point nil
      ido-use-url-at-point nil
      ido-auto-merge-work-directories-length -1
      ;; ido-auto-merge-delay-time 0.2
      ido-decorations `("\n" "\n" "\n" " | ..."
                        ,(propertize "(" 'face 'face-faded) ,(propertize ")" 'face 'face-faded)
                        ,(propertize " (No matches)" 'face 'face-faded)
                        " [Matched]" " [Not readable]" " [Too big]" " [Confirm]" "\n" "")
      ido-default-file-method 'maybe-frame
      ido-default-buffer-method 'maybe-frame
      ido-enter-matching-directory 'first)

(add-hook 'ido-setup-hook (lambda ()
                            (define-key ido-completion-map (kbd "C-n") #'ido-next-match)
                            (define-key ido-completion-map (kbd "C-p") #'ido-prev-match)))

(set-face 'ido-first-match 'highlight)
(set-face 'ido-only-match 'face-salient)
(set-face 'ido-subdir 'default :weight 'bold)

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

(setq-default line-spacing 0.15
              indent-tabs-mode nil
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

(defun mode-line-render (left-text right-text)
  (let* ((siding 10)
         (available (- (- (window-pixel-width)
                          (+ (string-pixel-width (format-mode-line left-text))
                             (string-pixel-width (format-mode-line right-text))))
                       (* 2 siding)))
         (mid-pad (propertize "-" 'display `(space :width (,available))))
         (side-pad (propertize "-" 'display `(space :width (,siding)))))
    (list side-pad left-text mid-pad right-text side-pad)))

(defvar my/ml-window nil)
(add-function :before pre-redisplay-function
              (lambda (_wins) (setq my/ml-window (selected-window))))

(with-eval-after-load 'custom-ops
  (if (featurep 'all-the-icons)
      (setq-default mode-line-format
                    '((:eval (let ((space-xs (propertize "-" 'display '(space :width (8))))
                                   (space-s (propertize "-" 'display '(space :width (12))))
                                   (space (propertize "-" 'display '(space :width (24)))))
                               (mode-line-render
                                `("%I"
                                  ,space-s
                                  mode-line-position
                                  ;; (:eval (nyan-create))
                                  mode-line-misc-info
                                  (vc-mode (:eval (propertize vc-mode 'face '(:weight bold :inherit face-faded))))
                                  ,space-s
                                  (:eval (custom-modeline-pyvenv-check))
                                  ;; (:eval (if (bound-and-true-p pyvenv-virtual-env-name) "  "))
                                  mode-line-process)
                                `((:eval (custom-modeline-flycheck-status))
                                  ,space
                                  (:eval (propertize (format "[ %s ]" (format-mode-line mode-name)) 'face '(:inherit face-faded :height 0.9)))
                                  ,space-s
                                  (:eval (propertize "%b" 'face '(:slant italic)))
                                  (:eval (if (and buffer-file-name (buffer-modified-p))
                                             (propertize "*" 'face '(:inherit face-faded))))
                                  (:eval (if (buffer-narrowed-p)
                                             (propertize "-" 'face '(:inherit face-faded))))
                                  ,space-xs
                                  (:eval (if (eq my/ml-window (selected-window)) "●" "○"))
                                  "  "))))))
    (setq-default mode-line-format
                  '((:eval (mode-line-render
                            '("%I "
                              mode-line-position
                              mode-line-misc-info
                              (vc-mode vc-mode))
                            '((:eval (propertize "%b" 'face '(:slant italic)))
                              (:eval (if (and buffer-file-name (buffer-modified-p))
                                         (propertize "*" 'face '(:inherit face-faded))))
                              (:eval (if (buffer-narrowed-p)
                                         (propertize "-" 'face '(:inherit face-faded))))
                              (:eval (propertize (format " (%s) " (format-mode-line mode-name)) 'face `(:inherit face-faded)))
                              (:eval (if (eq my/ml-window (selected-window)) "●" "○"))
                              "  ")))))))

;; (defun custom-modeline-mode-icon ()
;;   (format "%s" (all-the-icons-icon-for-mode major-mode :height 0.8 :v-adjust 0.01)))

(defun custom-modeline-flycheck-status ()
  (when (and (featurep 'flycheck) flycheck-mode)
    (let* ((text (pcase flycheck-last-status-change
                   ('finished (if flycheck-current-errors
                                  (let ((count (let-alist (flycheck-count-errors flycheck-current-errors)
                                                 (+ (or .warning 0) (or .error 0)))))
                                    (format "✖%s%s" (propertize "-" 'display '(space :width (4))) count))
                                "✔"))
                   ('running     "⟲")
                   ('no-checker  "⚠ No Checker")
                   ('not-checked "")
                   ('errored     "⚠ err")
                   ('interrupted "⛔ stop")
                   ('suspicious  "⚠ sus"))))
      (propertize text
                  'help-echo "Flycheck errors"
                  'mouse-face '(:weight bold)
                  'local-map (make-mode-line-mouse-map
                              'mouse-1 (lambda () (interactive) (flycheck-list-errors)))))))

(defun custom-modeline-pyvenv-check ()
  (when (and (featurep 'pyvenv) pyvenv-virtual-env-name)
    (format "(%s venv: %s)"
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
