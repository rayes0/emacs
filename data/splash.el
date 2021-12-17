;; Splash Screen
;; based on https://github.com/rougier/emacs-splash/blob/master/splash-screen.el

(defun show-splash ()
  "Show the splash screen"
  (interactive)
  (let* ((splash-buffer (get-buffer-create "*splash*")))
    (if (eq 0 (length (cl-loop for buf in (buffer-list)
                        if (buffer-file-name buf)
                        collect (buffer-file-name buf))))
      (with-current-buffer splash-buffer
        (erase-buffer)

        (setq cursor-type nil)
        (setq line-spacing 0)
        (setq vertical-scroll-bar nil)
        (setq horizontal-scroll-bar nil)


        (let* ((selected-img (choose-image (expand-file-name "./data/splash-img" user-emacs-directory))))

          ;; top padding
          (insert-char ?\n 5)

          ;; center image horizontally with spaces
          (insert (propertize " " 'display
                    `(space :align-to (+ center (-0.5 . ,(create-image selected-img))))))
          (insert-image (create-image selected-img)))
        (insert-char ?\n 3)

        (let* ((splash-text (init-time)))
          (insert (propertize " " 'display
                    `(space :align-to (+ center (-0.5 . ,(length splash-text))))))
          (insert splash-text))
        (insert "\n")

        ;;set read only mode
        (read-only-mode t)

        ;; jump to beginning of buffer
        (beginning-of-buffer)

        ;; keys
        (local-set-key (kbd "q") 'kill-splash)
        (local-set-key (kbd "<escape>") 'kill-splash)
        (local-set-key (kbd "C-[") 'kill-splash)
        (local-set-key (kbd "k") 'kill-splash)
        (local-set-key (kbd "a") 'org-agenda)

        (display-buffer-same-window splash-buffer nil)))))

(defun kill-splash ()
  "Kill the splash screen"
  (interactive)
  (if (get-buffer "*splash*")
    (kill-buffer "*splash*")))

(defun choose-image (img-dir)
  (let* ((files (directory-files img-dir t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)")))
    (elt files (random (length files)))))

(defun init-time ()
  (propertize (format-message "Emacs started in %.3f seconds with %d garbage collections"
                (float-time (time-subtract after-init-time before-init-time))
                gcs-done) 'face 'face-faded))

(provide 'splash)
