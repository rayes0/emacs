;; General Theme Settings  -*- lexical-binding: t; -*-

(require 'colors)

(set-face 'mode-line 'default
          :background "#e8ddd8"
          :box `(:line-width 6 :color "#e8ddd8")
          :inherit '(fixed-pitch face-block))
(set-face 'mode-line-inactive 'face-faded
          :box `(:line-width 6 :color ,(face-background 'face-block))
          :background (face-background 'face-block)
          :weight 'light
          :inherit '(fixed-pitch face-block))
(set-face 'header-line 'face-faded
          :overline (face-foreground 'face-faded)
          :weight 'light
          :background (face-background 'face-block)
          :box `(:line-width 6 :color ,(face-background 'face-block))
          :inherit 'fixed-pitch)
(set-face-attribute 'window-divider nil
                    :foreground (face-background 'face-block))
(set-face-attribute 'window-divider-first-pixel nil
                    :foreground (face-background 'mode-line))
(set-face-attribute 'window-divider-last-pixel nil
                    :foreground (face-background 'face-block))

(with-eval-after-load 'cus-edit
  (let ((box-padding 2))
    (set-face-attribute 'custom-button nil
                        :foreground (face-foreground 'face-identifier)
                        :background (face-background 'face-block)
                        :box `(:line-width ,box-padding
                                           :color ,(face-background 'face-block)
                                           :style nil))
    (set-face-attribute 'custom-button-mouse nil
                        :foreground (face-foreground 'default)
                        :background (face-background 'secondary-selection)
                        :inherit 'custom-button
                        :box `(:line-width ,box-padding
                                           :color ,(face-background 'secondary-selection)
                                           :style nil))
    (set-face-attribute 'custom-button-pressed nil
                        :foreground (face-background 'default)
                        :background (face-foreground 'face-salient)
                        :inherit 'face-salient
                        :box `(:line-width ,box-padding
                                           :color ,(face-foreground 'face-salient)
                                           :style nil)
                        :inverse-video nil)
    (set-face-attribute 'widget-inactive nil
                        :foreground (face-foreground 'face-identifier)
                        :weight 'light
                        :box `(:line-width ,box-padding
                                           :color ,(face-background 'default)
                                           :style nil))))

;; (set-face 'bold                                          'face-strong)
;; (set-face 'italic                                        'face-italic)
;; (set-face 'bold-italic                                   'face-strong)
(set-face 'highlight 'face-subtle)
(set-face 'fixed-pitch 'default)
(set-face-attribute 'fixed-pitch nil :family "Cascaida Code")
(set-face 'fixed-pitch-serif 'default)
;;(set-face 'variable-pitch 'default)
(set-face 'cursor 'default)

(set-face 'region 'face-subtle-purple)
(set-face-attribute 'secondary-selection nil    :background "#fbf1be")

(with-eval-after-load 'table
  (set-face-attribute 'table-cell nil
                      :foreground (face-foreground 'default)
                      :background "#dad3d0"))

(set-face-attribute 'match nil :background "#fbf1be")

(set-face 'shadow 'face-faded)
(set-face 'success 'face-salient)
(set-face 'warning 'face-popout)
(set-face 'error 'face-critical)

(with-eval-after-load 'linum
  (set-face-attribute 'linum nil
                      :inherit '(face-faded fixed-pitch))
  ;;:inherit '(face-block fixed-pitch))
  (defun linum-format-func (line)
    (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
      (propertize (format (format "%%%dd " w) line) 'face 'linum)))
  (setq linum-format #'linum-format-func))

(set-face 'buffer-menu-buffer 'face-strong)
(set-face 'minibuffer-prompt 'face-faded)
(set-face-attribute 'minibuffer-prompt nil
                    :weight 'bold)
(set-face 'link 'face-salient)
(set-face 'link-visited 'face-salient :foreground (face-foreground 'face-identifier))
(set-face 'fringe 'face-faded)
(set-face 'isearch 'secondary-selection)
(set-face 'isearch-fail 'face-faded)
(set-face 'lazy-highlight 'face-subtle-purple)
(set-face 'trailing-whitespace 'face-subtle)
(set-face 'show-paren-mismatch 'face-popout)
(set-face 'show-paren-match 'face-strong :background "#dad3d0")
(set-face 'escape-glyph 'face-salient)
(set-face 'tooltip 'face-block :family "Cantarell" :height 0.95)

(set-face 'font-lock-comment-face 'face-italic-faded)
(set-face 'font-lock-comment-delimiter-face 'face-faded)
(set-face 'font-lock-doc-face 'face-light)
(set-face 'font-lock-doc-markup-face 'face-salient-yellow)
(set-face 'font-lock-string-face 'face-light)
(set-face 'font-lock-constant-face 'face-identifier)
(set-face 'font-lock-warning-face 'face-popout)
(set-face 'font-lock-function-name-face 'face-identifier)
(set-face 'font-lock-variable-name-face 'face-strong)
(set-face 'font-lock-builtin-face 'face-salient-green)
(set-face 'font-lock-type-face 'face-salient)
(set-face 'font-lock-keyword-face 'face-italic)
(set-face 'font-lock-negation-char-face 'face-salient-cyan)
(set-face 'font-lock-preprocessor-face 'face-salient)

(with-eval-after-load 'info
  (set-face 'info-menu-header 'face-strong)
  (set-face 'info-header-node 'face-normal)
  (set-face 'Info-quoted 'face-faded :family "Cascadia Code")
  (set-face 'info-title-1 'face-strong :underline t :height 1.15)
  (set-face 'info-title-2 'face-strong :underline t)
  (set-face 'info-title-3 'face-strong :italic t)
  (set-face 'info-title-4 'face-strong :italic t)
  (set-face 'info-menu-star 'face-strong :foreground "#ce9c85")
  (set-face 'info-header-xref 'face-salient-green :height 0.8 :italic t)
  (set-face 'info-header-node 'face-strong :italic t))

(set-face 'help-key-binding 'face-identifier)
(set-face 'completions-common-part 'face-italic-faded)

(with-eval-after-load 'bookmark
  ;; (set-face 'bookmark-menu-heading                       'face-strong)
  (set-face 'bookmark-menu-bookmark                    'face-salient))

(with-eval-after-load 'message
  (set-face 'message-cited-text 'face-faded)
  (set-face 'message-header-cc 'variable-pitch-text)
  (set-face 'message-header-name 'face-salient-yellow :weight 'normal)
  (set-face 'message-header-newsgroups 'variable-pitch-text)
  (set-face 'message-header-other 'variable-pitch-text)
  (set-face 'message-header-subject 'variable-pitch-text :weight 'bold :underline t)
  (set-face 'message-header-to 'fixed-pitch)
  (set-face-attribute 'message-header-to nil :weight 'bold)
  (set-face 'message-header-xheader 'fixed-pitch)
  (set-face 'message-mml 'face-popout)
  (set-face 'message-separator '(face-faded fixed-pitch)))

(with-eval-after-load 'outline
  (set-face 'outline-1 'face-strong)
  (set-face 'outline-2 'face-strong)
  (set-face 'outline-3 'face-strong)
  (set-face 'outline-4 'face-strong)
  (set-face 'outline-5 'face-strong)
  (set-face 'outline-6 'face-strong)
  (set-face 'outline-7 'face-strong)
  (set-face 'outline-8 'face-strong))

(with-eval-after-load 'cus-edit
  (set-face 'widget-field 'face-block)
  (set-face 'widget-button 'face-strong)
  (set-face 'widget-single-line-field 'face-subtle)
  (set-face 'custom-group-subtitle 'face-strong)
  (set-face 'custom-group-tag 'face-strong)
  (set-face 'custom-group-tag-1 'face-strong)
  (set-face 'custom-comment 'face-faded)
  (set-face 'custom-comment-tag 'face-faded)
  (set-face 'custom-changed 'face-salient)
  (set-face 'custom-modified 'face-salient)
  (set-face 'custom-face-tag 'face-strong)
  (set-face 'custom-variable-tag 'default)
  (set-face 'custom-invalid 'face-popout)
  (set-face 'custom-visibility 'face-salient)
  (set-face 'custom-state 'face-salient)
  (set-face 'custom-link 'face-salient))

(with-eval-after-load 'package
  (set-face 'package-description 'default)
  (set-face 'package-help-section-name 'default)
  (set-face 'package-name 'face-salient)
  (set-face 'package-status-avail-obso 'face-faded)
  (set-face 'package-status-available 'default)
  (set-face 'package-status-built-in 'face-salient)
  (set-face 'package-status-dependency 'face-salient)
  (set-face 'package-status-disabled 'face-faded)
  (set-face 'package-status-external 'default)
  (set-face 'package-status-held 'default)
  (set-face 'package-status-incompat 'face-faded)
  (set-face 'package-status-installed 'face-salient)
  (set-face 'package-status-new 'default)
  (set-face 'package-status-unsigned 'default)

  (defun package-make-button (text &rest properties)
    "Insert button labeled TEXT with button PROPERTIES at point.
PROPERTIES are passed to `insert-text-button', for which this
function is a convenience wrapper used by `describe-package-1'."
    (let ((button-text (if (display-graphic-p)
                           text (concat "[" text "]")))
          (button-face (if (display-graphic-p)
                           '(:box `(:line-width 1
                                                :color "#999999":style nil)
                                  :foreground "#999999"
                                  :background "#F0F0F0")
                         'link)))
      (apply #'insert-text-button button-text
             'face button-face 'follow-link t properties))))

(with-eval-after-load 'flyspell
  (set-face-attribute 'flyspell-incorrect nil
                      :underline '(:color "#ce9c85" :style wave))
  (set-face-attribute 'flyspell-duplicate nil
                      :underline '(:color "#9c7b9c" :style wave)))

(with-eval-after-load 'diff-mode
  (set-face 'diff-header '(face-block face-strong))
  (set-face 'diff-file-header 'face-strong)
  (set-face 'diff-context 'face-light)
  (set-face 'diff-removed 'face-faded)
  (set-face 'diff-changed 'face-popout)
  (set-face 'diff-added 'face-salient)
  (set-face 'diff-refine-added '(face-salient face-strong))
  (set-face 'diff-refine-changed 'face-popout)
  (set-face 'diff-refine-removed 'face-faded :strike-through t)
  ;; (set-face 'diff-function ')
  )

(with-eval-after-load 'tabulated-list
  (set-face 'tabulated-list-fake-header 'header-line
            :weight 'bold
            :background (face-background 'default)
            :box nil))

(provide 'general)
