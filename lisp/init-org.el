;; Org mode config

(require 'org)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) ; make org work with files ending in .org

(add-hook 'org-mode-hook (lambda ()
						   (visual-line-mode t)
						   (variable-pitch-mode t)
						   (flyspell-mode t)))

(with-eval-after-load 'org
  (setq
   org-src-fontify-natively t
   org-fontify-done-headline t
   ;;org-fontify-whole-heading-line t
   org-fontify-quote-and-verse-blocks t
   org-src-tab-acts-natively t
   org-startup-indented t
   org-startup-truncated nil
   org-hide-emphasis-markers t
   org-hide-leading-stars t
   org-pretty-entities t
   org-odd-levels-only t

   org-ellipsis " ⬎"

   org-display-inline-images t
   org-redisplay-inline-images t
   org-startup-with-inline-images t

   org-format-latex-options (plist-put org-format-latex-options :scale 1.7)
   )

   ;; Org babel
   (org-babel-do-load-languages
    'org-babel-load-languages
    '((gnuplot . t)))

   (defun my/fix-inline-images ()
	 (when org-inline-image-overlays
       (org-redisplay-inline-images)))
   (add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

  (font-lock-add-keywords 'org-mode
  		'(("^ *\\([-]\\) "
  		   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; The set-face function is defined in theme/general.el
  (require 'general)
  (set-face 'org-archived                                 'face-faded)
  (set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  (set-face 'org-checkbox-statistics-todo                 'face-faded)
  (set-face 'org-clock-overlay                            'face-faded)
  (set-face 'org-code                                     'face-faded)
  (set-face 'org-column                                   'face-faded)
  (set-face 'org-column-title                             'face-faded)
  (set-face 'org-date                                     'face-faded)
  (set-face 'org-date-selected                            'face-faded)
  (set-face 'org-default                                  'face-faded)
  (set-face 'org-document-info                            'face-faded)
  (set-face 'org-document-info-keyword                    'face-faded)
  (set-face 'org-document-title                          'face-strong)
  (set-face 'org-done                                        'default)
  (set-face 'org-drawer                                   'face-faded)
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote                                 'face-faded)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
;;  (set-face 'org-hide                                     'face-faded)
;;  (set-face 'org-indent                                   'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt                                  'face-faded)
  (set-face 'org-macro                                    'face-faded)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  (set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value                           'face-faded)
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously                     'face-faded)
  (set-face 'org-scheduled-today                          'face-faded)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face 'org-table                                    'default)
  (set-face 'org-tag                                      'face-faded)
  (set-face 'org-tag-group                                'face-faded)
  (set-face 'org-target                                   'face-faded)
  (set-face 'org-time-grid                                'face-faded)
  (set-face 'org-todo                                    'face-popout)
  (set-face 'org-upcoming-deadline                        'face-faded)
  (set-face 'org-verbatim                                 'face-faded)
  (set-face 'org-verse                                    'face-faded)
  (set-face 'org-warning                                 'face-popout)
  (set-face 'org-level-1                                 'face-strong)
  (set-face 'org-level-2                                 'face-strong)
  (set-face 'org-level-3                                 'face-strong)
  (set-face 'org-level-4                                 'face-strong)
  (set-face 'org-level-5                                 'face-strong)
  (set-face 'org-level-6                                 'face-strong)
  (set-face 'org-level-7                                 'face-strong)
  (set-face 'org-level-8                                 'face-strong)

  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block-begin-line nil :inherit '(face-faded fixed-pitch))
  (set-face-attribute 'org-block-end-line         nil :inherit '(face-faded fixed-pitch))
  (set-face-attribute 'org-quote nil :slant 'italic)

  (set-face-attribute 'org-code                   nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-info-keyword  nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-info          nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-title         nil :slant 'italic :height 170)
  (set-face-attribute 'org-meta-line              nil :inherit '(face-faded fixed-pitch)
					                                  :weight 'normal)

  (set-face-attribute 'org-level-1 nil :weight 'bold :height 180)
  (set-face-attribute 'org-level-2 nil :weight 'bold :height 170)
  (set-face-attribute 'org-level-3 nil :weight 'bold :height 165)
  (set-face-attribute 'org-level-4 nil :weight 'bold :height 160)
  (set-face-attribute 'org-level-5 nil :weight 'bold :height 155)
  (set-face-attribute 'org-level-6 nil :weight 'bold :height 155)
  (set-face-attribute 'org-level-7 nil :weight 'bold :height 155)
  (set-face-attribute 'org-level-8 nil :weight 'bold :height 155))


;; org-agenda
(with-eval-after-load 'org-agenda
  (set-face 'org-agenda-calendar-event                    'default)
  (set-face 'org-agenda-calendar-sexp                     'face-faded)
  (set-face 'org-agenda-clocking                          'face-faded)
  (set-face 'org-agenda-column-dateline                   'face-faded)
  (set-face 'org-agenda-current-time                      'face-faded)
  (set-face 'org-agenda-date                            'face-salient)
  (set-face 'org-agenda-date-today        '(face-salient face-strong))
  (set-face 'org-agenda-date-weekend                      'face-faded)
  (set-face 'org-agenda-diary                             'face-faded)
  (set-face 'org-agenda-dimmed-todo-face                  'face-faded)
  (set-face 'org-agenda-done                              'face-faded)
  (set-face 'org-agenda-filter-category                   'face-faded)
  (set-face 'org-agenda-filter-effort                     'face-faded)
  (set-face 'org-agenda-filter-regexp                     'face-faded)
  (set-face 'org-agenda-filter-tags                       'face-faded)
  ;; fixes issue #18 (set-face 'org-agenda-property-face                     'face-faded)
  (set-face 'org-agenda-restriction-lock                  'face-faded)
  (set-face 'org-agenda-structure                        'face-faded))

(provide 'init-org)
