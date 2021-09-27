;;; Settings for system interaction

;; tramp
(setq tramp-default-method "ssh")

;; docview
(setq doc-view-resolution 300)
(setq doc-view-continuous t)

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

;; comint
(setq ansi-color-names-vector
  ["#ede6e3" "#ce9c85" "#839773" "#a09c80" "#8f8678" "#9c7b9c" "#75998e" "#685c56"])
(setq ansi-color-map (ansi-color-make-color-map)) 
(with-eval-after-load 'comint
  (setq comint-prompt-read-only t
    comint-input-ignoredups t
    comint-completion-autolist t
    ))

(provide 'init-system)