;; Org mode config  -*- lexical-binding: t; -*-

(require 'org)
(require 'org-tempo)
(require 'org-agenda)
(require 'org-habit)
(require 'general)
(require 'tex-mode)
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
                           (setq-local electric-pair-inhibit-predicate
                                       (lambda (c)
                                         (if (char-equal c ?\<)
                                             t
                                           (electric-pair-default-inhibit c))))
                           ;; (electric-indent-local-mode -1)
                           (setq-local electric-pair-pairs '((?\$ . ?\$))
                                       electric-pair-text-pairs '())
                           (electric-pair-local-mode 1)
                           (face-remap-add-relative 'font-lock-comment-face
                                                    :family "Cantarell"
                                                    :height 1.1
                                                    :weight 'normal
                                                    :slant 'normal)))

;; (defun my/org-number-at-point ()
;;   "Add numbering at point."
;;   (interactive)
;;   (when (org-at-item-p)
;;     (org-)))

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

  (set-face 'org-archived 'face-faded)
  ;;(set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  ;;(set-face 'org-checkbox-statistics-todo                 'face-strong)
  (set-face 'org-clock-overlay 'face-faded)
  (set-face 'org-code '(face-faded fixed-pitch))
  (set-face 'org-column 'face-faded)
  (set-face 'org-column-title 'face-faded)
  (set-face 'org-date '(face-faded fixed-pitch))
  (set-face 'org-date-selected 'face-faded)
  (set-face 'org-default 'face-faded)
  (set-face 'org-dispatcher-highlight 'face-subtle)
  (set-face 'org-document-info '(face-faded fixed-pitch))
  (set-face 'org-document-info-keyword 'face-faded)
  (set-face 'org-document-info-keyword 'fixed-pitch)
  (set-face 'org-document-title 'face-strong :slant 'italic :height 170)
  (set-face 'org-drawer '(face-faded fixed-pitch) :weight 'bold)
  (set-face 'org-ellipsis 'face-faded)
  (set-face 'org-footnote 'face-faded :height 0.95)
  (set-face 'org-formula 'face-faded)
  (set-face 'org-headline-done 'face-faded)
  (set-face 'org-latex-and-related '(face-salient fixed-pitch)
            :background (face-background 'default))
  (set-face 'org-link 'face-salient)
  (set-face 'org-list-dt 'face-light :slant 'italic)
  (set-face 'org-macro 'face-salient-yellow)
  (set-face 'org-meta-line '(face-faded fixed-pitch) :weight 'normal)
  (set-face 'org-mode-line-clock 'face-faded)
  (set-face 'org-mode-line-clock-overrun 'face-faded)
  (set-face 'org-property-value 'unspecified)
  (set-face-attribute 'org-property-value nil :inherit '(face-faded fixed-pitch))
  (set-face 'org-quote 'face-faded :slant 'italic)
  (set-face 'org-scheduled 'face-salient-yellow :weight 'bold)
  (set-face 'org-scheduled-previously 'face-salient-green)
  (set-face 'org-scheduled-today 'face-salient-yellow)
  (set-face 'org-sexp-date 'face-faded)
  (set-face 'org-special-keyword '(face-salient fixed-pitch))
  (set-face 'org-table 'default)
  (set-face 'org-tag-group 'face-faded)
  (set-face 'org-target 'face-faded)
  (set-face 'org-time-grid 'face-faded)
  (set-face 'org-todo '(face-identifier fixed-pitch)
            :weight 'bold
            :height 0.9
            :box `(:color ,(face-foreground 'face-identifier) :line-width ,(cons 8 (- 3)))
            :inverse-video t)
  (set-face 'org-done '(org-todo face-block)
            :background (face-background 'face-block)
            :box `(:color ,(face-background 'face-block) :line-width ,(cons 8 (- 3)))
            :foreground (face-foreground 'face-salient-yellow)
            :inverse-video nil)
  (set-face 'org-upcoming-deadline 'face-faded)
  (set-face 'org-verbatim 'face-faded)
  (set-face 'org-verse 'face-faded)
  (set-face 'org-warning 'face-popout)
  (set-face 'org-level-1 'face-strong)
  (set-face 'org-level-2 'face-strong)
  (set-face 'org-level-3 'face-strong)
  (set-face 'org-level-4 'face-strong)
  (set-face 'org-level-5 'face-strong)
  (set-face 'org-level-6 'face-strong)
  (set-face 'org-level-7 'face-strong)
  (set-face 'org-level-8 'face-strong)

  (set-face 'org-block '(face-block fixed-pitch))
  ;; (set-face-attribute 'tex-math nil :inherit 'face-salient)
  (set-face 'org-block-begin-line '(face-faded face-block fixed-pitch))
  (set-face 'org-block-end-line '(face-faded face-block fixed-pitch))
  ;; (set-face-attribute 'org-table            nil :inherit 'fixed-pitch)

  (set-face 'org-checkbox '(face-salient fixed-pitch) :weight 'bold)
  (set-face 'org-checkbox-statistics-todo '(face-faded fixed-pitch) :weight 'bold)
  (set-face 'org-checkbox-statistics-done '(face-faded fixed-pitch))
  (set-face 'org-priority 'fixed-pitch)
  (set-face 'org-hide 'fixed-pitch :foreground (face-background 'default))

  (set-face-attribute 'org-level-1 nil :weight 'bold :height 130)
  (set-face-attribute 'org-level-2 nil :weight 'bold :height 125)
  (set-face-attribute 'org-level-3 nil :weight 'bold :height 120)
  (set-face-attribute 'org-level-4 nil :weight 'bold :height 120)
  (set-face-attribute 'org-level-5 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-6 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-7 nil :weight 'bold :height 113)
  (set-face-attribute 'org-level-8 nil :weight 'bold :height 113)
  (set-face 'org-tag '(face-faded fixed-pitch) :weight 'bold))

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
  (set-face 'org-agenda-calendar-event 'default)
  (set-face 'org-agenda-calendar-sexp 'face-faded)
  (set-face 'org-agenda-clocking 'face-faded)
  (set-face 'org-agenda-column-dateline 'face-faded)
  (set-face 'org-agenda-current-time 'face-faded :weight 'bold)
  (set-face 'org-agenda-date 'face-light
            :weight 'bold)
  ;; :box `(:color ,(face-background 'default) :line-width 2))
  ;; :family "Cantarell"
  ;; :height 120)
  (set-face 'org-agenda-date-today 'face-identifier :weight 'bold)
  (set-face 'org-agenda-date-weekend 'face-faded :weight 'bold)
  (set-face 'org-agenda-diary 'face-faded)
  (set-face 'org-agenda-dimmed-todo-face 'face-faded)
  (set-face 'org-agenda-done 'face-faded)
  (set-face 'org-agenda-filter-category 'face-faded)
  (set-face 'org-agenda-filter-effort 'face-faded)
  (set-face 'org-agenda-filter-regexp 'face-faded)
  (set-face 'org-agenda-filter-tags 'face-faded)
  (set-face 'org-agenda-restriction-lock 'face-faded)
  (set-face 'org-agenda-structure 'face-faded)

  (require 'cal-iso)
  (setq org-agenda-use-time-grid t
        org-agenda-timegrid-use-ampm t
        org-agenda-todo-keyword-format "%-s"
        org-agenda-confirm-kill t
        org-agenda-restore-windows-after-quit t
        org-agenda-prefix-format '((agenda . " %i %?-12t %s")
                                   (todo . " %i %-12:c")
                                   (tags . " %i %-12:c")
                                   (search . " %i %-12:c"))
        ;; org-agenda-remove-tags 'prefix
        org-agenda-remove-tags nil
        org-agenda-sorting-strategy '((agenda habit-down time-up priority-down category-keep)
                                      (todo priority-down ts-up category-keep)
                                      (tags priority-down category-keep)
                                      (search category-keep))
        org-agenda-format-date (lambda (date)
                                 (format "%s, %s %s"
                                         (calendar-day-name date 'abbrev)
                                         (calendar-month-name (car date) 'abbrev)
                                         (cadr date)))
        org-agenda-include-diary t
        org-agenda-time-grid '((daily weekly today require-timed remove-match)
                               (800 1000 1200 1400 1600 1800 2000)
                               " ┄┄┄┄┄┄┄" "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-block-separator 9552))

;; org babel load languages on demand
;; https://emacs.stackexchange.com/questions/20577/org-babel-load-all-languages-on-demand
(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))q
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))

;; graphicsmagick for tikz previews to work
(add-to-list 'org-preview-latex-process-alist '(graphicsmagick :programs ("latex" "gm")
                                                               :description "pdf > png"
                                                               :message "you need to install the programs: latex and graphicsmagick"
                                                               :use-xcolor t
                                                               :image-input-type "pdf"
                                                               :image-output-type "png"
                                                               :image-size-adjust (1.0 . 1.0)
                                                               :latex-compiler ("pdflatex -interaction nonstopmode -output-directory %o %f")
                                                               :image-converter ("gm convert -density %D -trim -antialias -quality 100 -transparent white %f %O")))
(setq org-preview-latex-default-process 'graphicsmagick)

(require 'tex)
(set-face 'font-latex-warning-face 'face-popout)
(add-to-list 'TeX-view-program-list '("zathura"
                                      ("zathura %o"
                                       (mode-io-correlate
                                        " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\""))
                                      "zathura"))
(setcdr (assq 'output-pdf TeX-view-program-selection) '("zathura"))
(setq TeX-engine 'xetex)

(provide 'init-org)
