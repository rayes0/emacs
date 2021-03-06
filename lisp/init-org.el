;; Org mode config  -*- lexical-binding: t; -*-

(require 'org)
(require 'org-tempo)
(require 'org-agenda)
(require 'org-habit)
(require 'general)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-format-latex-options '(:foreground
                                 default
                                 :background "Transparent"
                                 :scale 0.8
                                 :html-foreground "Black"
                                 :html-background "Transparent"
                                 :html-scale 1.0
                                 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

(add-hook 'org-mode-hook (lambda ()
                           (visual-line-mode t)
                           (variable-pitch-mode t)
                           (flyspell-mode t)
                           ;; (electric-indent-local-mode -1)
                           (face-remap-add-relative 'font-lock-comment-face
                                                    :family "Cantarell"
                                                    :weight 'light
                                                    :slant 'normal)))

(with-eval-after-load 'org
  (setq org-src-fontify-natively t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-startup-truncated nil
        org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-pretty-entities t
        org-startup-indented t
        org-adapt-indentation t
        org-startup-shrink-all-tables t
        org-ellipsis " ⬎"
        org-startup-with-inline-images t
        org-image-actual-width nil
        org-special-ctrl-a/e t
        org-special-ctrl-k t
        org-ctrl-k-protect-subtree t
        org-confirm-babel-evaluate nil        
        org-highlight-latex-and-related '(latex)
        org-link-file-path-type 'relative
        org-use-speed-commands t)

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
                      :background (face-background 'face-critical))

  (defun org-toggle-emphasis ()
    "Toggle hiding/showing of org emphasize markers."
    (interactive)
    (if org-hide-emphasis-markers
        (set-variable 'org-hide-emphasis-markers nil)
      (set-variable 'org-hide-emphasis-markers t))
    (org-mode-restart))
  (define-key org-mode-map (kbd "C-c e") 'org-toggle-emphasis)

  (defun my/fix-inline-images ()
    (when org-inline-image-overlays
      (org-redisplay-inline-images)))
  (add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

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
  (set-face 'org-done 'org-todo)
  (set-face-attribute 'org-done nil
                      :foreground (face-foreground 'face-faded)
                      :underline nil
                      :inherit 'org-todo)
  (set-face 'org-drawer                                   'face-faded)
  (set-face-attribute 'org-drawer nil
                      :weight 'bold
                      :inherit '(face-faded fixed-pitch))
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote 'face-faded)
  (set-face-attribute 'org-footnote nil
                      :height 0.95)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face-attribute 'org-latex-and-related nil
                      :background (face-background 'default)
                      :inherit '(face-salient fixed-pitch))
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt 'face-light)
  (set-face-attribute 'org-list-dt nil
                      :slant 'italic)
  (set-face 'org-macro                                    'face-salient-yellow)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  ;;(set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value 'unspecified)
  (set-face-attribute 'org-property-value nil
                      :inherit '(face-faded fixed-pitch))
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously 'face-salient-green)
  (set-face 'org-scheduled-today 'face-salient-yellow)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face-attribute 'org-special-keyword nil
                      :inherit '(face-salient fixed-pitch))
  (set-face 'org-table                                       'default)
  (set-face 'org-tag-group                                'face-faded)
  (set-face 'org-target                                   'face-faded)
  (set-face 'org-time-grid                                'face-faded)
  (set-face 'org-todo                                    'face-popout)
  (set-face-attribute 'org-todo nil
                      :weight 'bold
                      :underline t
                      :height 1.0
                      :inherit '(face-popout fixed-pitch))
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
  ;; (set-face-attribute 'tex-math nil :inherit 'face-salient)
  (set-face-attribute 'org-block-begin-line nil :inherit '(face-faded face-block fixed-pitch))
  (set-face-attribute 'org-block-end-line   nil :inherit '(face-faded face-block fixed-pitch))
  (set-face-attribute 'org-quote            nil :slant 'italic)
  ;; (set-face-attribute 'org-table            nil :inherit 'fixed-pitch)

  (set-face-attribute 'org-checkbox nil :inherit '(face-salient fixed-pitch)
                      :weight 'bold)
  (set-face-attribute 'org-checkbox-statistics-todo nil :inherit '(face-faded fixed-pitch)
                      :weight 'bold)
  (set-face-attribute 'org-checkbox-statistics-done nil :inherit '(face-faded fixed-pitch))
  (set-face-attribute 'org-priority nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-hide nil     :inherit 'fixed-pitch)

  (set-face-attribute 'org-code                   nil :inherit 'fixed-pitch)
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

(require 'ox)
(setq org-export-async-init-file (expand-file-name "./async-init.el" user-emacs-directory)
      org-export-in-background t)

;; latex export
(with-eval-after-load 'ox-latex
  (setq org-latex-compiler "xelatex"
        org-latex-pdf-process '("%latex -interaction nonstopmode -output-directory %o %f"
                                "%latex -interaction nonstopmode -output-directory %o %f"))
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
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("lab-report"
                 "\\documentclass[12pt]{article}
\\usepackage{chemfig}
\\usepackage[margin=1in]{geometry}
\\usepackage[doublespacing]{setspace}
\\usepackage{newtxtext}
\\usepackage[document]{ragged2e}
\\setlength{\\RaggedRightParindent}{1.5em}"
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
(global-set-key "\C-ca" 'org-agenda)
(with-eval-after-load 'org-agenda
  (set-face 'org-agenda-calendar-event                    'default)
  (set-face 'org-agenda-calendar-sexp                     'face-faded)
  (set-face 'org-agenda-clocking                          'face-faded)
  (set-face 'org-agenda-column-dateline                   'face-faded)
  (set-face 'org-agenda-current-time                      'face-faded)
  (set-face 'org-agenda-date                            'face-salient)
  (set-face-attribute 'org-agenda-date nil :underline t)
  (set-face 'org-agenda-date-today                      'face-salient)
  (set-face-attribute 'org-agenda-date-today nil
                      :weight 'bold
                      :underline t)
  (set-face 'org-agenda-date-weekend                      'face-faded)
  (set-face-attribute 'org-agenda-date-weekend nil
                      :weight 'bold
                      :underline t)
  (set-face 'org-agenda-diary                             'face-faded)
  (set-face 'org-agenda-dimmed-todo-face                  'face-faded)
  (set-face 'org-agenda-done                              'face-faded)
  (set-face 'org-agenda-filter-category                   'face-faded)
  (set-face 'org-agenda-filter-effort                     'face-faded)
  (set-face 'org-agenda-filter-regexp                     'face-faded)
  (set-face 'org-agenda-filter-tags                       'face-faded)
  (set-face 'org-agenda-restriction-lock                  'face-faded)
  (set-face 'org-agenda-structure                         'face-faded)
  
  (setq org-agenda-use-time-grid t
        org-agenda-timegrid-use-ampm t
        org-agenda-current-time-string "now ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        org-agenda-todo-keyword-format "%-s"
        org-agenda-confirm-kill t
        org-agenda-restore-windows-after-quit t
        org-agenda-prefix-format '((agenda . " %i %?-12t %s")
                                   (todo . " %i %-12:c")
                                   (tags . " %i %-12:c")
                                   (search . " %i %-12:c"))
        org-agenda-sorting-strategy '((agenda habit-down time-up priority-down category-keep)
                                      (todo priority-down ts-up category-keep)
                                      (tags priority-down category-keep)
                                      (search category-keep)))
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
