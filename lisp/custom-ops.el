;; -*- lexical-binding: t; eval: (ligature-mode -1) -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(org-agenda-files
   '("/home/rayes/Notes/org/Exercise.org" "/home/rayes/Notes/org/Insights.org" "/home/rayes/Notes/org/Meta.org" "/home/rayes/Notes/org/Programming.org" "/home/rayes/Notes/org/anki.org" "/home/rayes/Notes/org/media-list.org" "/home/rayes/Notes/org/programs.org" "/home/rayes/Notes/org/tea.org" "/home/rayes/Notes/org/todo.org"))
 '(package-selected-packages
   '(ement taxy-magit-section bash-completion dired-rsync org-anki nyan-mode dirvish code-review emms torrent-info bencoding nnshimbun w3m nnchan lexic md4rd hierarchy emojify uuidgen htmlize a nnhackernews json-rpc lua-mode plz slime macrostep rustic fountain-mode taxy chika promise arbtt typit mmt ox-hugo csv-mode arietta transient vterm flycheck company biblio avy auctex org-appear math-delimiters sx yaml ghub treepy closql emacsql-sqlite emacsql rust-mode beacon iscroll tsc realgud test-simple loc-changes load-relative yascroll org-mime org-contrib semi flim apel pdf-tools valign tree-mode virtualenvwrapper cmus ein polymode deferred anaphora websocket smtpmail-multi lv ht spray git-commit with-editor avy-menu writeroom-mode writegood-mode which-key unicode-math-input speed-type rainbow-delimiters quelpa pyvenv pytest powerthesaurus persistent-scratch org-fragtog org-download org-bullets nov mediawiki math-symbols ligature langtool-ignore-fonts highlight-indent-guides haskell-mode gnuplot flyspell-correct flycheck-vale flycheck-languagetool fic-mode ess eshell-vterm elpher el-easydraw eglot company-quickhelp cdlatex bibtex-completion all-the-icons-ibuffer all-the-icons-completion aggressive-indent))
 '(pdf-view-resize-factor 1.01)
 '(safe-local-variable-values
   '((dired-omit-files . "\\`[.]?#\\|\\`[.][.]?\\'\\|\\`.*\\.aria2\\'\\|.*\\.torrent\\'\\|\\.dir-locals.el\\'")
     (eval add-to-list 'fountain-export-command-profiles
           '("wrap-html" . "wrap html %b --out %B.html"))
     (org-babel-lilypond-gen-svg . t)
     (eval advice-add 'org-hugo--get-sanitized-title :override #'blog/org-hugo-title-with-markup)
     (eval defun blog/org-hugo-title-with-markup
           (info)
           (when
               (plist-get info :with-title)
             (org-export-data-with-backend
              (plist-get info :title)
              'md info)))
     (eval setq-local org-link-make-description-function 'blog/org-hugo-make-link-desc)
     (eval defun blog/org-hugo-make-link-desc
           (l g)
           (if g g
             (when
                 (string-match-p "^/img/.*$" l)
               (if
                   (yes-or-no-p "Auto link? ")
                   (concat "file:" l)
                 (read-string "Description: " initial-input)
                 initial-input))))
     (eval advice-add 'org-insert-link :around
           (lambda
             (orig &rest r)
             (interactive "P")
             (if
                 (not blog/org-hugo-function-advices)
                 (call-interactively orig)
               (let
                   ((default-directory "/home/rayes/sites/personal-site/static/img/"))
                 (call-interactively orig)))))
     (blog/org-hugo-function-advices . t)
     (eval define-minor-mode blog/org-hugo-function-advices "Enable custom blog advices")
     (eval setq-local org-link-file-path-type 'blog/hugo-return-directory-from-static)
     (eval defun blog/hugo-return-directory-from-static
           (path)
           (cond
            ((cl-search "~/sites/personal-site/static/" path)
             (replace-regexp-in-string
              (regexp-quote "~/sites/personal-site/static")
              "" path))
            ((cl-search "/home/rayes/sites/personal-site/static/" path)
             (replace-regexp-in-string
              (regexp-quote "/home/rayes/sites/personal-site/static")
              "" path))
            (t
             (progn
               (message "file outside static dir (prob wrong path)")
               path))))
     (eval setq-local org-export-filter-link-functions
           '(blog/org-filter-out-fignum))
     (eval defun blog/org-filter-out-fignum
           (data _ _)
           (replace-regexp-in-string "<span class=.*figure-number.*Figure .*: </span>" "" data))
     (org-latex-create-formula-image-program quote dvisvgm)
     (org-format-latex-options quote
                               (:foreground default :background "Transparent" :scale 0.8 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                                            ("begin" "$1" "$" "$$" "\\(" "\\[")))
     (dired-omit-files . "\\`[.]?#\\|\\`[.][.]?\\'\\|\\`.*\\.aria2\\'\\|\\.torrent\\'\\|\\.dir-locals.el\\'")
     (dired-omit-files . "\\`[.]?#\\|\\`[.][.]?\\'\\|\\`.*\\.aria2\\'\\|\\.torrent\\'\\|\\\\`.dir-locals.el\\'")
     (dired-omit-files . "\\`[.]?#\\|\\`[.][.]?\\'\\|\\`.*\\.aria2\\'\\|\\.torrent\\'")
     (dired-omit-files concat dired-omit-files "\\|\\.torrent\\'")
     (eval setq-local org-export-filter-link-functions
           '(my/org-filter-out-fignum))
     (eval defun my/org-filter-out-fignum
           (data _ _)
           (replace-regexp-in-string "<span class=.*figure-number.*Figure .*: </span>" "" data))
     (pyvenv-activate . "./venv")
     (eval ligature-mode -1)
     (eval flycheck-mode nil)
     (flycheck-mode)
     (org-time-stamp-custom-formats "%m/%d/%y" . "%m/%d/%y")))
 '(send-mail-function 'smtpmail-send-it)
 '(warning-suppress-log-types '((websocket))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; org capture
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/Notes/org/todo.org" "Misc")
         "* TODO %?\n%T")
        ("u" "Uni Task" entry (file+headline "~/Notes/org/todo.org" "Uni")
         "* UNI %?\n%T")
        ("b" "Blog" entry (file+headline "~/Notes/org/todo.org" "Site")
         "* TODO [#A] %?")))


(when (file-exists-p (expand-file-name "secrets.el" user-emacs-directory))
  (load-file (expand-file-name "secrets.el" user-emacs-directory)))

;; org agenda files
(setq org-directory "~/Notes/org"
      org-agenda-files (list org-directory))

(add-hook 'org-mode-hook #'valign-mode)

(setq org-format-latex-options
      '(:foreground default
        :background "Transparent"
        :scale 0.8
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 1.0
        :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

(defun setup-chicken()
  "set some things for chicken scheme"
  (interactive)
  (require 'scheme)
  (setq scheme-program-name "csi -:c"))

(add-hook 'eshell-mode-hook 'eshell-vterm-mode)
(with-eval-after-load 'em-term.el
  (add-to-list 'eshell-visual-commands "mtpsync.sh"))

(with-eval-after-load 'em-cmpl
  (require 'bash-completion)
  (defun bash-completion-eshell-capf ()
    (let ((bash-completion-nospace t))
      (while (pcomplete-here
              (nth 2 (bash-completion-dynamic-complete-nocomint
                      (save-excursion (eshell-bol) (point))
                      (point)))))))
  (setq eshell-default-completion-function #'bash-completion-eshell-capf))

;; link opener
(defun browse-url-choose (url &rest _args)
  (interactive)
  (let ((browser (condition-case _
                     (completing-read "browse with: "
                                      '("tor-browser" "chromium" "mpv" "copy" "feh"))
                   nil)))
    (if (string-equal browser "copy")
        (progn
          (kill-new url nil)
          (message "added to kill ring"))
      (call-process "/home/rayes/bin/link-open" nil 0 nil browser url)
      (message "opening..."))))
(setq browse-url-browser-function #'browse-url-choose)

;; (require 'cmus)
;; (cmus-setup-default)

;; mediawiki
(require 'mediawiki)
(setq mediawiki-site-alist
      ;; '(("Wikipedia" "https://en.wikipedia.org/w/" "Rayes0" "" nil "Main Page")
      '(("Wikipedia" "https://en.wikipedia.org/w/" "Rayes0" "" nil "User:Rayes0")
        ;; ("Mobileread" "https://wiki.mobileread.com/wiki/" "rayes" "" nil "Main Page")
        ("Fandom: Oregairu" "https://oregairu.fandom.com/" "" nil "OreGairu_Wiki")
        ("Fedora Wiki" "https://fedoraproject.org/wiki/" "rayes" nil "User:Rayes")))
(add-hook 'mediawiki-mode-hook
          (lambda ()
            (flyspell-mode 1)
            (variable-pitch-mode 1)
            (visual-line-mode 1)))

;; some commands to help me with Hugo
(defun hugo-server-start ()
  (interactive)
  (let ((default-directory "~/sites/personal-site/"))
    (make-process :name "hugo"
                  :buffer "*hugo-server*"
                  :command '("hugo" "server" "-D" "--navigateToChanged"))))
(defun hugo-server-stop ()
  (interactive)
  (kill-process "hugo"))
(defun hugo-server-publish-start ()
  (interactive)
  (let ((default-directory "~/sites/personal-site/"))
    (make-process :name "hugo"
                  :buffer "*hugo-server*"
                  :command '("hugo" "server" "--navigateToChanged"))))

;; ido-at-point
;; (autoload 'ido-at-point-mode "ido-at-point")
;; (ido-at-point-mode)

;; markdown-mode
(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; haskell
(add-hook 'haskell-mode-hook #'flycheck-install-setup)

;; rustic-mode
(with-eval-after-load 'rustic
  (setq rustic-lsp-client 'eglot)
  (add-hook 'rustic-mode-hook 'eglot-ensure))

;; eglot
(with-eval-after-load 'eglot
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc)
  (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)
  (setq eglot-sync-connect 0))

;; flycheck with vale
;; (flycheck-define-checker vale
;;   "A checker for prose using vale"
;;   :command ("vale" "--output" "line"
;;              source)
;;   :standard-input nil
;;   :error-patterns
;;   ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
;;   :modes (markdown-mode org-mode text-mode))
;; (add-to-list 'flycheck-checkers 'vale)
(require 'flycheck-vale)
(flycheck-vale-setup)

;; change default python interpreter to ipython
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")

;; bug-mode
(with-eval-after-load 'bug-mode
  (setq bug-default-instance 'bugzilla
        bug-instance-plist '(:bugzilla (:url "https://bugzilla.redhat.com/"
                                        ;; :authinfo "~/.authinfo.gpg"
                                        :type bz-rpc))))

;; highlight indent guides
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(highlight-indent-guides-auto-set-faces)
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-responsive nil
      highlight-indent-guides-delay 0)

;; aggressive indent
(aggressive-indent-global-mode 1)

;; rainbow delimiters
(dolist (mode '(lisp-mode common-lisp-mode elisp-mode))
  (add-hook mode 'rainbow-delimiters-mode))

;; which-key-mode
(which-key-mode t)

;; company
(require 'company)
(global-company-mode 1)
(setq company-global-modes '(not org-mode))
(company-quickhelp-mode 1)
(setq company-quickhelp-delay nil
      company-quickhelp-color-background "#dad3d0")
(define-key company-active-map (kbd "C-h") 'company-quickhelp-manual-begin)
(define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)
(setq company-idle-delay 0.4
      company-minimum-prefix-length 2)

(set-face 'company-tooltip 'face-block)
(set-face-attribute 'company-tooltip nil :background "#f5ece9" :inherit 'fixed-pitch)
(set-face 'company-tooltip-common 'face-italic-faded)
(set-face 'company-tooltip-selection 'secondary-selection)
(set-face-attribute 'company-tooltip-scrollbar-thumb nil :background "#dad3d0")
(set-face-attribute 'company-tooltip-scrollbar-track nil :background (face-background 'face-block))

;; yascroll
;; (global-yascroll-bar-mode 1)
;; (setq yascroll:delay-to-hide 0.7)
;; (set-face-attribute 'yascroll:thumb-fringe nil
;; :foreground (face-foreground 'face-faded)
;; :background (face-foreground 'face-faded))
;; (set-face-attribute 'yascroll:thumb-text-area nil :background (face-background 'face-block))

;; sublimity
;; (require 'sublimity)
;; (require 'sublimity-attractive)
;; (require 'sublimity-scroll)
;; (setq sublimity-scroll-drift-length 2
;;   sublimity-scroll-weight 10)
;; (setq sublimity-scroll-vertical-frame-delay 0.001)
;; (add-hook 'eww-mode-hook 'sublimity-mode)

;; spray
;; (require 'spray)
;; (setq spray-height 140
;; spray-margin-top 5
;; spray-margin-left 80)

;; writegood-mode
(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)
(with-eval-after-load 'writegood-mode
  (set-face-attribute 'writegood-weasels-face nil
                      :underline '(:color "#dad3d0"))
  (set-face-attribute 'writegood-passive-voice-face nil
                      :underline '(:color "#75998e"))
  (set-face-attribute 'writegood-duplicates-face nil
                      :underline '(:color "#8f8678" :style wave)))

;; org-download
(autoload 'org "org-download")
(setq org-download-screenshot-method "maim -s %s")
(setq-default org-download-image-dir "./orgimg/")

;; org-fragtog and cdlatex
(add-hook 'org-mode-hook 'org-fragtog-mode)
(add-hook 'org-mode-hook 'org-appear-mode)

(add-hook 'org-mode-hook 'org-cdlatex-mode)
(setq cdlatex-simplify-sub-super-scripts nil
      cdlatex-auto-help-delay 1
      cdlatex-math-symbol-alist '((i ("\\in" "\\imath" "\\int"))))

;; (advice-add 'cdlatex-math-symbol :around (lambda (f)
;;                                            (interactive "P")))

;; (with-eval-after-load 'org
;; (define-key org-mode-map "$" 'cdlatex-dollar)
;; (define-key org-mode-map (kbd "H-$") '(org-self-insert-command "$")))
;; (with-eval-after-load 'cdlatex
;;   (define-key cdlatex-mode-map "$" nil))
;; (with-eval-after-load 'tex
;;   (define-key TeX-mode-map "$" 'math-delimiters-insert))

;; org-latex
;; (setq org-latex-create-formula-image-program 'dvisvgm)

;; org-bullets
(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))

;; org-alert
;;(require 'org-alert)
;; (setq alert-default-style 'libnotify
;;   org-alert-interval 3600)
;; (org-alert-enable)

;; bibtex and org-cite setup
(setq bibtex-field-delimiters 'double-quotes
      bibtex-entry-format
      `(opts-or-alts page-dashes required-fields
                     numerical-fields whitespace last-comma delimiters
                     unify-case sort-fields)
      bibtex-align-at-equal-sign t)

(require 'bibtex-completion)
(setq bibtex-completion-bibliography
      (if (file-accessible-directory-p "~/media/academic/")
          (directory-files "~/media/academic/" t ".*.bib")
        '("~/media/academic/references.bib"))
      bibtex-completion-library-path "~/media/academic/pdfs/"
      bibtex-completion-notes-path "~/media/academic/notes/"
      org-cite-global-bibliography bibtex-completion-bibliography)

(defun open-pdf-from-bibtex ()
  (interactive)
  (bibtex-completion-open-pdf (list (bibtex-completion-get-key-bibtex))))
(defun open-notes-from-bibtex ()
  (interactive)
  (bibtex-completion-edit-notes (list (bibtex-completion-get-key-bibtex))))

(define-key bibtex-mode-map (kbd "C-c C-v p") 'open-pdf-from-bibtex)
(define-key bibtex-mode-map (kbd "C-c C-v n") 'open-notes-from-bibtex)

;;(require 'citeproc-org)
;;(citeproc-org-setup)

;; anki-editor
(with-eval-after-load 'anki-editor
  (defun filter-out-p (str _ _)
    (replace-regexp-in-string "\n<p>\\|</p>\n\\|<p>\\|</p>" "" str))
  (setq anki-editor--ox-anki-html-backend
        (org-export-create-backend
         :parent 'html
         :filters
         '((:filter-paragraph . filter-out-p)))))

;; activity watch mode
;;(global-activity-watch-mode)

;; vterm
(setq vterm-buffer-name-string "%s | vterm"
      vterm-timer-delay nil)

(defvar top-global-buffer)
(defun systop ()
  "Run top in vterm"
  (interactive)
  (setq top-global-buffer (generate-new-buffer "*top - vterm*"))
  (when (buffer-live-p top-global-buffer)
    (let ((vterm-shell (executable-find "top"))
          (vterm-kill-buffer-on-exit t))
      (with-current-buffer top-global-buffer
        (vterm-mode))
      (switch-to-buffer top-global-buffer))))

;; ido
;;(require 'ido-hacks)
;;(require 'ido-completing-read+)
;;(ido-ubiquitous-mode 1)
;;(ido-grid-mode 1)
;;(setq ido-grid-mode-start-collapsed t)

(with-eval-after-load 'speed-type
  (set-face 'speed-type-mistake 'face-critical)
  (set-face 'speed-type-correct 'face-faded))

;; ytdious
(with-eval-after-load 'ytdious
  (setq ytdious-invidious-api-url "https://invidious.snopyta.org")
  ;; (setq ytdious-invidious-api-url "https://invidious.kavin.rocks")
  (set-face 'ytdious-video-published-face 'face-salient-green)
  (set-face 'ytdious-video-view-face 'face-salient-yellow)
  (set-face 'ytdious-channel-name-face 'face-identifier)
  (set-face 'ytdious-video-length-face 'face-salient-cyan))

;; magit
(with-eval-after-load 'magit-section
  (set-face 'magit-section-heading 'face-salient-cyan :weight 'light)
  (set-face-attribute 'magit-section-highlight nil
                      :background (face-background 'face-block)))
(with-eval-after-load 'magit
  (setq magit-process-find-password-functions '(magit-process-password-auth-source))
  (set-face 'magit-branch-local 'face-pre)
  (set-face 'magit-branch-remote 'face-identifier :weight 'normal :slant 'italic)
  (set-face-attribute 'magit-branch-current nil :box nil :underline t)
  (set-face 'magit-tag 'face-popout)

  (set-face-attribute 'magit-diffstat-added nil :foreground "#839773")
  (set-face-attribute 'magit-diffstat-removed nil :foreground "#ce9c85")

  (set-face 'magit-log-author 'face-salient-green)
  (set-face-attribute 'magit-log-author nil
                      :weight 'bold)

  (require 'forge)
  (set-face 'forge-topic-merged 'face-faded)
  (set-face 'forge-topic-closed 'face-faded :weight 'normal)
  (set-face 'forge-topic-open 'face-strong)
  (set-face 'forge-topic-unmerged 'face-salient-yellow :weight 'bold)
  (set-face 'forge-topic-label 'face-strong
            :box nil)
  (set-face 'magit-dimmed 'face-faded)

  (set-face 'magit-diff-hunk-heading 'face-strong
            :underline t
            :weight 'bold
            :extend t)
  (set-face 'magit-diff-hunk-heading-highlight 'face-block
            :extend t
            :underline t))

(with-eval-after-load 'code-review
  (set-face-attribute 'code-review-timestamp-face nil
                      :foreground 'unspecified
                      :slant 'italic
                      :inherit 'face-light))

;; (add-hook 'forge-topic-mode-hook (lambda ()
;; (face-remap-add-relative ')))

;; sx
(require 'sx)
;; (set-face 'sx-question-mode-title)

(require 'sx-question-mode)
(set-face-attribute 'sx-question-mode-content-face nil
                    :background (face-background 'default))
(set-face 'sx-custom-button 'custom-button)
(set-face-attribute 'sx-question-mode-accepted nil
                    :foreground (face-foreground  'face-salient-yellow))
(define-key sx-question-mode-map (kbd "G") 'sx-open-link)
(define-key sx-question-mode-map (kbd "C-c w") 'center-window-mode)

(add-hook 'sx-question-mode-hook #'my/sans-serif-font)

;; R markdown
(defun rmd-activate ()
  "ESS Markdown settings for rmd files"
  (interactive)
  (require 'poly-R)
  (require 'poly-markdown)     
  (poly-markdown+r-mode)
  (variable-pitch-mode 0)
  (setq-local markdown-hide-markup nil)
  (face-remap-add-relative 'markdown-header-face-1 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-2 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-3 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-4 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-5 '(:height 110 :underline t))
  (face-remap-add-relative 'markdown-header-face-6 '(:height 110 :underline t)))
(add-to-list 'auto-mode-alist '("\\.Rmd" . rmd-activate))

;; pdf-tools
(pdf-tools-install)
(setq pdf-view-resize-factor 1.05)
;; (add-hook 'pdf-view-mode-hook (lambda ()
;;                                 (setq-local auto-revert-interval 0.5)
;;                                 (auto-revert-mode 1)
;;                                 (auto-revert-set-timer)))
(define-key pdf-view-mode-map "&" #'my/pdf-tools-zathura)
(defun my/pdf-tools-zathura ()
  (interactive)
  (start-process "zathura" nil (executable-find "zathura")
                 (buffer-file-name)
                 (concat "--page=" (number-to-string (pdf-view-current-page)))))

;; all-the-icons
(require 'all-the-icons)
(setq all-the-icons-default-adjust 0.5)
(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(setq all-the-icons-ibuffer-formats
      '((mark
         (icon 2 3 :left) " "
         name-nolabel " ")
        (mark
         modified " "
         (icon 2 3 :left) " "
         (name 20 20 :left :elide) " "
         ;; (size-custom 5 -1 :right) " "
         (mode+ 16 16 :left :elide)  " "
         filename-and-process+)
        ))
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; (with-eval-after-load 'all-the-icons-dired
;; (set-face-attribute 'all-the-icons-dired-dir-face nil :foreground "#6c605a"))

(all-the-icons-completion-mode 1)

;; dirvish
(dirvish-override-dired-mode 1)
(with-eval-after-load 'dirvish
  (require 'dirvish-collapse)
  (set-face 'dirvish-hl-line 'face-block :extend t)
  ;; (set-face 'dirvish-file-size 'face-faded)
  (set-face 'dirvish-collapse-dir-face 'face-italic-faded)

  (setq dirvish-attributes '(all-the-icons collapse subtree-state)
        dirvish-reuse-session t
        dirvish-mode-line-format mode-line-format)

  (define-key dirvish-mode-map (kbd "<tab>") #'dirvish-subtree-toggle))

;; dired async
(dired-async-mode 1)

;; dired rsync
(define-key dired-mode-map (kbd "C-c C-r") 'dired-rsync)
(setq dired-rsync-options "-azr --info=progress2 --partial")

;; ibuffer custom buffers
(setq ibuffer-saved-filter-groups
      (quote (("main"
               ("MODIFIED" (and (modified . t)
                                (visiting-file . t)))
               ("term" (or (derived-mode . comint-mode)
                           (mode . vterm-mode)
                           (mode . eshell-mode)
                           (mode . term-mode)
                           (mode . shell-mode)))
               ("planning" (or (name . "^\\*Calendar\\*$")
                               (name . "^diary$")
                               (mode . org-agenda-mode)))
               ("blog" (filename . "/sites/personal-site/"))
               ("browser" (or (mode . xwidget-webkit-mode)
                              (mode . eww-mode)))
               ("notes" (and (filename . "/Notes/")
                             (or (mode . org-mode)
                                 (mode . markdown-mode))))
               ("org" (mode . org-mode))
               ("books" (filename . "/Books/"))
               ("docs" (or (mode . pdf-view-mode)
                           (mode . doc-view-mode)))
               ("img" (mode . image-mode))
               ("elisp" (or (filename . "/.emacs.d/")
                            (filename . "/.config/emacs/")
                            (mode . Custom-mode)))
               ("config" (or (filename . "/.config/")
                             (filename . "/.themes/")))
               ("code" (or (derived-mode . prog-mode)
                           (mode . ess-mode)
                           (filename . "/projects/")))
               ("dired" (or (mode . dired-mode)
                            (mode . dirvish-mode)))
               ("chat" (or (mode . ement-room-list-mode)
                           (mode . ement-room-mode)
                           (mode . erc-mode)))
               ("help" (or (name . "\*Help\*")
                           (name . "\*Apropos\*")
                           (name . "\*info\*")
                           (mode . help-mode)))
               ("internal" (name . "^\*.*$"))
               ("other" (name . "^.*$"))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "main")))

(setq diary-file "~/Notes/diary")

;; presistent scratch
(persistent-scratch-setup-default)

;; indent guide
;;(add-hook 'prog-mode 'indent-guide-mode)
;;(with-eval-after-load 'indent-guide
;;  (setq indent-guide-char "│"))
;;(indent-guide-global-mode)
;;(set-face 'indent-guide-face 'face-faded)
;;(dolist (mode '(org-mode
;;                 markdown-mode
;;                 fundamental-mode
;;                 shell-mode
;;                 vterm-mode))
;;          (add-to-list 'indent-guide-inhibit-modes mode))

;; avy
(require 'avy)
(global-set-key (kbd "M-s") 'avy-goto-char-timer)
(set-face 'avy-lead-face 'face-subtle)
(set-face-attribute 'avy-lead-face nil
                    :background (face-background 'face-subtle-purple))
(set-face 'avy-lead-face-0 'face-subtle)
(set-face 'avy-lead-face-1 'face-italic-faded)
;; (set-face 'avy-lead-face-2 'face-)
;; (set-face 'avy)
(dolist (avy-face '(avy-lead-face avy-lead-face-0
                    avy-lead-face-1 avy-lead-face-2))
  (set-face-attribute avy-face nil :height 0.85
                      :weight 'bold))
(set-face 'avy-background-face 'face-light)

(setq avy-style 'pre
      avy-background nil
      avy-flyspell-correct-function 'ispell-word
      avy-keys '(106 107 108 104 103 102 100 115 97)
      avy-timeout-seconds 0.4)
(define-key isearch-mode-map (kbd "M-s") 'avy-isearch)

;; flyspell-correct
(require 'flyspell-correct-avy-menu)
(define-key flyspell-mode-map (kbd "C-`") 'flyspell-correct-wrapper)
(define-key flyspell-mode-map (kbd "C-<escape>") 'flyspell-correct-wrapper)

;; ement
(require 'ement)
;; (require 'ement-room-list)
(global-set-key (kbd "M-g M-l") 'ement-taxy-room-list)
(add-hook 'ibuffer-mode-hook (lambda () (local-unset-key (kbd "M-g"))))
(add-hook 'ement-room-mode-hook (lambda ()
                                  (face-remap-add-relative 'shr-text
                                                           :family "Cantarell"
                                                           :inherit 'ement-room-message-text)
                                  (face-remap-add-relative 'header-line
                                                           :family "Cantarell")))
(setq ement-room-retro-messages-number 100
      ement-save-sessions t
      ement-room-send-typing nil
      ement-room-send-read-receipts nil
      ement-room-prism nil
      ;;    ement-room-send-message-filter 'ement-room-send-org-filter
      ement-room-mark-rooms-read nil
      ;; ement-room-message-format-spec "%B%r%R%t"
      ement-room-message-format-spec "%t%L%B%r"
      ;; ement-room-left-margin-width 0
      ement-room-left-margin-width 6
      ;; ement-room-right-margin-width 7
      ement-room-right-margin-width 0
      ement-room-sender-in-headers nil
      ement-room-sender-headers t
      ement-taxy-auto-update t
      ement-notify-notification-predicates '(ement-notify--event-mentions-session-user-p
                                             ement-notify--event-mentions-room-p
                                             ement-notify--room-unread-p))

(with-eval-after-load 'ement-taxy
  (set-face-attribute 'ement-room-list-name nil
                      :inherit 'face-light)
  (set-face-attribute 'ement-room-list-favourite nil
                      :inherit 'face-salient-cyan)
  (set-face-attribute 'ement-room-list-space nil
                      :inherit 'face-identifier)
  (set-face-attribute 'ement-room-list-recent nil
                      :inherit 'face-salient-yellow))

(add-hook 'ement-room-mode-hook (lambda () (setq-local mode-line-format nil)))
(set-face 'ement-room-message-text 'variable-pitch
          :family "Cantarell"
          :height 120)
(set-face-attribute 'ement-room-fully-read-marker nil
                    :inherit 'face-block)
(set-face-attribute 'ement-room-user nil
                    :family "Cantarell")
(set-face 'ement-room-mention 'face-block
          :family "Cantarell"
          :extend t)
(set-face-attribute 'ement-room-membership nil
                    :family "Cantarell"
                    :height 0.8)
(set-face-attribute 'ement-room-timestamp nil
                    :slant 'normal
                    :height 0.9
                    :family "Cantarell"
                    :weight 'normal)
(set-face 'ement-room-timestamp-header 'face-strong
          :family "Cantarell"
          :weight 'bold
          :overline t
          :height 1.1)
(set-face-attribute 'ement-room-reactions nil
                    :family "Cantarell"
                    :height 1.0)
(set-face-attribute 'ement-room-reactions-key nil
                    :height 1.1)
(set-face-attribute 'ement-room-wrap-prefix nil
                    :background (face-foreground 'face-faded))

(defun run-pantalaimon ()
  (interactive)
  (make-process :name "pantalaimon"
                :buffer "*pantalaimon*"
                :command '("pantalaimon")))

;; media
(require 'cmus)
(require 'emms-setup)
(emms-all)
(setq emms-player-list '(emms-player-mpv)
      emms-source-file-directory-tree-function #'emms-source-file-directory-tree-find
      emms-source-file-default-directory "~/Music/"
      emms-player-mpv-parameters '("--quiet" "--really-quiet" "--no-audio-display" "--force-window=no" "--vo=null")
      emms-browser-covers #'emms-browser-cache-thumbnail-async
      emms-browser-thumbnail-filter (lambda (dir)
                                      (when (file-directory-p dir)
                                        (if-let ((initial (my/emms-search-cover-directory dir)))
                                            initial
                                          (if-let* ((parent (file-name-directory (directory-file-name dir)))
                                                    (back (my/emms-search-cover-directory parent)))
                                              back
                                            (if-let ((art (directory-files dir t "[Aa]rtwork\\|[Aa]rt" t)))
                                                (cl-loop for d in art
                                                         if (file-directory-p d) return (my/emms-search-cover-directory d)))))))
      emms-seek-seconds 2
      emms-info-asynchronously nil
      emms-info-functions '(emms-info-metaflac emms-info-native)
      emms-playing-time-style 'time
      emms-playing-time-display-format (propertize "%s" 'face '(:weight bold :inherit (variable-pitch-text face-salient-yellow)))
      emms-mode-line-icon-color (face-foreground 'default)
      emms-mode-line-mode-line-function (lambda ()
                                          (propertize
                                           (format " %s  %s "
                                                   (emms-propertize "NP:" 'display
			                                                              (emms-mode-line-icon-generate
				                                                             emms-mode-line-icon-color))
                                                   (emms-track-description
				                                            (emms-playlist-current-selected-track)))
                                           'face '(:weight bold :inherit (variable-pitch-text face-salient-yellow)))))

(defun my/emms-search-cover-directory (dir)
  (if-let ((cur (directory-files dir t "\\([Ff]ront\\|[Cc]over\\|[Ff]older\\).*\\.\\(jpg\\|jpeg\\|png\\|gif\\)" t)))
      cur
    (if-let ((other (directory-files dir t ".*\\.\\(jpg\\|jpeg\\|png\\|gif\\)" t)))
        other)))

(defun my/sans-serif-font ()
  (face-remap-add-relative 'default :family "Cantarell"))

(add-hook 'emms-playlist-mode-hook #'my/sans-serif-font)
(add-hook 'emms-browser-mode-hook #'my/sans-serif-font)

(set-face 'emms-browser-album-face 'face-identifier)
(set-face-attribute 'emms-browser-album-face nil :height 1.3)
(set-face 'emms-browser-track-face 'default)
(set-face 'emms-playlist-track-face 'default)
(set-face 'emms-playlist-selected-face 'highlight)
(set-face-attribute 'emms-playlist-selected-face nil :weight 'bold)
(set-face 'emms-browser-artist-face 'face-salient-cyan)
(set-face-attribute 'emms-browser-artist-face nil :height 1.3 :weight 'bold)
(set-face 'emms-browser-year/genre-face 'face-salient-green)
(set-face-attribute 'emms-browser-year/genre-face nil :height 1.1 :weight 'bold)

(defvar emms-browser-info-album-format "%i%cS  %A")
(defvar emms-browser-info-title-format "%T.%i %t (%a)")
(defvar emms-browser-playlist-info-title-format "[ %A ] %T.%i %t (%a)")
(defvar emms-browser-playlist-info-album-format "\n%i%cM\n[%y]  %A ")

;; (require 'empv)
;; (setq empv-mpv-args '("--ytdl-format=best" "--no-terminal" "--idle" "--input-ipc-server=/tmp/empv-socket")
;;       empv-invidious-instance "https://invidious.snopyta.org/api/v2"
;;       empv-base-directory "/home/rayes/media/"
;;       empv-video-dir "/home/rayes/media/anime")
;; (global-set-key (kbd "H-p") 'empv-toggle)

(global-set-key (kbd "<XF86AudioPlay>") 'my/handle-play-pause)
(global-set-key (kbd "<XF86AudioNext>") 'my/handle-play-next)
(global-set-key (kbd "<XF86AudioPrev>") 'my/handle-play-prev)

(defun my/handle-play-pause ()
  (interactive)
  (cond ;; ((empv--running?) (empv-toggle))
        ((cmus-running-p) (cmus-play-pause))
        (t (emms-pause))))

(defun my/handle-play-next ()
  (interactive)
  (cond ;; ((empv--running?) (empv-playlist-next))
        ((cmus-running-p) (cmus-next))
        (t (emms-next))))

(defun my/handle-play-prev ()
  (interactive)
  (cond ;; ((empv--running?) (empv-playlist-prev))
        ((cmus-running-p) (cmus-previous))
        (t (emms-previous))))

;; writeroom mode
(with-eval-after-load 'writeroom-mode
  (setq writeroom-global-effects '(writeroom-set-menu-bar-lines
                                   writeroom-set-tool-bar-lines
                                   writeroom-set-vertical-scroll-bars
                                   ;; writeroom-set-bottom-divider-width
                                   writeroom-set-internal-border-width)
        writeroom-border-width 40
        writeroom-header-line nil
        writeroom-restore-window-config t
        writeroom-fringes-outside-margins nil
        writeroom-mode-line nil
        writeroom-width 85))

(define-minor-mode center-window-mode nil
  :init-value nil
  (if center-window-mode
      (progn (add-hook 'window-configuration-change-hook
                       #'move-window-center-maybe 'append 'local)
             (move-window-center-maybe))
    (writeroom-mode -1)
    (remove-hook 'window-configuration-change-hook
                 #'move-window-center-maybe t)))

(global-set-key (kbd "C-c w") 'center-window-mode)

(define-globalized-minor-mode global-center-window-mode
  center-window-mode (lambda () (center-window-mode 1)))

(defun move-window-center-maybe ()
  (interactive)
  (let ((writeroom-mode-line t)
        (writeroom-header-line t)
        (writeroom-global-effects nil))
    (if (and (<= (count-windows) 2)
             ;; (< (/ (x-display-pixel-width) 2) (window-pixel-width))
             (< 990 (window-pixel-width))
             (< 540 (window-pixel-height))
             (not (or (minibufferp)
                      (eq (current-buffer) org-agenda-buffer)
                      (eq (current-buffer) (get-buffer "*Ement Taxy*")))))
        ;; (< (/ (x-display-pixel-height) 2) (window-pixel-height)))
        (writeroom-mode 1)
      (writeroom-mode -1))))

(with-eval-after-load 'eww
  (define-key eww-mode-map (kbd "C-c h") #'eww-header-line-toggle)
  (defvar eww--previous-header eww-header-line-format)
  (defun eww-header-line-toggle ()
    (interactive)
    (if eww-header-line-format
        (progn
          (setq eww--previous-header eww-header-line-format)
          (setq eww-header-line-format nil))
      (setq eww-header-line-format eww--previous-header))
    (when (called-interactively-p 'any)
      (redraw-display))))

;; (define-globalized-minor-mode global-center-window-mode center-window-mode nil
;;                               ;; :init-value nil
;;                               (if global-center-window-mode
;;                                   (remove-hook 'window-configuration-change-hook 'center-window--enter-or-leave)
;;                                 (add-hook 'window-configuration-change-hook 'center-window--enter-or-leave)))

;; (defun center-window--enter-or-leave ()
;;   "Enter or leave according to window configuration."
;;   (unless (not (= (count-windows) 1))
;;     (center-window-mode 1)))


;; (dolist (mode '(eww-mode Info-mode )))

;; cascadia code ligatures
(require 'ligature)
(let ((mono-ligset '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                     ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                     "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                     "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                     "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                     "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                     "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                     "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                     ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                     "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                     "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                     "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                     "\\\\" "://"))
      (variable-ligset '("fl" "fi" "ffi" "ffl")))
  (ligature-set-ligatures 't '("www"))
  (dolist (mode '(eww-mode))
    (ligature-set-ligatures mode variable-ligset))
  (ligature-set-ligatures 'prog-mode mono-ligset)
  (ligature-set-ligatures 'org-mode mono-ligset) ;; for codeblocks
  (global-ligature-mode t))


;; flycheck
(require 'flycheck)
(global-flycheck-mode 1)
(setq flycheck-emacs-lisp-load-path 'inherit
      flycheck-global-modes '(not org-mode org-agenda-mode erc-mode))
(set-face-attribute 'flycheck-info nil
                    :underline nil)
(set-face-attribute 'flycheck-warning nil
                    :underline (face-foreground 'face-salient-yellow))
(set-face-attribute 'flycheck-error nil
                    :underline (face-foreground 'face-popout))
(setq flycheck-textlint-config "~/.textlintrc.json"
      flycheck-textlint-executable "~/node_modules/.bin/textlint")

(setq flycheck-languagetool-server-jar "~/.local/opt/LanguageTool-5.5/languagetool-server.jar")

(require 'langtool)
(setq langtool-language-tool-jar "~/.local/opt/LanguageTool-5.5/languagetool-commandline.jar")

(require 'langtool-ignore-fonts)
(langtool-ignore-fonts-add 'org-mode
                           '(org-meta-line org-table org-indent '(org-block font-latex-math-face)
                             org-level-1))

;; pyvenv
(pyvenv-mode -1)
(pyvenv-tracking-mode 1)

;; lua mode
(with-eval-after-load 'lua-mode
  (setq lua-indent-level 2))

;; native comp options
(setq native-comp-always-compile t)
(setq package-native-compile t)
(setq native-comp-compiler-options '("-O2" "-march=skylake" "-mtune=native"))

;; fic mode
(require 'fic-mode)
(define-globalized-minor-mode global-fic-mode fic-mode
  (lambda ()
    (when (derived-mode-p 'prog-mode)
      (fic-mode 1))))

(global-fic-mode 1)
(add-hook 'org-mode 'fic-mode)

(set-face 'fic-face 'secondary-selection)
(setq fic-highlighted-words '("FIXME" "TODO" "BUG" "HOMEWORK")
      fic-activated-faces '(font-lock-doc-face font-lock-comment-face))

;; lexic
(add-hook 'lexic-mode-hook #'variable-pitch-mode)

;; smartparens
;; (require 'smartparens-config)

;; beacon
;; (with-eval-after-load 'beacon
;;   (setq beacon-color (face-background 'face-subtle)
;;         beacon-size 60)
;;   (dolist (mode '(eshell-mode vterm-mode term-mode comint-mode eww-mode erc-mode
;;                   ement-room-mode))
;;     (add-to-list 'beacon-dont-blink-major-modes mode)))
;; (beacon-mode 1)

;; ein
(with-eval-after-load 'ein
  (set-face-attribute 'ein:basecell-input-area-face nil
                      :extend t
                      :inherit 'face-block))

;; folding
;; (add-hook 'prog-mode-hook (lambda ()
;;                             (hideshowvis-enable)
;;                             (hideshowvis-symbols)
;;                             (with-eval-after-load 'hideshowvis
;;                               (set-face 'hideshowvis-hidden-region-face 'face-salient)
;;                               (set-face-attribute 'hideshowvis-hidden-region-face nil
;;                                                   :weight 'bold
;;                                                   :height 80
;;                                                   :box nil
;;                                                   :inverse-video t))))

;; (add-hook 'org-mode-hook (lambda () (hideshowvis-minor-mode -1)))

;; (setq hs-set-up-overlay 'my/custom-fold-overlay)
;; (defun my/custom-fold-overlay (ov)
;;    (when (eq 'code (overlay-get ov 'hs))
;;      (overlay-put ov 'display
;;        (format "... / %d"
;;          (count-lines (overlay-start ov)
;;            (overlay-end ov))))))

;; eaf
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;; (require 'eaf)
;; (require 'eaf-browser)
;; (require 'eaf-image-viewer)
;; (require 'eaf-jupyter)
;; (require 'eaf-music-player)
;; (require 'eaf-org-previewer)
;; (require 'eaf-pdf-viewer)
;; (require 'eaf-system-monitor)
;; (require 'eaf-video-player)
;; (require 'eaf-rss-reader)

(with-eval-after-load 'arietta
  (set-face 'arietta-active 'face-salient-yellow))

;; hide cursor for some modes
(defvar-local hide-cursor--original nil)
(define-minor-mode hide-cursor-mode
  "Hide or show the cursor."
  :global nil
  (if hide-cursor-mode
      (progn
        (scroll-lock-mode 1)
        (setq-local hide-cursor--original cursor-type
                    cursor-type nil))
    (scroll-lock-mode -1)
    (setq-local cursor-type (or hide-cursor--original
                                t))))

;; mam
(require 'auth-source)
(require 'request)
(defun mam-get-user-info ()
  (interactive)
  (let ((buffer (get-buffer-create "*mam-stats*"))
        (secret (nth 0 (auth-source-search :host "mam.cookie"))))
    (make-process :name "mam"
                  :buffer buffer
                  :command `(,(executable-find "curl")
                             "-X" "POST"
                             "--cookie" ,(funcall (plist-get secret :secret))
                             "--header" "Content-Type: application/json"
                             "--data" ,(format "{\"id\": %s}" (plist-get secret :user))
                             "https://www.myanonamouse.net/jsonLoad.php?snatch_summary=t&notifs=t")
                  :filter (lambda (_proc output)
                            (let ((data (json-parse-string output
                                                           :object-type 'plist
                                                           :false-object "no"
                                                           :null-object nil))
                                  (inhibit-read-only t))
                              (with-current-buffer buffer
                                (read-only-mode 1)
                                (erase-buffer)
                                (insert (format "Stats for: %s (uid: %s)\n  Bonus: %s | Connectable: %s\n"
                                                (plist-get data :username)
                                                (plist-get data :uid)
                                                (plist-get data :seedbonus)
                                                (plist-get data :connectable))
                                        (format "Total
 Up: %s | Total Down: %s | ratio: %s\n"
                                                (plist-get data :uploaded)
                                                (plist-get data :downloaded)
                                                (plist-get data :ratio))
                                        (format "Leeching: %s | Unsat: %s (%s seeding)\n"
                                                (plist-get (plist-get data :leeching) :count)
                                                (plist-get (plist-get data :unsat) :count)
                                                (plist-get (plist-get data :seedUnsat) :count))
                                        (format "Inactive H&R: %s | Inactive Unsat: %s | Inactive sat: %s\n"
                                                (plist-get (plist-get data :inactHnr) :count)
                                                (plist-get (plist-get data :inactUnsat) :count)
                                                (plist-get (plist-get data :inactSat) :count))))))
                  :sentinel (lambda (_proc _status)))
    ;; (with-current-buffer buffer (insert "\n"))
    (mam-get-torrent-info)
    (pop-to-buffer buffer)))

(defun mam-get-torrent-info ()
  (let ((data-unsat nil)
        (data-sat nil)
        (inhibit-read-only t))
    (with-temp-buffer
      (let* ((secret (nth 0 (auth-source-search :host "mam.cookie")))
             (proc (make-process :name "mam"
                                 :buffer (current-buffer)
                                 :command `(,(executable-find "curl")
                                            "--cookie" ,(funcall (plist-get secret :secret))
                                            "https://www.myanonamouse.net/json/loadUserDetailsTorrents.php?type=unsat&iteration=0")
                                 :sentinel (lambda (_proc _status)))))
        (while (process-live-p proc)
          (accept-process-output proc))
        (goto-char (point-min))
        (setf data-unsat (json-parse-buffer :object-type 'plist
                                            :false-object "no"
                                            :null-object "no"
                                            :array-type 'list))
        (erase-buffer)
        (let ((proc2 (make-process :name "mam"
                                   :buffer (current-buffer)
                                   :command `(,(executable-find "curl")
                                              "--cookie" ,(funcall (plist-get secret :secret))
                                              "https://www.myanonamouse.net/json/loadUserDetailsTorrents.php?type=sSsat&iteration=0")
                                   :sentinel (lambda (_proc _status)))))
          (while (process-live-p proc2)
            (accept-process-output proc))
          (goto-char (point-min))
          (setf data-sat (json-parse-buffer :object-type 'plist
                                            :false-object "no"
                                            :null-object "no"
                                            :array-type 'list)))))
    (with-current-buffer (get-buffer-create "*mam-stats*")
      (insert "\n")
      (make-vtable :columns '((:name "Name" :width "500px")
                              "Up" "Down" "Ratio" "Free?" "STG" "Seeding?")
                   :objects (plist-get data-unsat :rows)
                   :use-header-line nil
                   :getter (lambda (obj col _tbl)
                             (pcase col
                               (0 (plist-get obj :title))
                               (1 (plist-get obj :uploadPretty))
                               (2 (plist-get obj :downloadPretty))
                               (3 (plist-get obj :ratio))
                               (4 (format "%s (%s)"
                                          (plist-get obj :free)
                                          (plist-get obj :personalFree)))
                               (5 (plist-get obj :STG))
                               (6 (plist-get obj :seeder)))))
      (insert "\nSatisfied Seeding: \n")
      (make-vtable :columns '((:name "Name" :width "500px")
                              "Up" "Down" "Ratio" "Free?" "STG" "Seeding?")
                   :objects (plist-get data-unsat :rows)
                   :use-header-line nil
                   :getter (lambda (obj col _tbl)
                             (pcase col
                               (0 (plist-get obj :title))
                               (1 (plist-get obj :uploadPretty))
                               (2 (plist-get obj :downloadPretty))
                               (3 (plist-get obj :ratio))
                               (4 (format "%s (%s)"
                                          (plist-get obj :free)
                                          (plist-get obj :personalFree)))
                               (5 (plist-get obj :STG))
                               (6 (plist-get obj :seeder))))))))

(setq w3m-init-file (expand-file-name ".w3m.el" user-emacs-directory))

;; newsticker
(require 'newsticker)
(setq newsticker-url-list-defaults nil
      newsticker-automatically-mark-visited-items-as-old t
      newsticker-treeview-automatically-mark-displayed-items-as-old nil
      newsticker-automatically-mark-items-as-old nil
      newsticker-obsolete-item-max-age 259200 ;; 3 days
      ;; newsticker-retrieval-interval 259200
      newsticker-retrieval-interval 10800 ;; 3 hours
      ;;  newsticker-retrieval-interval 1.0e+INF
      newsticker-download-logos nil
      newsticker-retrieval-method 'extern
      newsticker-wget-name "curl"
      newsticker-wget-arguments '("--silent" "--location" "--connect-timeout" "8"))

(defun my/newsticker-treeview-custom-quit ()
  "quit without messing up groups"
  (interactive)
  (setq newsticker--sentinel-callback nil)
  (bury-buffer "*Newsticker Tree*")
  (bury-buffer "*Newsticker List*")
  (bury-buffer "*Newsticker Item*")
  (set-window-configuration newsticker--saved-window-config)
  (when newsticker--frame
    (if (frame-live-p newsticker--frame)
        (delete-frame newsticker--frame))
    (setq newsticker--frame nil)))
;;(define-key newsticker-treeview-mode-map (kbd "q") 'my/newsticker-treeview-quit-and-stop)
(with-eval-after-load 'newst-treeview
  (substitute-key-definition 'newsticker-treeview-quit 'my/newsticker-treeview-custom-quit newsticker-treeview-mode-map))

(defun newsticker-unload ()
  (interactive)
  (unload-feature 'newst-backend t)
  (unload-feature 'newst-reader t)
  (unload-feature 'newst-treeview t)
  (unload-feature 'newsticker t))

(setq newsticker-url-list
      '(
        ;; ("arXiv q-bio" "https://arxiv.org/rss/q-bio")
        ;; ("bioRxiv" "https://connect.biorxiv.org/biorxiv_xml.php?subject=all")
        ;; ("medRxiv" "https://connect.medrxiv.org/medrxiv_xml.php?subject=all")
        ;; ("arXiv math" "https://arxiv.org/rss/math")
        ("Terence Tao" "https://terrytao.wordpress.com/feed/")
        ("LessWrong" "https://www.lesswrong.com/feed.xml?view=community-rss&karmaThreshold=45")
        ("Astral Codex Ten" "https://astralcodexten.substack.com/feed")
        ("Scott Aaronson" "https://scottaaronson.blog/?feed=rss2")
        ("Zvi" "https://thezvi.wordpress.com/feed")
        ("Fantastic Anachronism" "https://fantasticanachronism.com/atom.xml")
        ("Hands and Cities" "https://handsandcities.com/feed/")
        ("Strange Loop Canon" "https://www.strangeloopcanon.com/feed")
        ("Protesilaos Blog" "https://protesilaos.com/master.xml")
        ("Gwern.net Newsletter" "https://gwern.substack.com/feed" nil 86400)
        ("Suspended Reason" "https://suspendedreason.com/feed" nil 86400)
        ("Melting Asphalt" "https://meltingasphalt.com/feed")
        ("nearcyan" "https://nearcyan.com/feed")
        ("For me, in full bloom" "https://formeinfullbloom.wordpress.com/feed/" nil 86400)
        ("Therefore it is" "https://thereforeitis.wordpress.com/feed" nil 86400)
        ("Wrong Every Time" "https://wrongeverytime.com/feed" nil 86400)
        ("Sakuga Blog" "https://blog.sakugabooru.com/feed/")
        ("ANN" "https://www.animenewsnetwork.com/all/rss.xml?ann-edition=us")
        ;; ("R Weekly" "https://rweekly.org/atom.xml" nil 86400)
        ;; ("GNOME Blogs" "https://blogs.gnome.org/feed/")
        ("Drew Devault" "https://drewdevault.com/blog/index.xml" nil 86400)
        ;; ("Freedom To Tinker" "https://freedom-to-tinker.com/feed/rss/" nil 86400)
        ("Lennart Poettering" "https://0pointer.net/blog/index.rss20")
        ;; ("LWN" "https://lwn.net/headlines/rss")
        ("XKCD" "https://xkcd.com/rss.xml")
        ;; ("Emacs commits" "https://github.com/emacs-mirror/emacs/commits.atom")
        ("wingolog" "https://wingolog.org/feed/atom")
        ;; ("Protesilaos" "https://invidious.kavin.rocks/feed/channel/UC0uTPqBCFIpZxlz_Lv1tk_g" nil 86400)
        ;; ("Cateen" "https://invidious.kavin.rocks/feed/channel/UC_QG8miwKHFNuWY9VpkrI8w" nil 86400)
        ;; ("Animenz" "https://invidious.kavin.rocks/feed/channel/UCyW-leqPXUunrXXxFjpZ7VA" nil 86400)
        ;; ("Marasy8" "https://invidious.kavin.rocks/feed/channel/UCcvLSRIWJIAGFDyWtzkbiHA" nil 86400)
        ;; ("Kyle Landry" "https://invidious.kavin.rocks/feed/channel/UCk0UErv9b4Hn5ucNNjqD1UQ" nil 86400)
        ;; ("Kayou" "https://invidious.kavin.rocks/feed/channel/UCk2g7q-RY455IuRWCIJ0bmw" nil 86400)
        ;; ("Halcyon" "https://invidious.kavin.rocks/feed/channel/UC8tyyA-UIbefEexcLatHmUQ" nil 86400)
        ;; ("SLS" "https://invidious.kavin.rocks/feed/channel/UCmKy7mz6tRLv7OFdSqbAkrg" nil 86400)
        ;; ("mdbg" "https://www.mdbg.net/chinese/feed?feed=hsk_1_h")))
        ))

(put 'list-timers 'disabled nil)
(put 'scroll-left 'disabled nil)

(provide 'custom-ops)
