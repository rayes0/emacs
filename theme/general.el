;; General Theme Settings

(defgroup blossom nil
	"Faces for the blossom theme"
	:prefix "face-")

;; Do not show prefix when displaying the blossom group
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
  "Background face for suggesting physical areas"
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


;; Mode line (this might be slow because of the "☰" that requires substitution)
;; This line below makes things a bit faster
;; (set-fontset-font "fontset-default"  '(#x2600 . #x26ff) "Victor Mono Italic 12")

(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))
(setq-default mode-line-format
     '((:eval
       (mode-line-render
       (format-mode-line (list
         (propertize "☰" 'face `(:inherit mode-line-buffer-id)
                         'help-echo "Mode(s) menu"
                         'mouse-face 'mode-line-highlight
                         'local-map   mode-line-major-mode-keymap)
         " %b "
         (if (and buffer-file-name (buffer-modified-p))
             (propertize "(modified)" 'face `(:inherit face-faded)))))
       (format-mode-line
        (propertize "%4l:%2c  " 'face `(:inherit face-faded)))))))


;; Buttons
(defun set-button-faces ()
  (set-face-attribute 'custom-button nil
                      :foreground (face-foreground 'face-faded)
                      :background (face-background 'face-subtle)
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-faded)
                             :style nil))
  (set-face-attribute 'custom-button-mouse nil
                      :foreground (face-foreground 'default)
                      ;; :background (face-foreground 'face-faded)
                      :inherit 'custom-button
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-subtle)
                             :style nil))
  (set-face-attribute 'custom-button-pressed nil
                      :foreground (face-background 'default)
                      :background (face-foreground 'face-salient)
                      :inherit 'face-salient
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-salient)
                             :style nil)
                      :inverse-video nil))

(defun set-face (face style)
  "Reset a FACE and make it inherit STYLE."
  (set-face-attribute face nil
   :foreground 'unspecified :background 'unspecified
   :family     'unspecified :slant      'unspecified
   :weight     'unspecified :height     'unspecified
   :underline  'unspecified :overline   'unspecified
   :box        'unspecified :inherit    style))

;; Structural
;; (set-face 'bold                                          'face-strong)
;; (set-face 'italic                                        'face-italic)
;; (set-face 'bold-italic                                   'face-strong)
(set-face 'region                                        'face-subtle)
(set-face 'highlight                                     'face-subtle)
(set-face 'fixed-pitch                                       'default)
(set-face 'fixed-pitch-serif                                 'default)
(set-face 'variable-pitch                                    'default)
(set-face 'cursor                                            'default)

;; Semantic
(set-face 'shadow                                         'face-faded)
(set-face 'success                                      'face-salient)
(set-face 'warning                                       'face-popout)
(set-face 'error                                       'face-critical)

;; General
(set-face 'buffer-menu-buffer                            'face-strong)
(set-face 'minibuffer-prompt                             'face-strong)
(set-face 'link                                         'face-salient)
(set-face 'fringe                                         'face-faded)
(set-face 'isearch                                       'face-strong)
(set-face 'isearch-fail                                   'face-faded)
(set-face 'lazy-highlight                                'face-subtle)
(set-face 'trailing-whitespace                           'face-subtle)
(set-face 'show-paren-mismatch                           'face-normal)
(set-face-attribute 'tooltip nil                         :height 0.85)

;; Programmation mode
(set-face 'font-lock-comment-face                  'face-italic-faded)
(set-face 'font-lock-doc-face                             'face-light)
(set-face 'font-lock-string-face                          'face-light)
(set-face 'font-lock-constant-face                   'face-identifier)
(set-face 'font-lock-warning-face                        'face-popout)
(set-face 'font-lock-function-name-face              'face-identifier)
(set-face 'font-lock-variable-name-face                  'face-strong)
(set-face 'font-lock-builtin-face                       'face-salient)
(set-face 'font-lock-type-face                             'face-type)
(set-face 'font-lock-keyword-face                       'face-keyword)

;; Documentation
(with-eval-after-load 'info
  (set-face 'info-menu-header                            'face-strong)
  (set-face 'info-header-node                            'face-normal)
  (set-face 'Info-quoted                                  'face-faded)
  (set-face 'info-title-1                                'face-strong)
  (set-face 'info-title-2                                'face-strong)
  (set-face 'info-title-3                                'face-strong)
  (set-face 'info-title-4                               'face-strong))

;; Completions
(set-face 'help-key-binding                             'face-salient)
(set-face 'completions-common-part                 'face-italic-faded)

;; Bookmarks
(with-eval-after-load 'bookmark
  (set-face 'bookmark-menu-heading                       'face-strong)
  (set-face 'bookmark-menu-bookmark                    'face-salient))

;; Message
(with-eval-after-load 'message
  (set-face 'message-cited-text                           'face-faded)
  (set-face 'message-header-cc                               'default)
  (set-face 'message-header-name                         'face-strong)
  (set-face 'message-header-newsgroups                       'default)
  (set-face 'message-header-other                            'default)
  (set-face 'message-header-subject                     'face-salient)
  (set-face 'message-header-to                          'face-salient)
  (set-face 'message-header-xheader                          'default)
  (set-face 'message-mml                                 'face-popout)
  (set-face 'message-separator                           'face-faded))

;; Outline
(with-eval-after-load 'outline
  (set-face 'outline-1                                   'face-strong)
  (set-face 'outline-2                                   'face-strong)
  (set-face 'outline-3                                   'face-strong)
  (set-face 'outline-4                                   'face-strong)
  (set-face 'outline-5                                   'face-strong)
  (set-face 'outline-6                                   'face-strong)
  (set-face 'outline-7                                   'face-strong)
  (set-face 'outline-8                                  'face-strong))

;; Interface
(with-eval-after-load 'cus-edit
  (set-face 'widget-field                                'face-subtle)
  (set-face 'widget-button                               'face-strong)
  (set-face 'widget-single-line-field                    'face-subtle)
  (set-face 'custom-group-subtitle                       'face-strong)
  (set-face 'custom-group-tag                            'face-strong)
  (set-face 'custom-group-tag-1                          'face-strong)
  (set-face 'custom-comment                               'face-faded)
  (set-face 'custom-comment-tag                           'face-faded)
  (set-face 'custom-changed                             'face-salient)
  (set-face 'custom-modified                            'face-salient)
  (set-face 'custom-face-tag                             'face-strong)
  (set-face 'custom-variable-tag                             'default)
  (set-face 'custom-invalid                              'face-popout)
  (set-face 'custom-visibility                          'face-salient)
  (set-face 'custom-state                               'face-salient)
  (set-face 'custom-link                               'face-salient))

;; Package
(with-eval-after-load 'package
  (set-face 'package-description                             'default)
  (set-face 'package-help-section-name                       'default)
  (set-face 'package-name                               'face-salient)
  (set-face 'package-status-avail-obso                    'face-faded)
  (set-face 'package-status-available                        'default)
  (set-face 'package-status-built-in                    'face-salient)
  (set-face 'package-status-dependency                  'face-salient)
  (set-face 'package-status-disabled                      'face-faded)
  (set-face 'package-status-external                         'default)
  (set-face 'package-status-held                             'default)
  (set-face 'package-status-incompat                      'face-faded)
  (set-face 'package-status-installed                   'face-salient)
  (set-face 'package-status-new                              'default)
  (set-face 'package-status-unsigned                         'default)

  ;; Button face is hardcoded, we have to redefine the relevant
  ;; function
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
             'face button-face 'follow-link t properties)))
  )

;; Flyspell
(with-eval-after-load 'flyspell
  (set-face 'flyspell-duplicate                         'face-popout)
  (set-face 'flyspell-incorrect                         'face-popout))

;; Ido 
(with-eval-after-load 'ido
  (set-face 'ido-first-match                            'face-salient)
  (set-face 'ido-only-match                               'face-faded)
  (set-face 'ido-subdir                                 'face-strong))

;; Diff
(with-eval-after-load 'diff-mode
  (set-face 'diff-header                                  'face-faded)
  (set-face 'diff-file-header                            'face-strong)
  (set-face 'diff-context                                    'default)
  (set-face 'diff-removed                                 'face-faded)
  (set-face 'diff-changed                                'face-popout)
  (set-face 'diff-added                                 'face-salient)
  (set-face 'diff-refine-added            '(face-salient face-strong))
  (set-face 'diff-refine-changed                         'face-popout)
  (set-face 'diff-refine-removed                          'face-faded)
  (set-face-attribute     'diff-refine-removed nil :strike-through t))

(provide 'general)
