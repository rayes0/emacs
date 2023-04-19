;; quelpa recipes for building packages -*- lexical-binding: t; truncate-lines: nil; -*-

(require 'quelpa)

;; (quelpa '(websocket :fetcher github :repo "ahyatt/emacs-websocket"))

;; code
(quelpa '(eglot        :fetcher github :repo "joaotavora/eglot"))
;; (quelpa '(lsp-mode     :fetcher github :repo "emacs-lsp/lsp-mode" :files (:defaults "clients/*.el")))
(quelpa '(rustic       :fetcher github :repo "brotzeit/rustic"))
(quelpa '(gnuplot      :fetcher github :repo "emacsorphanage/gnuplot"))
(quelpa '(ess          :fetcher github :repo "emacs-ess/ESS"))
(quelpa '(haskell-mode :fetcher github :repo "haskell/haskell-mode"))
(quelpa '(lua-mode     :fetcher github :repo "immerrr/lua-mode" :files (:defaults (:exclude "init-tryout.el"))))
(quelpa '(pyvenv       :fetcher github :repo "jorgenschaefer/pyvenv"))
(quelpa '(pytest       :fetcher github :repo "ionrock/pytest-el"))
(quelpa '(ein          :fetcher github :repo "millejoh/emacs-ipython-notebook" :files ("lisp/*" (:exclude "lisp/zeroein.el"))))
(quelpa '(realgud :fetcher github :repo "realgud/realgud"
          :files ("realgud.el" "realgud/.nosearch" "realgud-recursive-autoloads.el"
                  ("realgud/common"             "realgud/common/*.el")
                  ("realgud/common/buffer"      "realgud/common/buffer/*.el")
                  ("realgud/debugger/bashdb"    "realgud/debugger/bashdb/*.el")
                  ("realgud/debugger/gdb"       "realgud/debugger/gdb/*.el")
                  ("realgud/debugger/gub"       "realgud/debugger/gub/*.el")
                  ("realgud/debugger/ipdb"      "realgud/debugger/ipdb/*.el")
                  ("realgud/debugger/jdb"       "realgud/debugger/jdb/*.el")
                  ("realgud/debugger/kshdb"     "realgud/debugger/kshdb/*.el")
                  ("realgud/debugger/nodejs"    "realgud/debugger/nodejs/*.el")
                  ("realgud/debugger/pdb"       "realgud/debugger/pdb/*.el")
                  ("realgud/debugger/perldb"    "realgud/debugger/perldb/*.el")
                  ("realgud/debugger/rdebug"    "realgud/debugger/rdebug/*.el")
                  ("realgud/debugger/remake"    "realgud/debugger/remake/*.el")
                  ("realgud/debugger/trepan"    "realgud/debugger/trepan/*.el")
                  ("realgud/debugger/trepan.pl" "realgud/debugger/trepan.pl/*.el")
                  ("realgud/debugger/trepan2"   "realgud/debugger/trepan2/*.el")
                  ("realgud/debugger/trepan3k"  "realgud/debugger/trepan3k/*.el")
                  ("realgud/debugger/trepanjs"  "realgud/debugger/trepanjs/*.el")
                  ("realgud/debugger/zshdb"     "realgud/debugger/zshdb/*.el")
                  ("realgud/lang" "realgud/lang/*.el"))))
(quelpa '(bug :fetcher github :repo "bwachter/bug-mode"
          :files ("bug.el" "lisp/*.el")))
(quelpa '(slime :fetcher github :repo "slime/slime"
          :files ("*.el" ("lib" "lib/hyperspec.el") "swank" "*.lisp" "*.asd"
                  ("contrib" "contrib/*") (:exclude "contrib/test" "contrib/Makefile")
                  "doc/slime.texi" "doc/slime.info" "doc/dir" "ChangeLog")))
;; (setq tsc-dyn-get-from '(:compilation))
;; (quelpa '(tree-sitter :fetcher github :repo "emacs-tree-sitter/elisp-tree-sitter"
;;           :branch "release"
;;           :files ("lisp/*.el" (:exclude "lisp/tree-sitter-tests.el"))))
;; (quelpa '(tree-sitter-langs :fetcher github :repo "emacs-tree-sitter/tree-sitter-langs"
;;           :branch "release"
;;           :files (:defaults "queries")))

;; editing
(quelpa '(avy                     :fetcher github :repo "abo-abo/avy"))
(quelpa '(avy-menu                :fetcher github :repo "mrkkrp/avy-menu"))
(quelpa '(rainbow-delimiters      :fetcher github :repo "Fanael/rainbow-delimiters"))
(quelpa '(hideshowvis             :fetcher github :repo "sheijk/hideshowvis"))
(quelpa '(ligature                :fetcher github :repo "mickeynp/ligature.el"))
(quelpa '(company                 :fetcher github :repo "company-mode/company-mode" :files (:defaults "icons")))
(quelpa '(company-quickhelp       :fetcher github :repo "company-mode/company-quickhelp"))
(quelpa '(codeium                 :fetcher github :repo "Exafunction/codeium.el"))
(quelpa '(aggressive-indent       :fetcher github :repo "Malabarba/aggressive-indent-mode"))
;; (quelpa '(smart-tab               :fetcher git    :url "https://git.genehack.net/genehack/smart-tab.git"))
(quelpa '(highlight-indent-guides :fetcher github :repo "DarthFennec/highlight-indent-guides"))
;; (quelpa '(smartparens             :fetcher github :repo "Fuco1/smartparens"))
(quelpa '(fic-mode                :fetcher github :repo "lewang/fic-mode"))
;; (quelpa '(beacon                  :fetcher github :repo "Malabarba/beacon"))
(quelpa '(beacon                  :fetcher github :repo "chep/beacon"))
(quelpa '(rainbow-mode            :fetcher git    :url "https://git.savannah.gnu.org/git/emacs/elpa.git"
                                  :branch "externals/rainbow-mode"))
(quelpa '(nyan-mode               :fetcher github :repo "TeMPOraL/nyan-mode"))

;; flycheck
(quelpa '(flycheck              :fetcher github :repo "flycheck/flycheck"))
(quelpa '(flycheck-vale         :fetcher github :repo "abingham/flycheck-vale"))
(quelpa '(flycheck-languagetool :fetcher github :repo "emacs-languagetool/flycheck-languagetool"))
(quelpa '(flyspell-correct      :fetcher github :repo "d12frosted/flyspell-correct"))

;; prose
(quelpa '(auctex                :fetcher git :url "https://git.savannah.gnu.org/git/emacs/elpa.git"
          :branch "externals/auctex" :files ("*.el" "*.info" "tests" "style" "latex")))
(quelpa '(langtool-ignore-fonts :fetcher github :repo "cjl8zf/langtool-ignore-fonts"))
(quelpa '(writeroom-mode        :fetcher github :repo "joostkremers/writeroom-mode"))
(quelpa '(powerthesaurus        :fetcher github :repo "SavchenkoValeriy/emacs-powerthesaurus"))
(quelpa '(writegood-mode        :fetcher github :repo "bnbeckwith/writegood-mode"))
(quelpa '(math-symbols          :fetcher github :repo "kawabata/math-symbols"))
(quelpa '(unicode-math-input    :fetcher github :repo "astoff/unicode-math-input.el"))
(quelpa '(math-delimiters       :fetcher github :repo "oantolin/math-delimiters"))
(quelpa '(biblio                :fetcher github :repo "cpitclaudel/biblio.el"))
(quelpa '(bibtex-completion     :fetcher github :repo "tmalsburg/helm-bibtex" :files ("bibtex-completion.el")))
(quelpa '(valign                :fetcher github :repo "casouri/valign"
                                :files ("*" (:exclude "*.png" "Makefile" "test.org"))))
(quelpa '(lexic                 :fetcher github :repo "tecosaur/lexic"))

(quelpa '(markdown-mode :fetcher github :repo "jrblevin/markdown-mode"))
(quelpa '(mediawiki     :fetcher github :repo "hexmode/mediawiki-el"))
(quelpa '(fountain-mode :fetcher github :repo "rnkn/fountain-mode"))

;; org mode
(quelpa '(org-contrib  :fetcher git    :url "https://git.sr.ht/~bzg/org-contrib" :files ("lisp/*")))
(quelpa '(org-mime     :fetcher github :repo "org-mime/org-mime"))
(quelpa '(org-download :fetcher github :repo "abo-abo/org-download"))
(quelpa '(org-fragtog  :fetcher github :repo "io12/org-fragtog"))
(quelpa '(ox-hugo      :fetcher github :repo "kaushalmodi/ox-hugo"))
(quelpa '(org-bullets  :fetcher github :repo "integral-dw/org-bullets"))
(quelpa '(org-appear   :fetcher github :repo "awth13/org-appear"))
(quelpa '(cdlatex      :fetcher github :repo "cdominik/cdlatex"))
(quelpa '(el-easydraw  :fetcher github :repo "misohena/el-easydraw"))
(quelpa '(org-upcoming-modeline :fetcher github :repo "unhammer/org-upcoming-modeline"))
;; (quelpa '(nano-agenda :fetcher github :repo "rougier/nano-agenda"))

(quelpa '(emacs-calfw :fetcher github :repo "kiwanami/emacs-calfw"))

(quelpa '(geiser-chicken :fetcher gitlab :repo "emacs-geiser/chicken"))

(quelpa '(geiser-chicken :fetcher gitlab :repo "emacs-geiser/chicken"))

;; helpful utilities
(quelpa '(vterm                    :fetcher github :repo "akermu/emacs-libvterm"
          :files ("*" (:exclude ".dir-locals.el" ".gitignore" ".clang-format" ".travis.yml"))))
(quelpa '(pdf-tools                :fetcher github :repo "vedang/pdf-tools"
                                   :files ("lisp/*.el" "README" ("build" "Makefile") ("build" "server")
                                           (:exclude "lisp/tablist.el" "lisp/tablist-filter.el"))))
;; (quelpa '(scroll-other-window :fetcher url
;; :url "https://gist.githubusercontent.com/politza/3f46785742e6e12ba0d1a849f853d0b9/raw/1f9d002130054354c608aa2c72503add25836b9d/scroll-other-window.el"))
(quelpa '(dired-rsync              :fetcher github :repo "stsquad/dired-rsync"))
(quelpa '(dired-du                 :fetcher github :repo "calancha/dired-du"))
(quelpa '(eshell-vterm             :fetcher github :repo "iostapyshyn/eshell-vterm"))
(quelpa '(native-complete :fetcher github :repo "CeleritasCelery/emacs-native-shell-complete" :files ("native-complete.el")))
(quelpa '(nov                      :fetcher git    :url "https://depp.brause.cc/nov.el.git"))
(quelpa '(which-key                :fetcher github :repo "justbur/emacs-which-key"))
(quelpa '(persistent-scratch       :fetcher github :repo "Fanael/persistent-scratch"))
(quelpa '(all-the-icons            :fetcher github :repo "domtronn/all-the-icons.el"))
;; (quelpa '(all-the-icons-dired      :fetcher github :repo "wyuenho/all-the-icons-dired"))
(quelpa '(all-the-icons-ibuffer    :fetcher github :repo "seagle0128/all-the-icons-ibuffer"))
(quelpa '(all-the-icons-completion :fetcher github :repo "iyefrat/all-the-icons-completion"))
(quelpa '(dirvish :fetcher github :repo "alexluigit/dirvish"
                  :files (:defaults "extensions/*.el")))
(quelpa '(dired-du :fetcher github :repo "calancha/dired-du" :files ("dired-du.el")))
;; (quelpa '(diredfl :fetcher github :repo "purcell/diredfl"))
;; (quelpa '(good-scroll              :fetcher github :repo "io12/good-scroll.el"))
(quelpa '(iscroll                  :fetcher github :repo "casouri/iscroll"))
;; (quelpa '(sublimity                :fetcher github :repo "zk-phi/sublimity"))
(quelpa '(yascroll                 :fetcher github :repo "emacsorphanage/yascroll"))
(quelpa '(texfrag                  :fetcher github :repo "TobiasZawada/texfrag"))
(quelpa '(bash-completion          :fetcher github :repo "szermatt/emacs-bash-completion"))

;; network
(quelpa '(magit :fetcher github :repo "magit/magit"
                :files ("lisp/magit" "lisp/magit*.el" "lisp/git-rebase.el" "docs/magit.texi"
                        (:exclude "lisp/magit-libgit.el" "lisp/magit-libgit-pkg.el"
                                  "lisp/magit-section.el" "lisp/magit-section-pkg.el"
                                  "Documentation/magit.texi" "Documentation/AUTHORS.md"))))
(quelpa '(forge :fetcher github :repo "magit/forge" :files ("lisp/*.el" "docs/forge.texi")))
;; (quelpa '(github-review :repo "charignon/github-review" :fetcher github))
(quelpa '(code-review :fetcher github :repo "wandersoncferreira/code-review"))
(quelpa '(ytdious         :fetcher github :repo "spiderbit/ytdious"))
(quelpa '(elpher          :fetcher git    :url "https://thelambdalab.xyz/git/elpher.git"))
;; (quelpa '(empv            :fetcher github :repo "isamert/empv.el"))
(quelpa '(plz             :fetcher github :repo "alphapapa/plz.el" :branch "wip/queue"))
(quelpa '(taxy            :fetcher github :repo "alphapapa/taxy.el"))
;; (quelpa '(taxy-magit-section :fetcher git :url "https://git.savannah.gnu.org/git/emacs/elpa.git"
;;           :branch "externals/taxy-magit-section" :files ("taxy-magit-section.el"
;;                                                          "taxy-magit-section.info")))
(quelpa '(taxy-magit-section :fetcher github :repo "alphapapa/taxy.el"
                             :branch "package/taxy-magit-section" :files ("taxy-magit-section.el" "taxy-magit-section.info")))
(quelpa '(ement           :fetcher github :repo "alphapapa/ement.el"))
(quelpa '(htmlize         :fetcher github :repo "hniksic/emacs-htmlize"))
(quelpa '(sx              :fetcher github :repo "vermiculus/sx.el"))
(quelpa '(rcirc-menu :fetcher git :url "https://git.savannah.gnu.org/emacs/elpa.git"
                     :branch "externals/rcirc-menu"))
(quelpa '(rcirc-styles :fetcher github :repo "aaron-em/rcirc-styles.el"))
;; (quelpa '(nnreddit        :fetcher github :repo "dickmao/nnreddit"
;;                           :files ("lisp/*.el" "setup.py" "requirements.txt" "nnreddit")))
;; (quelpa '(nnreddit :fetcher file :path "~/projects/nnreddit/"
;; :files ("lisp/*.el" "setup.py" "requirements.txt" "nnreddit")))
(quelpa '(nnreddit :fetcher github :repo " rprospero/nnreddit" :branch "oauth"))
(quelpa '(md4rd :fetcher github :repo "ahungry/md4rd"))
;; (quelpa '(q4 :fetcher github :repo "palikar/q4"
;;              :files ("q4.el")))
(quelpa '(nnhackernews    :fetcher github :repo "dickmao/nnhackernews"))
;; (quelpa '(org-anki :fetcher github :repo "eyeinsky/org-anki" :branch "import-deck"))
;; (quelpa '(org-anki :fetcher github :repo "eyeinsky/org-anki"))
(quelpa '(anki-editor :fetcher github :repo "orgtre/anki-editor"))
(quelpa '(ankiorg :fetcher github :repo "orgtre/ankiorg"))
(quelpa '(sqlite3 :fetcher github :repo "pekingduck/emacs-sqlite3-api"))
(quelpa '(w3m :fetcher github :repo "emacs-w3m/emacs-w3m"
              :files (:defaults "icons" (:exclude "octet.el" "mew-w3m.el" "w3m-xmas.el"))))
(quelpa '(nnshimbun :fetcher github :repo "emacs-w3m/emacs-w3m"
                    :files ("shimbun/*.el" (:exclude "mew-shimbun.el"))))
(quelpa '(transmission :fetcher github :repo "holomorph/transmission"
                       :files ("transmission.el")))
(quelpa '(mastodon :fetcher git :url "https://codeberg.org/martianh/mastodon.el.git"))
(quelpa '(mastodon-alt :fetcher github :repo "rougier/mastodon-alt"))
(quelpa '(znc :fetcher github :repo "sshirokov/ZNC.el"))

(quelpa '(geiser-guile :fetcher gitlab
                       :repo "emacs-geiser/guile"
                       :files (:defaults ("src" "src/*"))))
(quelpa '(geiser-chicken
          :fetcher gitlab
          :repo "emacs-geiser/chicken"
          :files (:defaults ("src" "src/*"))))

(quelpa '(guix :fetcher github :repo "alezost/guix.el" :files ("elisp/*.el" "doc/*.texi"
                                                               ("images" "images/*.svg")
                                                               ("scheme" "scheme/*")
                                                               (:exclude "scheme/Makefile.am"))))

(quelpa '(leetcode :fetcher github :repo "kaiwk/leetcode.el"))

;; Other
;; (quelpa '(bongo  :fetcher github :repo "dbrock/bongo" :files ("*.el" "*.texi" "images" "*.rb")))
;; (quelpa '(volume :fetcher github :repo "dbrock/volume.el"))
(quelpa '(emms :fetcher git :url "https://git.savannah.gnu.org/git/emms.git"
               :files (:defaults (:exclude "doc/fdl.texi" "doc/gpl.texi"))))
(quelpa '(mingus :repo "pft/mingus" :fetcher github))
;; (quelpa '(simple-mpc :fetcher github :repo "jorenvo/simple-mpc"))
(quelpa '(mpdel :fetcher github :repo "mpdel/mpdel"))
(quelpa '(speed-type      :fetcher github :repo "parkouss/speed-type"))
(quelpa '(typit           :fetcher github :repo "mrkkrp/typit" :files (:defaults "dict")))
(quelpa '(spray           :fetcher git    :url "https://git.sr.ht/~iank/spray"))
(quelpa '(centered-window :fetcher github :repo "anler/centered-window-mode"))
(quelpa '(smtpmail-multi  :fetcher github :repo "vapniks/smtpmail-multi"))
(quelpa '(bencoding       :fetcher github :repo "xuchunyang/bencoding.el"))

(quelpa '(mini-modeline :repo "kiennq/emacs-mini-modeline" :fetcher github))

