;; inhibit frame resize to reduce startup time
(setq frame-inhibit-implied-resize t)

(setq inhibit-startup-screen t
  inhibit-startup-message t
  inhibit-startup-area-message t
  inhibit-x-resources t)

;; hide bars
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(tooltip-mode t)
(setq tooltip-use-echo-area t)

;; Fringes
(set-fringe-mode 2)
(setq-default
  fringes-outside-margins t
  fringe-indicator-alist
  (delq (assq 'continuation fringe-indicator-alist) fringe-indicator-alist))

;; Other
(setq default-frame-alist '((width . 80) (height . 36)
                             (left . 0.5) (top . 0)
                             (vertical-scroll-bars . nil)
			                       (internal-border-width . 36)))

;; set initial scratch message
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "* Notes


* Tasks [0/0]


* Other

#+begin_src

#+end_src
")

;; protect scratch buffer
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'all))

;; don't warn about non emergency, useless things
(setq warning-minimum-level :error)

;; disable dialog windows
(setq use-dialog-box nil)

;;(setq package-enable-at-startup nil)