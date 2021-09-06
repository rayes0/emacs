;;; Settings for system interaction

;; tramp
(setq tramp-default-method "ssh")

;; docview
(setq doc-view-resolution 300)

;; eshell
(with-eval-after-load 'eshell
  (setq eshell-prompt-function
    (lambda nil
      (concat
        (propertize "> [eshell] " 'face 'face-salient)
        (propertize (eshell/pwd) 'face '(:inherit face-faded :weight 'bold))
        (propertize " $" 'face '(:inherit 'face-faded :weight 'bold))
        (propertize "  " 'face nil))))
  (with-eval-after-load 'em-ls
    ;;(set-face 'eshell-ls-backup 'default)
    ;;(set-face 'eshell-ls-symlink 'default)
    ;;(set-face 'eshell-ls-clutter 'default)
    ;;(set-face 'eshell-ls-missing 'default)
    ;;(set-face 'eshell-ls-archive 'default)
    ;;(set-face 'eshell-ls-product 'default)
    ;;(set-face 'eshell-ls-special 'default)
    ;;(set-face 'eshell-ls-readonly 'default)
    ;;(set-face 'eshell-ls-unreadable 'default)

    (set-face 'eshell-ls-directory 'default)
    (set-face-attribute 'eshell-ls-directory nil :weight 'bold)
    (set-face 'eshell-ls-executable 'face-salient)
    (set-face-attribute 'eshell-ls-executable nil :weight 'normal)
    )
  )

(provide 'init-system)