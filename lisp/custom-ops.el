;; -*- lexical-binding: t; eval: (ligature-mode -1) -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(org-agenda-files '("/home/rayes/Notes/org/todo.org"))
 '(package-selected-packages
    '(eglot pyvenv lua-mode empv eshell-vterm pdf-tools elpher spray speedread elfeed sublimity darkroom ligature fanyi aria2 langtool-ignore-fonts flycheck pkg-info epl bibtex-completion ido-better-flex ement plz ido-at-point free-keys good-scroll biblio haskell-mode cmus flyspell-correct-avy-menu frame-purpose rainbow-identifiers tracking ov a dash-functional anaphora org-latex-impatient org-contrib org w3m htmlize nov sx auctex cdlatex avy bash-completion transient named-timer mediawiki app-launcher xterm-color visual-fill-column dash s tablist spinner f markdown-mode request jeison polymode poly-noweb ht async memoize lv hydra goto-chg all-the-icons beginend ido-grid-mode ido-completing-read+ el-easydraw ts quelpa indent-guide org-noter persistent-scratch smartparens all-the-icons-ibuffer all-the-icons-dired org-bullets org-superstar speed-type poly-R poly-markdown ess ytdious activity-watch-mode org-autolist undo-tree unicode-math-input math-symbols writegood-mode powerthesaurus ox-hugo centered-window org-fragtog org-download anki-editor gnuplot vterm which-key rustic writeroom-mode))
 '(pdf-view-resize-factor 1.01)
 '(safe-local-variable-values
    '((pyvenv-activate . "./venv")
       (eval ligature-mode -1)
       (eval flycheck-mode nil)
       (flycheck-mode)
       (org-time-stamp-custom-formats "%m/%d/%y" . "%m/%d/%y"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; org agenda files
(setq org-directory "~/Notes/org"
  org-agenda-files (list org-directory))

(add-hook 'eshell-mode-hook 'eshell-vterm-mode)

(setq org-format-latex-options
  '(:foreground default
     :background "Transparent"
     :scale 1.2
     :html-foreground "Black"
     :html-background "Transparent"
     :html-scale 1.2
     :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; link opener
(defun browse-url-misc (url &rest args)
  (interactive)
  (call-process "/home/rayes/bin/link-open" nil 0 nil url))
(setq browse-url-browser-function 'browse-url-misc)

;;(require 'cmus)
;;(cmus-setup-default)

;; mediawiki
(require 'mediawiki)
(setq mediawiki-site-alist
  '(("Wikipedia" "https://en.wikipedia.org/w/" "Rayes0" "" nil "Main Page")
     ("Mobileread" "https://wiki.mobileread.com/wiki/" "rayes" "" nil "Main Page")))
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
(autoload 'ido-at-point-mode "ido-at-point")
(ido-at-point-mode)

;; undo tree
;;(global-undo-tree-mode)

;; markdown-mode
(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; rustic-mode
(setq rustic-lsp-client 'eglot)
(add-hook 'rustic-mode-hook 'eglot-ensure)

;; eglot
(with-eval-after-load 'eglot
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc)
  (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions))

(setq eglot-sync-connect 0)

;; change default python interpreter to ipython
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")

;; which-key-mode
(which-key-mode t)

;; spray
(require 'spray)
(setq spray-height 140
  spray-margin-top 5
  spray-margin-left 80)

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
(add-hook 'org-mode-hook 'org-cdlatex-mode)

;; org-latex
(setq org-latex-create-formula-image-program 'dvisvgm)

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
  (if (file-directory-p "~/media/academic/")
    (directory-files "~/media/academic/" t ".*.bib")
    "~/media/academic/references.bib")
  bibtex-completion-library-path "~/media/academic/pdfs/"
  bibtex-completion-notes-path "~/media/academic/notes/")

(defun open-pdf-from-bibtex ()
  (interactive)
  (bibtex-completion-open-pdf (list (bibtex-completion-get-key-bibtex))))
(defun open-notes-from-bibtex ()
  (interactive)
  (bibtex-completion-edit-notes (list (bibtex-completion-get-key-bibtex))))

(define-key bibtex-mode-map (kbd "C-c C-v p") 'open-pdf-from-bibtex)
(define-key bibtex-mode-map (kbd "C-c C-v n") 'open-notes-from-bibtex)

(setq org-cite-global-bibliography bibtex-completion-bibliography)

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
(setq vterm-buffer-name-string "%s | vterm")

;; ido
;;(require 'ido-hacks)
;;(require 'ido-completing-read+)
;;(ido-ubiquitous-mode 1)
;;(ido-grid-mode 1)
;;(setq ido-grid-mode-start-collapsed t)

;; ytdious
(setq ytdious-invidious-api-url "https://invidious.snopyta.org")

;; R markdown
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
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
(add-to-list 'auto-mode-alist '("\\.Rmd" . rmd-mode))

;; pdf-tools
(pdf-tools-install)
;; (add-hook 'pdf-view-mode-hook (lambda ()
;;                                 (setq-local auto-revert-interval 0.5)
;;                                 (auto-revert-mode 1)
;;                                 (auto-revert-set-timer)))

;; all-the-icons
(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(with-eval-after-load 'all-the-icons-dired
  (set-face-attribute 'all-the-icons-dired-dir-face nil :foreground "#6c605a"))

;; dired async
(dired-async-mode 1)

;; ibuffer custom buffers
(setq ibuffer-saved-filter-groups
  (quote (("main"
            ("MODIFIED" (and
                          (modified . t)
                          (visiting-file . t)))
            ("term" (or
                      (mode . vterm-mode)
                      (mode . eshell-mode)
                      (mode . term-mode)
                      (mode . shell-mode)))
            ("planning" (or
                          (name . "^\\*Calendar\\*$")
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
            ("docs" (or
                      (mode . pdf-view-mode)
                      (mode . doc-view-mode)))
            ("img" (mode . image-mode))
            ("elisp" (or (filename . "/.emacs.d/")
                       (filename . "/.config/emacs/")
                       (mode . Custom-mode)))
            ("config" (or (filename . "/.config/")
                        (filename . "/.themes/")))
            ("code" (or
                      (derived-mode . prog-mode)
                      (mode . ess-mode)
                      (filename . "/projects/")))
            ("dired" (mode . dired-mode))
            ("chat" (or
                      (mode . ement-room-list-mode)
                      (mode . ement-room-mode)))
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

;; easydraw and org noter
(with-eval-after-load 'org
  (require 'edraw-org)
  (edraw-org-setup-default)
  (setq org-noter-notes-search-path '("~/Notes/org")))

;; avy
;;(avy-setup-default)
;;(define-prefix-command 'avy-map)
;;(global-set-key (kbd "M-s") 'avy-map)
;;(define-key avy-map (kbd "c") 'avy-goto-char)
;;(define-key avy-map (kbd "s") 'avy-goto-char-2)
;;(define-key avy-map (kbd "w") 'avy-goto-word-1)
;;(define-key avy-map (kbd "l") 'avy-goto-line)
;;(define-key avy-map (kbd "h") 'avy-org-goto-heading-timer)
(global-set-key (kbd "M-s") 'avy-goto-char-timer)
(setq avy-style 'pre
  avy-background t
  avy-flyspell-correct-function 'ispell-word
  avy-keys '(106 107 108 104 103 102 100 115 97)
  avy-timeout-seconds 0.4)
(define-key isearch-mode-map (kbd "M-j") 'avy-isearch)

;; flyspell-correct
(require 'flyspell-correct-avy-menu)
(define-key flyspell-mode-map (kbd "C-`") 'flyspell-correct-wrapper)

;; good-scroll
(good-scroll-mode 1)
(global-set-key [next] #'good-scroll-up-full-screen)
(global-set-key [prior] #'good-scroll-down-full-screen)

;;(global-set-key "\M-n"  (lambda () (interactive) (good-scroll-up   4)) )
;;(global-set-key "\M-p"  (lambda () (interactive) (good-scroll-down 4)) )
(setq good-scroll-duration 0.15
  good-scroll-render-rate 0.015)

;; ement
(global-set-key (kbd "M-g M-l") 'ement-list-rooms)
(with-eval-after-load 'ement
  (setq ement-save-sessions t
    ement-room-send-typing nil
    ement-room-send-read-receipts nil
    ement-room-prism nil
    ;;    ement-room-send-message-filter 'ement-room-send-org-filter
    ement-room-mark-rooms-read nil
    ement-room-message-format-spec "%B%r%R%t"
    ement-room-left-margin-width 0
    ement-room-right-margin-width 8
    ement-room-sender-in-headers t
    ement-room-sender-headers t)
  (set-face 'ement-room-message-text 'variable-pitch)
  (set-face 'ement-room-mention 'face-block)
  (set-face-attribute 'ement-room-mention nil
    :extend t))

;; quelpa recipes
;;(quelpa '(el-easydraw :fetcher github :repo "misohena/el-easydraw"))
;;(quelpa '(plz :fetcher github :repo "alphapapa/plz.el"))
;;(quelpa '(ement :fetcher github :repo "alphapapa/ement.el"))
;;(quelpa '(matrix-client :fetcher github :repo "alphapapa/matrix-client.el"))
;;(quelpa '(app-launcher :fetcher github :repo "SebastienWae/app-launcher"))
;;(quelpa '(emacs-webkit :fetcher github :repo "akirakyle/emacs-webkit"))
;;(quelpa '(eva :fetcher github :repo "meedstrom/eva"))
;;(quelpa '(ido-better-flex :fetcher github :repo "vic/ido-better-flex"))
;;(quelpa '(flycheck-languagetool :fetcher github :repo "emacs-languagetool/flycheck-languagetool"))
;;(quelpa '(aria2 :fetcher gitlab :repo "unmem/aria2"))
;;(quelpa '(ligature :fetcher github :repo "mickeynp/ligature.el"))
;;(quelpa '(zen-mode :fetcher github :repo "aki237/zen-mode"))
;;(quelpa '(centered-window :fetcher github :repo "anler/centered-window-mode"))
;;(quelpa '(speedread :fetcher github :repo "vapniks/speedread"))
;;(quelpa '(empv :fetcher github :repo "isamert/empv.el"))
;;(quelpa '(eglot :fetcher github :repo "joaotavora/eglot"))

(setq empv-mpv-args '("--ytdl-format=best" "--no-terminal" "--idle" "--input-ipc-server=/tmp/empv-socket"))

;; cascadia code ligatures
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
  (dolist (mode '(eww-mode org-mode))
    (ligature-set-ligatures mode variable-ligset))
  (ligature-set-ligatures 'prog-mode mono-ligset)
  (ligature-set-ligatures 'org-mode mono-ligset) ;; for codeblocks
  (global-ligature-mode t))

;; flycheck
(global-flycheck-mode)
(setq flycheck-emacs-lisp-load-path 'inherit)
(setq flycheck-global-modes '(not org-mode))
(setq flycheck-textlint-config "~/.textlintrc.json"
  flycheck-textlint-executable "~/node_modules/.bin/textlint")
;;(setq flycheck-languagetool-server-jar "~/.local/opt/LanguageTool-5.5/languagetool-server.jar")

(setq langtool-language-tool-jar "~/.local/opt/LanguageTool-5.5/languagetool-commandline.jar")
(require 'langtool)

;; pyvenv
(pyvenv-mode nil)
(pyvenv-tracking-mode 1)

;; native comp options
(setq native-comp-always-compile t)
(setq package-native-compile t)
(setq native-comp-compiler-options '("-O2" "-march=skylake" "-mtune=native"))

;; eaf
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/")
;;(require 'eaf)
;;(require 'eaf-browser)
;;(require 'eaf-pdf-viewer)
;;(require 'eaf-terminal)

;; centered window
(setq cwm-centered-window-width 80)

;; newsticker
(setq newsticker-url-list-defaults nil
  newsticker-automatically-mark-visited-items-as-old t
  newsticker-treeview-automatically-mark-displayed-items-as-old nil
  newsticker-automatically-mark-items-as-old nil
  newsticker-obsolete-item-max-age 259200 ;; 3 days
  newsticker-retrieval-interval 259200
;;  newsticker-retrieval-interval 10800 ;; 3 hours
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

(setq newsticker-url-list
  '(("arXiv q-bio" "https://arxiv.org/rss/q-bio")
     ("bioRxiv" "https://connect.biorxiv.org/biorxiv_xml.php?subject=all")
     ("medRxiv" "https://connect.medrxiv.org/medrxiv_xml.php?subject=all")
     ("arXiv math" "https://arxiv.org/rss/math")
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
     ("For me, in full bloom" "https://formeinfullbloom.wordpress.com/feed/" nil 86400)
     ("Therefore it is" "https://thereforeitis.wordpress.com/feed" nil 86400)
     ("Wrong Every Time" "https://wrongeverytime.com/feed" nil 86400)
     ("Sakuga Blog" "https://blog.sakugabooru.com/feed/")
     ("ANN" "https://www.animenewsnetwork.com/all/rss.xml?ann-edition=us")
     ("R Weekly" "https://rweekly.org/atom.xml" nil 86400)
     ("GNOME Blogs" "https://blogs.gnome.org/feed/")
     ("Drew Devault" "https://drewdevault.com/blog/index.xml" nil 86400)
     ("Freedom To Tinker" "https://freedom-to-tinker.com/feed/rss/" nil 86400)
     ("Lennart Poettering" "https://0pointer.net/blog/index.rss20")
     ("SE - Hot" "https://stackexchange.com/feeds/questions")
     ("SE - Linguistics" "https://linguistics.stackexchange.com/feeds/week")
     ("SE - Psychology" "https://psychology.stackexchange.com/feeds/week")
     ("SE - SciFi" "https://scifi.stackexchange.com/feeds/week")
     ("SE - Stats" "https://stats.stackexchange.com/feeds/week")
     ("SE - Music" "https://music.stackexchange.com/feeds/week")
     ("SE - Unix" "https://unix.stackexchange.com/feeds/week")
     ("SE - Animanga" "https://anime.stackexchange.com/feeds/week")
     ("SE - Chinese Language" "https://chinese.stackexchange.com/feeds/week")
     ("SE - Emacs" "https://emacs.stackexchange.com/feeds/week")
     ("SE - Math" "https://mathoverflow.net/feeds/week")
     ("SE - Skeptics" "https://skeptics.stackexchange.com/feeds/week")
     ("SE - Bioinformatics" "https://bioinformatics.stackexchange.com/feeds/week")
     ("SE - Biblical Hermeneutics" "https://hermeneutics.stackexchange.com/feeds/week")
     ("XKCD" "https://xkcd.com/rss.xml")
     ("Emacs commits" "https://github.com/emacs-mirror/emacs/commits.atom")
     ("Zrythm commits" "https://github.com/zrythm/zrythm/commits.atom")
     ("KOReader commits" "https://github.com/koreader/koreader/commits.atom")
     ("Fedora Magazine" "https://fedoramagazine.org/feed")
     ("Protesilaos" "https://invidious.kavin.rocks/feed/channel/UC0uTPqBCFIpZxlz_Lv1tk_g" nil 86400)
     ("Cateen" "https://invidious.kavin.rocks/feed/channel/UC_QG8miwKHFNuWY9VpkrI8w" nil 86400)
     ("Animenz" "https://invidious.kavin.rocks/feed/channel/UCyW-leqPXUunrXXxFjpZ7VA" nil 86400)
     ("Marasy8" "https://invidious.kavin.rocks/feed/channel/UCcvLSRIWJIAGFDyWtzkbiHA" nil 86400)
     ("Kyle Landry" "https://invidious.kavin.rocks/feed/channel/UCk0UErv9b4Hn5ucNNjqD1UQ" nil 86400)
     ("Kayou" "https://invidious.kavin.rocks/feed/channel/UCk2g7q-RY455IuRWCIJ0bmw" nil 86400)
     ("Halcyon" "https://invidious.kavin.rocks/feed/channel/UC8tyyA-UIbefEexcLatHmUQ" nil 86400)
     ("SLS" "https://invidious.kavin.rocks/feed/channel/UCmKy7mz6tRLv7OFdSqbAkrg" nil 86400)
     ("mdbg" "https://www.mdbg.net/chinese/feed?feed=hsk_1_h")))

;;(setq elfeed-feeds '("https://www.lesswrong.com/feed.xml?view=community-rss&karmaThreshold=45"))
;; (setq elfeed-feeds
;;   '(("https://arxiv.org/rss/q-bio" rxiv)
;;      ("https://connect.biorxiv.org/biorxiv_xml.php?subject=all" rxiv)
;;      ("https://connect.medrxiv.org/medrxiv_xml.php?subject=all" rxiv)
;;      ("https://arxiv.org/rss/math" rxiv)
;;      ("https://terrytao.wordpress.com/feed/" math)
;;      ("https://www.lesswrong.com/feed.xml?view=community-rss&karmaThreshold=45" philosophy)
;;      ("https://astralcodexten.substack.com/feed" philosophy)
;;      ("https://fantasticanachronism.com/atom.xml" books)
;;      ("https://protesilaos.com/master.xml" philosophy)
;;      ("https://gwern.substack.com/feed" philosophy)
;;      ("https://suspendedreason.com/feed" philosophy)
;;      ("https://formeinfullbloom.wordpress.com/feed/" animanga)
;;      ("https://thereforeitis.wordpress.com/feed" animanga)
;;      ("https://wrongeverytime.com/feed" animanga)
;;      ("https://www.animenewsnetwork.com/all/rss.xml?ann-edition=us" animanga)
;;      ("https://rweekly.org/atom.xml" tech)
;;      ("https://blogs.gnome.org/feed/" tech)
;;      ("https://drewdevault.com/blog/index.xml" tech)
;;      ("https://freedom-to-tinker.com/feed/rss/" tech)
;;      ("https://stackexchange.com/feeds/questions" stackexchange)
;;      ("https://linguistics.stackexchange.com/feeds/week" stackexchange)
;;      ("https://psychology.stackexchange.com/feeds/week" stackexchange)
;;      ("https://scifi.stackexchange.com/feeds/week" stackexchange)
;;      ("https://stats.stackexchange.com/feeds/week" stackexchange)
;;      ("https://music.stackexchange.com/feeds/week" stackexchange)
;;      ("https://unix.stackexchange.com/feeds/week" stackexchange)
;;      ("https://anime.stackexchange.com/feeds/week" stackexchange)
;;      ("https://chinese.stackexchange.com/feeds/week" stackexchange)
;;      ("https://emacs.stackexchange.com/feeds/week" stackexchange)
;;      ("https://mathoverflow.net/feeds/week" stackexchange)
;;      ("https://skeptics.stackexchange.com/feeds/week" stackexchange)
;;      ("https://bioinformatics.stackexchange.com/feeds/week" stackexchange)
;;      ("https://hermeneutics.stackexchange.com/feeds/week" stackexchange)
;;      ("https://xkcd.com/rss.xml")
;;      ("https://github.com/emacs-mirror/emacs/commits.atom" github)
;;      ("https://github.com/zrythm/zrythm/commits.atom" github)
;;      ("https://fedoramagazine.org/feed" tech)
;;      ("https://invidious.kavin.rocks/feed/channel/UC0uTPqBCFIpZxlz_Lv1tk_g" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UC_QG8miwKHFNuWY9VpkrI8w" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UCyW-leqPXUunrXXxFjpZ7VA" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UCcvLSRIWJIAGFDyWtzkbiHA" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UCk0UErv9b4Hn5ucNNjqD1UQ" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UCk2g7q-RY455IuRWCIJ0bmw" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UC8tyyA-UIbefEexcLatHmUQ" youtube)
;;      ("https://invidious.kavin.rocks/feed/channel/UCmKy7mz6tRLv7OFdSqbAkrg" youtube)))

;; (require 'elfeed)
;; (setq elfeed-user-agent "")
;; (setq-default elfeed-search-filter "@1-week-ago ")
;; (global-set-key (kbd "C-x w") 'elfeed)
;; (set-face 'elfeed-search-title-face 'default)
;; (set-face 'elfeed-search-feed-face 'face-keyword)
;; (set-face 'elfeed-search-tag-face 'face-salient)
;; (set-face-attribute 'elfeed-search-tag-face nil
;;   :weight 'bold)
;; (set-face 'elfeed-search-date-face 'face-faded)
;; (set-face 'elfeed-search-unread-count-face 'face-strong)

(provide 'custom-ops)
(put 'list-timers 'disabled nil)
