;; Org mode config

(require 'org)
(require 'org-agenda)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(add-hook 'org-mode-hook (lambda ()
                           (visual-line-mode t)
                           (variable-pitch-mode t)
                           (flyspell-mode t)
                           (electric-indent-local-mode -1)))

(with-eval-after-load 'org-agenda
  (require 'org-habit)
  (setq org-habit-graph-column 57
    org-habit-show-all-today nil
    org-habit-completed-glyph 8226
    org-habit-today-glyph 9702
    org-habit-preceding-days 7
    org-habit-show-done-always-green t)
  (set-face-attribute 'org-habit-clear-future-face nil
    :background (face-background 'face-block))
  (set-face-attribute 'org-habit-clear-face nil
    :background (face-background 'face-block))
  (set-face-attribute 'org-habit-ready-face nil
    :background (face-background 'face-block))
  (set-face-attribute 'org-habit-overdue-future-face nil
    :background (face-background 'face-subtle))
  (set-face-attribute 'org-habit-alert-face nil
    :background (face-background 'face-critical))
  (set-face-attribute 'org-habit-alert-future-face nil
    :background (face-background 'face-critical))
  (set-face-attribute 'org-habit-overdue-face nil
    :background (face-background 'face-critical)))

(with-eval-after-load 'org
  (require 'org-tempo)
  (setq org-src-fontify-natively t
    org-fontify-done-headline t
    org-fontify-quote-and-verse-blocks t
    org-src-tab-acts-natively t
    org-startup-truncated nil
    org-hide-emphasis-markers t
    org-hide-leading-stars t
    org-pretty-entities t

    org-startup-indented t
    org-adapt-indentation t
    org-startup-shrink-all-tables t

    org-ellipsis " ⬎"
    org-display-inline-images t
    org-redisplay-inline-images t
    org-startup-with-inline-images t

    org-special-ctrl-a/e t
    org-special-ctrl-k t

    org-confirm-babel-evaluate nil

    org-highlight-latex-and-related '(native latex script entities))

  (defun org-toggle-emphasis ()
    "Toggle hiding/showing of org emphasize markers."
    (interactive)
    (if org-hide-emphasis-markers
      (set-variable 'org-hide-emphasis-markers nil)
      (set-variable 'org-hide-emphasis-markers t)))
  (define-key org-mode-map (kbd "C-c e") 'org-toggle-emphasis)

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
  ;;(set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  ;;(set-face 'org-checkbox-statistics-todo                 'face-strong)
  (set-face 'org-clock-overlay                            'face-faded)
  (set-face 'org-code                                     'face-faded)
  (set-face 'org-column                                   'face-faded)
  (set-face 'org-column-title                             'face-faded)
  (set-face 'org-date                                     'face-faded)
  (set-face-attribute 'org-date nil
    :inherit '(face-faded fixed-pitch))
  (set-face 'org-date-selected                            'face-faded)
  (set-face 'org-default                                  'face-faded)
  (set-face 'org-dispatcher-highlight                    'face-subtle)
  (set-face 'org-document-info                            'face-faded)
  (set-face 'org-document-info-keyword                    'face-faded)
  (set-face 'org-document-title                          'face-strong)
  (set-face 'org-done                                        'default)
  (set-face 'org-drawer                                   'face-faded)
  (set-face-attribute 'org-drawer nil
    :weight 'bold
    :inherit '(face-faded fixed-pitch))
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote                                 'face-faded)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face-attribute 'org-latex-and-related nil
    :background (face-background 'default)
    :inherit 'face-faded)
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt                                  'face-faded)
  (set-face 'org-macro                                    'face-faded)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  ;;(set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value                           'face-faded)
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously                     'face-faded)
  (set-face 'org-scheduled-today                          'face-faded)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face-attribute 'org-special-keyword nil
    :inherit '(face-salient fixed-pitch))
  (set-face 'org-table                                       'default)
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

  (set-face-attribute 'org-block            nil :inherit '(face-block fixed-pitch))
  (set-face-attribute 'org-block-begin-line nil :inherit '(face-faded face-block fixed-pitch))
  (set-face-attribute 'org-block-end-line   nil :inherit '(face-faded face-block fixed-pitch))
  (set-face-attribute 'org-quote            nil :slant 'italic)
  (set-face-attribute 'org-table            nil :inherit 'fixed-pitch)

  (set-face-attribute 'org-checkbox nil :inherit '(face-salient fixed-pitch)
    :weight 'bold)
  (set-face-attribute 'org-checkbox-statistics-todo nil :inherit '(face-faded fixed-pitch)
    :weight 'bold)
  (set-face-attribute 'org-checkbox-statistics-done nil :inherit '(face-faded fixed-pitch))
  (set-face-attribute 'org-priority nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-hide nil     :inherit 'fixed-pitch)

  (set-face-attribute 'org-code                   nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table            nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-info-keyword  nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-info          nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-document-title         nil :slant 'italic :height 170)
  (set-face-attribute 'org-meta-line              nil :inherit '(face-faded fixed-pitch)
    :weight 'normal)

  (set-face-attribute 'org-level-1 nil :weight 'bold :height 130)
  (set-face-attribute 'org-level-2 nil :weight 'bold :height 125)
  (set-face-attribute 'org-level-3 nil :weight 'bold :height 120)
  (set-face-attribute 'org-level-4 nil :weight 'bold :height 120)
  (set-face-attribute 'org-level-5 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-6 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-7 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-8 nil :weight 'bold :height 113)
  (set-face-attribute 'org-tag nil :weight 'bold :inherit '(face-faded fixed-pitch)))

(setq org-export-async-init-file (expand-file-name "./async-init.el" user-emacs-directory)
  org-export-in-background t)

;; latex export
(with-eval-after-load 'ox-latex
  (setq org-latex-compiler "xelatex")
  (add-to-list 'org-latex-classes
    '("tufte-book"
       "\\documentclass{tufte-book}
\\usepackage{ifluatex, ifxetex}
%Next block avoids bug, from  http://tex.stackexchange.com/a/200725/1913 
\\ifx\\ifxetex\\ifluatex\\else % if lua- or xelatex http://tex.stackexchange.com/a/140164/1913
  \\newcommand{\\textls}[2][5]{%
    \\begingroup\\addfontfeatures{LetterSpace=#1}#2\\endgroup
  }
  \\renewcommand{\\allcapsspacing}[1]{\\textls[15]{#1}}
  \\renewcommand{\\smallcapsspacing}[1]{\\textls[10]{#1}}
  \\renewcommand{\\allcaps}[1]{\\textls[15]{\\MakeTextUppercase{#1}}}
  \\renewcommand{\\smallcaps}[1]{\\smallcapsspacing{\\scshape\\MakeTextLowercase{#1}}}
  \\renewcommand{\\textsc}[1]{\\smallcapsspacing{\\textsmallcaps{#1}}}
\\fi "
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
    '("tufte-handout"
       "\\documentclass{tufte-handout}
\\usepackage{ifluatex, ifxetex}
%Next block avoids bug, from  http://tex.stackexchange.com/a/200725/1913 
\\ifx\\ifxetex\\ifluatex\\else % if lua- or xelatex http://tex.stackexchange.com/a/140164/1913
  \\newcommand{\\textls}[2][5]{%
    \\begingroup\\addfontfeatures{LetterSpace=#1}#2\\endgroup
  }
  \\renewcommand{\\allcapsspacing}[1]{\\textls[15]{#1}}
  \\renewcommand{\\smallcapsspacing}[1]{\\textls[10]{#1}}
  \\renewcommand{\\allcaps}[1]{\\textls[15]{\\MakeTextUppercase{#1}}}
  \\renewcommand{\\smallcaps}[1]{\\smallcapsspacing{\\scshape\\MakeTextLowercase{#1}}}
  \\renewcommand{\\textsc}[1]{\\smallcapsspacing{\\textsmallcaps{#1}}}
\\fi "
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; fix conflict with visual line mode
(add-hook 'org-mode-hook
  (lambda ()
    (define-key org-mode-map "\C-a" 'org-beginning-of-line)
    (define-key org-mode-map "\C-e" 'org-end-of-line)
    (define-key org-mode-map "\C-k" 'org-kill-line)))

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
  (set-face 'org-agenda-restriction-lock                  'face-faded)
  (set-face 'org-agenda-structure                         'face-faded)

  (global-set-key "\C-ca" 'org-agenda)
  (setq org-agenda-use-time-grid t
    org-agenda-timegrid-use-ampm t
    org-agenda-current-time-string "now ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  (setcar (nthcdr 3 org-agenda-time-grid) "───────────────")

  (setq org-agenda-block-separator 9552))

;; org babel load languages on demand
;; https://emacs.stackexchange.com/questions/20577/org-babel-load-all-languages-on-demand
(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))

(provide 'init-org)
