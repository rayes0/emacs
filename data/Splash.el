;; Splash Screen

(defun show-splash ()
  (get-buffer-create "*splash*")
  (interactive)
  (with-current-buffer "*splash*"
	(erase-buffer)

    (setq cursor-type nil)
    (setq line-spacing 0)
    (setq vertical-scroll-bar nil)
    (setq horizontal-scroll-bar nil)

	(let* ((selected-img (choose-image "~/.emacs.d/data/splash-img")))

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
	(beginning-of-buffer)))

(defun choose-image (img-dir)
  (let* ((files (directory-files img-dir t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)")))
  (elt files (random (length files)))))

(defun init-time ()
  (propertize (format-message "Emacs started in %.3f seconds with %d garbage collections"
							  (float-time (time-subtract after-init-time before-init-time))
							  gcs-done) 'face 'face-faded))

(provide 'Splash)