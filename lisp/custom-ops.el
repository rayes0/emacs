(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(cmus-command "/home/rayes/.local/bin/cmus-remote")
 '(org-agenda-files '("/home/rayes/Notes/org/todo.org"))
 '(package-selected-packages
    '(ligature orderless live-completions fanyi aria2 langtool-ignore-fonts flycheck pkg-info epl bibtex-completion ido-better-flex ement plz ido-at-point free-keys good-scroll citeproc-org org-ref biblio haskell-mode cmus flyspell-correct-avy-menu frame-purpose rainbow-identifiers tracking ov a dash-functional anaphora org-latex-impatient org-contrib org w3m org-alert htmlize nov sx auctex cdlatex avy bash-completion transient named-timer md4rd mediawiki pdf-tools app-launcher xterm-color visual-fill-column dash s tablist spinner f markdown-mode request jeison polymode poly-noweb ht async memoize lv hydra goto-chg all-the-icons beginend ido-grid-mode ido-completing-read+ el-easydraw ts quelpa indent-guide org-noter persistent-scratch smartparens all-the-icons-ibuffer all-the-icons-dired shx org-bullets org-superstar speed-type poly-R poly-markdown ess ytdious counsel-codesearch activity-watch-mode org-autolist undo-tree unicode-math-input math-symbols writegood-mode powerthesaurus ox-hugo centered-window org-fragtog org-download anki-editor gnuplot vterm which-key rustic writeroom-mode eglot))
 '(safe-local-variable-values
    '((flycheck-mode)
       (org-time-stamp-custom-formats "%m/%d/%y" . "%m/%d/%y"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; link opener
(defun browse-url-misc (url &rest args)
  (interactive)
  (call-process "/home/rayes/bin/link-open" nil 0 nil url))
(setq browse-url-browser-function 'browse-url-misc)

(require 'cmus)
(cmus-setup-default)
 
;; mediawiki
(require 'mediawiki)
(setq mediawiki-site-alist
  '(("Wikipedia" "https://en.wikipedia.org/w/" "Rayes0" "" nil "Main Page")
     ("TVTropes" "https://tvtropes.org/" nil nil nil nil)))

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
(global-undo-tree-mode)

;; markdown-mode
(require 'init-mdown)

(put 'dired-find-alternate-file 'disabled nil)

;; rustic-mode
(setq rustic-lsp-client 'eglot)

;; eglot
(with-eval-after-load 'eglot
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc)
  (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions))

(setq eglot-sync-connect 0)
(add-hook 'rustic-mode-hook 'eglot-ensure)

;; which-key-mode
(which-key-mode t)

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

;; org-fragtog and cdlatex
(add-hook 'org-mode-hook 'org-fragtog-mode)
(add-hook 'org-mode-hook 'org-cdlatex-mode)

;; org-latex
(setq org-latex-create-formula-image-program 'dvisvgm)

;; org-bullets
(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))

;; org-alert
(require 'org-alert)
(org-alert-enable)
(setq alert-default-style 'libnotify)

;; bibtex and org-cite setup
(setq bibtex-field-delimiters 'double-quotes
  bibtex-entry-format
  `(opts-or-alts page-dashes required-fields
     numerical-fields whitespace last-comma delimiters
     unify-case sort-fields)
  bibtex-align-at-equal-sign t)

(require 'bibtex-completion)
(setq bibtex-completion-bibliography '("~/media/academic/references.bib")
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
(ido-grid-mode 1)
(setq ido-grid-mode-start-collapsed t)

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
            ("browser" (mode . xwidget-webkit-mode))
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
            ("other" (name . "^.*$"))
            ))))
(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-auto-mode 1)
    (ibuffer-switch-to-saved-filter-groups "main")))

(setq diary-file "~/Notes/diary")

;; shx
(shx-global-mode 1)
(defun shx-cmd-rename (name)
  "(SAFE) Rename the current buffer to NAME."
  (if (not (ignore-errors (rename-buffer name)))
    (shx-insert 'error "Can't rename buffer.")
    (shx-insert "Renaming buffer to " name "\n")
    (shx--hint "Emacs won't save buffers starting with *")))

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
  avy-keys '(106 107 108 104 103 102 100 115 97))
(define-key isearch-mode-map (kbd "M-j") 'avy-isearch)

;; flyspell-correct
(require 'flyspell-correct-avy-menu)
(define-key flyspell-mode-map (kbd "C-`") 'flyspell-correct-wrapper)

;; good-scroll
(good-scroll-mode 1)
(global-set-key [next] #'good-scroll-up-full-screen)
(global-set-key [prior] #'good-scroll-down-full-screen)

(global-set-key "\M-n"  (lambda () (interactive) (good-scroll-up   4)) )
(global-set-key "\M-p"  (lambda () (interactive) (good-scroll-down 4)) )
(setq good-scroll-duration 0.15
  good-scroll-render-rate 0.015)

;; ement
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
;;(quelpa '(live-completions :fetcher github :repo "oantolin/live-completions"))
(setq completion-styles '(flex orderless))
;;(quelpa '(ligature :fetcher github :repo "mickeynp/ligature.el"))

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
(setq flycheck-global-modes '(not org-mode))
(setq flycheck-textlint-config "~/.textlintrc.json"
  flycheck-textlint-executable "~/node_modules/.bin/textlint")
;;(setq flycheck-languagetool-server-jar "~/.local/opt/LanguageTool-5.5/languagetool-server.jar")

(setq langtool-language-tool-jar "~/.local/opt/LanguageTool-5.5/languagetool-commandline.jar")
(require 'langtool)

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

;; newsticker
(setq newsticker-url-list-defaults nil
  newsticker-automatically-mark-visited-items-as-old t
  newsticker-treeview-automatically-mark-displayed-items-as-old nil
  newsticker-automatically-mark-items-as-old nil
  newsticker-obsolete-item-max-age 259200 ;; 3 days
  newsticker-retrieval-interval 10800 ;; 3 hours
  newsticker-download-logos nil
  newsticker-retrieval-method 'extern
  newsticker-wget-name "curl"
  newsticker-wget-arguments '("--silent" "--location"))

(setq newsticker-url-list
  '(("arXiv q-bio" "https://arxiv.org/rss/q-bio")
     ("bioRxiv" "https://connect.biorxiv.org/biorxiv_xml.php?subject=all")
     ("medRxiv" "https://connect.medrxiv.org/medrxiv_xml.php?subject=all")
     ("arXiv math" "https://arxiv.org/rss/math")
     ("Terence Tao" "https://terrytao.wordpress.com/feed/")
     ("LessWrong" "https://www.lesswrong.com/feed.xml?view=community-rss&karmaThreshold=45")
     ("Astral Codex Ten" "https://astralcodexten.substack.com/feed")
     ("Fantastic Anachronism" "https://fantasticanachronism.com/atom.xml")
     ("Protesilaos Blog" "https://protesilaos.com/master.xml")
     ("Gwern.net Newsletter" "https://gwern.substack.com/feed" nil 86400)
     ("For me, in full bloom" "https://formeinfullbloom.wordpress.com/feed/" nil 86400)
     ("Therefore it is" "https://thereforeitis.wordpress.com/feed" nil 86400)
     ("Wrong Every Time" "https://wrongeverytime.com/feed" nil 86400)
     ("R Weekly" "https://rweekly.org/atom.xml" nil 86400)
     ("GNOME Blogs" "https://blogs.gnome.org/feed/")
     ("Drew Devault" "https://drewdevault.com/blog/index.xml" nil 86400)
     ("Freedom To Tinker" "https://freedom-to-tinker.com/feed/rss/" nil 86400)
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
     ("Fedora Magazine" "https://fedoramagazine.org/feed")
     ("Protesilaos" "https://invidious.kavin.rocks/feed/channel/UC0uTPqBCFIpZxlz_Lv1tk_g" nil 86400)
     ("Cateen" "https://invidious.kavin.rocks/feed/channel/UC_QG8miwKHFNuWY9VpkrI8w" nil 86400)
     ("Animenz" "https://invidious.kavin.rocks/feed/channel/UCyW-leqPXUunrXXxFjpZ7VA" nil 86400)
     ("Marasy8" "https://invidious.kavin.rocks/feed/channel/UCcvLSRIWJIAGFDyWtzkbiHA" nil 86400)
     ("Kyle Landry" "https://invidious.kavin.rocks/feed/channel/UCk0UErv9b4Hn5ucNNjqD1UQ" nil 86400)
     ("Kayou" "https://invidious.kavin.rocks/feed/channel/UCk2g7q-RY455IuRWCIJ0bmw" nil 86400)
     ("Halcyon" "https://invidious.kavin.rocks/feed/channel/UC8tyyA-UIbefEexcLatHmUQ" nil 86400)
     ("SLS" "https://invidious.kavin.rocks/feed/channel/UCmKy7mz6tRLv7OFdSqbAkrg" nil 86400)))

(provide 'custom-ops)
