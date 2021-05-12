;; inhibit frame resize to reduce startup time
(setq frame-inhibit-implied-resize t)

;; inhibit splash screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-area-message t)

;; set inital scratch message
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message "")

(setq inhibit-x-resources t)

;; hide bars
(menu-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode  0)
(scroll-bar-mode 0)

;; Fringes
(set-fringe-mode 2)

;; Other
(setq default-frame-alist '((width . 112) (height . 36)
             (vertical-scroll-bars . nil)
			 (internal-border-width . 24)))

;; disable dialog windows
(setq use-dialog-box nil)