;; quelpa recipes for building packages -*- lexical-binding: t; -*-

(require 'quelpa)

;; code
(quelpa '(eglot        :fetcher github :repo "joaotavora/eglot"))
(quelpa '(lsp-mode     :fetcher github :repo "emacs-lsp/lsp-mode" :files (:defaults "clients/*.el")))
(quelpa '(rustic       :fetcher github :repo "brotzeit/rustic"))
(quelpa '(gnuplot      :fetcher github :repo "emacsorphanage/gnuplot"))
(quelpa '(ess          :fetcher github :repo "emacs-ess/ESS"))
(quelpa '(haskell-mode :fetcher github :repo "haskell/haskell-mode"))
(quelpa '(lua-mode     :fetcher github :repo "immerrr/lua-mode" :files (:defaults (:exclude "init-tryout.el"))))
(quelpa '(pyvenv       :fetcher github :repo "jorgenschaefer/pyvenv"))
(quelpa '(pytest       :fetcher github :repo "ionrock/pytest-el"))
(quelpa '(ein          :fetcher github :repo "millejoh/emacs-ipython-notebook" :files ("lisp/*" (:exclude "lisp/zeroein.el"))))

;; editing
(quelpa '(avy                     :fetcher github :repo "abo-abo/avy"))
(quelpa '(avy-menu                :fetcher github :repo "mrkkrp/avy-menu"))
(quelpa '(rainbow-delimiters      :fetcher github :repo "Fanael/rainbow-delimiters"))
(quelpa '(ligature                :fetcher github :repo "mickeynp/ligature.el"))
(quelpa '(company                 :fetcher github :repo "company-mode/company-mode" :files (:defaults "icons")))
(quelpa '(company-quickhelp       :fetcher github :repo "company-mode/company-quickhelp"))
(quelpa '(aggressive-indent       :fetcher github :repo "Malabarba/aggressive-indent-mode"))
;; (quelpa '(smart-tab               :fetcher git    :url "https://git.genehack.net/genehack/smart-tab.git"))
(quelpa '(highlight-indent-guides :fetcher github :repo "DarthFennec/highlight-indent-guides"))
(quelpa '(smartparens             :fetcher github :repo "Fuco1/smartparens"))
(quelpa '(fic-mode                :fetcher github :repo "lewang/fic-mode"))
(quelpa '(beacon                  :fetcher github :repo "Malabarba/beacon"))

;; flycheck
(quelpa '(flycheck              :fetcher github :repo "flycheck/flycheck"))
(quelpa '(flycheck-vale         :fetcher github :repo "abingham/flycheck-vale"))
(quelpa '(flycheck-languagetool :fetcher github :repo "emacs-languagetool/flycheck-languagetool"))
(quelpa '(flyspell-correct      :fetcher github :repo "d12frosted/flyspell-correct"))

;; prose
(quelpa '(auctex :fetcher git :url "https://git.savannah.gnu.org/git/emacs/elpa.git"
           :branch "externals/auctex" :files ("*.el" "*.info" "tests" "style" "latex")))
(quelpa '(langtool-ignore-fonts :fetcher github :repo "cjl8zf/langtool-ignore-fonts"))
(quelpa '(writeroom-mode        :fetcher github :repo "joostkremers/writeroom-mode"))
(quelpa '(powerthesaurus        :fetcher github :repo "SavchenkoValeriy/emacs-powerthesaurus"))
(quelpa '(writegood-mode        :fetcher github :repo "bnbeckwith/writegood-mode"))
(quelpa '(math-symbols          :fetcher github :repo "kawabata/math-symbols"))
(quelpa '(unicode-math-input    :fetcher github :repo "astoff/unicode-math-input.el"))
(quelpa '(biblio                :fetcher github :repo "cpitclaudel/biblio.el"))
(quelpa '(bibtex-completion     :fetcher github :repo "tmalsburg/helm-bibtex" :files ("bibtex-completion.el")))

(quelpa '(markdown-mode :fetcher github :repo "jrblevin/markdown-mode"))
(quelpa '(mediawiki     :fetcher github :repo "hexmode/mediawiki-el"))

;; org mode
(quelpa '(org-download :fetcher github :repo "abo-abo/org-download"))
(quelpa '(org-fragtog  :fetcher github :repo "io12/org-fragtog"))
(quelpa '(ox-hugo      :fetcher github :repo "kaushalmodi/ox-hugo"))
(quelpa '(org-autolist :fetcher github :repo "calvinwyoung/org-autolist"))
(quelpa '(org-bullets  :fetcher github :repo "integral-dw/org-bullets"))
(quelpa '(cdlatex      :fetcher github :repo "cdominik/cdlatex"))
(quelpa '(el-easydraw  :fetcher github :repo "misohena/el-easydraw"))

;; helpful utilities
(quelpa '(vterm                    :fetcher github :repo "akermu/emacs-libvterm"
           :files ("*" (:exclude ".dir-locals.el" ".gitignore" ".clang-format" ".travis.yml"))))
(quelpa '(pdf-tools                :fetcher github :repo "vedang/pdf-tools"
           :files ("lisp/*.el" "README" ("build" "Makefile") ("build" "server")
                    (:exclude "lisp/tablist.el" "lisp/tablist-filter.el"))))
(quelpa '(magit :fetcher github :repo "magit/magit"
           :files ("lisp/magit" "lisp/magit*.el" "lisp/git-rebase.el" "docs/magit.texi"
                    (:exclude "lisp/magit-libgit.el" "lisp/magit-libgit-pkg.el"
                      "lisp/magit-section.el" "lisp/magit-section-pkg.el"
                      "Documentation/magit.texi" "Documentation/AUTHORS.md"))))
(quelpa '(eshell-vterm             :fetcher github :repo "iostapyshyn/eshell-vterm"))
(quelpa '(nov                      :fetcher git    :url "https://depp.brause.cc/nov.el.git"))
(quelpa '(which-key                :fetcher github :repo "justbur/emacs-which-key"))
(quelpa '(persistent-scratch       :fetcher github :repo "Fanael/persistent-scratch"))
(quelpa '(all-the-icons            :fetcher github :repo "domtronn/all-the-icons.el"))
(quelpa '(all-the-icons-dired      :fetcher github :repo "wyuenho/all-the-icons-dired"))
(quelpa '(all-the-icons-ibuffer    :fetcher github :repo "seagle0128/all-the-icons-ibuffer"))
(quelpa '(all-the-icons-completion :fetcher github :repo "iyefrat/all-the-icons-completion"))
(quelpa '(good-scroll              :fetcher github :repo "io12/good-scroll.el"))


;; Other
(quelpa '(ytdious         :fetcher github :repo "spiderbit/ytdious"))
(quelpa '(speed-type      :fetcher github :repo "parkouss/speed-type"))
(quelpa '(spray           :fetcher git    :url "https://git.sr.ht/~iank/spray"))
(quelpa '(elpher          :fetcher git    :url "https://thelambdalab.xyz/git/elpher.git"))
(quelpa '(empv            :fetcher github :repo "isamert/empv.el"))
(quelpa '(plz             :fetcher github :repo "alphapapa/plz.el"))
(quelpa '(ement           :fetcher github :repo "alphapapa/ement.el"))
(quelpa '(aria2           :fetcher gitlab :repo "unmem/aria2"))
(quelpa '(centered-window :fetcher github :repo "anler/centered-window-mode"))
(quelpa '(smtpmail-multi  :fetcher github :repo "vapniks/smtpmail-multi"))
