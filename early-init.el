(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-area-message t
      inhibit-x-resources t
      server-client-instructions nil
      use-dialog-box nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(setq-default fringes-outside-margins t
              fringe-indicator-alist (delq (assq 'continuation fringe-indicator-alist) fringe-indicator-alist))

(setq default-frame-alist '((width . 80) (height . 36)
                            (left . 0.5) (top . 0)
                            (vertical-scroll-bars . nil)
			                      (internal-border-width . 36))
      frame-title-format '(("%b - emacs [%m] (")
                           (buffer-file-name "%f")
                           ")")
      icon-title-format frame-title-format)

;; set initial scratch message
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "* Notes


* Tasks [0/0]


* Other

#+begin_src

#+end_src
")

;; protect scratch buffer
;; (with-current-buffer "*scratch*"
;;   (emacs-lock-mode 'all))

;; don't warn about non emergency, useless things
(setq warning-minimum-level :error)

;;(setq package-enable-at-startup nil)