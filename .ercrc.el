;; -*- eval: (flycheck-mode -1) -*-

(setq erc-prompt (concat (propertize "-" 'display '(space :width (25))
                                     'erc-padding t)
                         "> "))

;; security
(setq erc-system-name ""
      erc-paranoid t
      erc-disable-ctcp-replies t
      erc-part-reason (lambda (_) "quit")
      erc-quit-reason (lambda (_) "quit")
      erc-accidental-paste-threshold-seconds 0.1
      erc-prompt-for-password t
      erc-join-buffer 'buffer
      erc-hide-list '("JOIN" "PART" "QUIT")
      erc-fill-column most-positive-fixnum
      erc-insert-timestamp-function #'erc-insert-timestamp-left
      erc-insert-away-timestamp-function erc-insert-timestamp-function)

;; appearance
(require 'general)
(set-face 'erc-default-face 'default :family "Cantarell")
(set-face 'erc-timestamp-face 'face-faded :height 0.9)
(set-face 'erc-notice-face 'face-salient-yellow :family "Cantarell")
(set-face 'erc-current-nick-face 'face-pre)
(set-face 'erc-prompt-face 'face-faded :weight 'bold)
(set-face 'erc-error-face 'face-identifier)
(set-face 'erc-direct-msg-face 'face-salient)
(set-face 'erc-nick-msg-face 'face-salient-green)

(set-face 'erc-input-face 'face-light :family "Cantarell")
(set-face 'erc-my-nick-face 'face-light :family "Cantarell" :weight 'bold)

(set-face 'erc-action-face 'face-strong :family "Cantarell" :weight 'light)
(set-face 'erc-nick-default-face 'face-identifier :family "Cantarell" :height 1.0)
(set-face 'erc-current-nick-face 'face-salient :family "Cantarell" :weight 'bold)

(add-hook 'erc-mode-hook (lambda ()
                           (setq-local line-spacing 0.25)
                           (company-mode -1)
                           (face-remap-add-relative 'default :family "Cantarell")))


;; custom
(define-erc-module align-nicks nil
  "align nicks"
  ((add-hook 'erc-insert-modify-hook #'rayes/erc-align-nicks)
   (add-hook 'erc-send-modify-hook #'rayes/erc-align-nicks))
  ((remove-hook 'erc-insert-modify-hook #'rayes/erc-align-nicks)
   (remove-hook 'erc-send-modify-hook #'rayes/erc-align-nicks)))

(defun rayes/erc-align-pad-nick (beg end)
  (let ((n (car (window-text-pixel-size nil beg end)))
        (inhibit-read-only t))
    (goto-char end)
    (when (and (looking-at-p ">")
               (number-or-marker-p n))
      (delete-char 1)
      (beginning-of-line)
      (delete-char 1)
      (insert (propertize "-" 'display `(space :width (,(- 100 n)))
                          'erc-padding t))
      (end-of-line))))

(defun rayes/erc-align-nicks ()
  "aligns nicknames in buffer"
  (unless wrap-prefix
    (setq-local wrap-prefix (propertize "-" 'display '(space :width (115))
                                        'erc-padding t)))
  (save-excursion
    (goto-char (point-min))
    (save-match-data
      (while (setq match (text-property-search-forward 'face 'erc-nick-default-face t))
        (rayes/erc-align-pad-nick (prop-match-beginning match)
                                  (prop-match-end match)))))
  ;; (goto-char (point-min))
  ;; (while (setq match (text-property-search-forward 'face '(erc-nick-default-face erc-nick-default-face)))
  ;;   (rayes/erc-align-pad-nick (prop-match-beginning match)
  ;;                             (prop-match-end match)))
  ;; (goto-char (point-min))
  ;; (while (not (eobp))
  ;;   (when (not (save-excursion
  ;;                (beginning-of-line)
  ;;                (get-text-property (point) 'erc-padding)))
  ;;     (let ((n (car (window-text-pixel-size nil
  ;;                                           (save-excursion
  ;;                                             (beginning-of-line)
  ;;                                             (point))
  ;;                                           (save-excursion
  ;;                                             (back-to-indentation)
  ;;                                             (point)))))
  ;;           (inhibit-read-only t))
  ;;       (when (not (eq n 0))
  ;;         (beginning-of-line)
  ;;         (insert (propertize "-"
  ;;                             'display `(space :width (,(- 200 n)))
  ;;                             'erc-padding t)))))
  ;;   (forward-line))
  )

;; (defun bitlbee-discord-list ()
;; ""
;; ())

;; (defun erc-channel-names ()
;;   "Run \"/names #channel\" in the current channel."
;;   (interactive)
;;   (erc-set-active-buffer (current-buffer))
;;   (let ((tgt (erc-default-target)))
;;     (if tgt (erc-load-irc-script-lines (list (concat "/names " tgt)))
;;       (erc-display-message nil 'error (current-buffer) 'no-target))))

(define-erc-module inline-images nil
  "display links to images inline"
  ((add-hook 'erc-insert-modify-hook #'rayes/erc-inline-images)
   (add-hook 'erc-send-modify-hook #'rayes/erc-inline-images))
  ((remove-hook 'erc-insert-modify-hook #'rayes/erc-inline-images)
   (remove-hook 'erc-send-modify-hook #'rayes/erc-inline-images)))

(defvar-local erc-displaying-inline-images nil)

(defun rayes/erc-inline-images ()
  (unless erc-displaying-inline-images
    (save-excursion
      (goto-char (point-min))
      (let ((inhibit-read-only t)
            (buf (current-buffer)))
        (save-match-data
          (while (setq match (text-property-search-forward 'erc-data nil (lambda (_ val)
                                                                           (when val
                                                                             (string-match-p "^https?://.*\\.\\(png\\|jpg\\)"
                                                                                             (car val))))))
            (let ((url (buffer-substring-no-properties (prop-match-beginning match)
                                                       (prop-match-end match))))
              (url-retrieve url
                            #'rayes/erc-inline-images-callback
                            (list match
                                  buf
                                  (string-match-p "^https?://cdn.discordapp.com/emojis/[0-9]*\\.png$" url))
                            t t))))))
    (setq-local erc-displaying-inline-images t)))

(defun rayes/erc-inline-images-callback (_ match buf &optional emoji)
  (let ((img (create-image (buffer-substring (progn
                                               (goto-char url-http-end-of-headers)
                                               (while (looking-at-p "\n")
                                                 (forward-line))
                                               (point))
                                             (point-max))
                           nil t
                           :max-width (if emoji
                                          25
                                        800)
                           :max-height (if emoji
                                           25
                                         200))))
    (let ((inhibit-read-only t))
      (with-current-buffer buf
        ;; (when emoji
        ;; (delete-region (prop-match-beginning match)
        ;; (prop-match-end match)))
        (goto-char (prop-match-end match))
        (end-of-line)
        (insert (if emoji
                    (propertize " " 'erc-image t)
                  (propertize (concat "\n" (or wrap-prefix ""))
                              'erc-image t)))
        (insert-image img)))
    (kill-buffer (current-buffer))))

(defun rayes/erc-clear-images ()
  (save-excursion
    (let ((inhibit-read-only t))
      (goto-char (point-min))
      (save-match-data
        (while (setq match (text-property-search-forward 'display nil (lambda (_ val) (imagep val))))
          (let ((prev (previous-single-property-change (prop-match-beginning match) 'erc-image)))
            (delete-region prev
                           (prop-match-end match)))))))
  (setq-local erc-displaying-inline-images nil))


;; (setq erc-replace-alist '(("IN_REPLY_TO: \\(.*\\)> \\(.*\\)$" . (concat "╭─"
;;                                                                         (propertize (concat "@ " (match-string 1)) 'face 'erc-current-nick-face)
;;                                                                         (match-string 2)))))

(setq erc-replace-alist '(("IN_REPLY_TO: \\(.*\\)> \\(.*\\)$" . (lambda (_)
                                                                  (concat
                                                                   ;; (propertize "-" 'display `(space :width (,(car-safe (debug (window-text-pixel-size (debug (selected-window)) (match-beginning 1) (match-end 1)))))))
                                                                   ;; (match-string 1)
                                                                   (propertize (concat "╭─" (match-string 1)) 'face 'erc-current-nick-face)
                                                                   " "
                                                                   (propertize (match-string 2) 'face 'face-faded))))
                          ("EDIT: " . (lambda (_) (downcase (propertize "(edited) " 'face 'face-faded))))))

;; replace sidebar function
(require 'tree-widget)
(setq erc-status-sidebar-width 20)
(define-key erc-mode-map (kbd "C-c C-s") #'erc-status-sidebar-toggle)
(defun erc-status-sidebar-refresh (&optional redraw)
  (interactive)
  (let ((l))
    (dolist (chanbuf (erc-channel-list nil))
      (setq l (erc-status-sidebar-push-channel l chanbuf)))
    (with-current-buffer
        ;; "test"
        (erc-status-sidebar-get-buffer)
      (let ((inhibit-read-only t))
        (if (and (not redraw)
                 (boundp 'erc-status-sidebar-widgets)
                 erc-status-sidebar-widgets)
            (dolist (w erc-status-sidebar-widgets)
              (erc-status-sidebar-label-update w))
          (make-local-variable 'erc-status-sidebar-widgets)
          (delete-region (point-min) (point-max))
          (remove-overlays)
          (goto-char (point-min))
          (tree-widget-set-theme "folder")
          (setq-local erc-status-sidebar-widgets
                      (cl-loop for server in l
                               collect (widget-create 'tree-widget
                                                      :tag (car server)
                                                      :open t
                                                      :keep '(:open)
                                                      :expander (lambda (tree)
                                                                  (erc-status-sidebar-server-tree tree server)))
                               into widgets
                               finally return widgets))
          (widget-setup))))))

(defun erc-status-sidebar-label-update (widget)
  (let ((children (widget-get widget :args)))
    (if children
        (dolist (child children)
          (erc-status-sidebar-label-update child))
      (widget-put widget :tag (erc-status-sidebar-format (widget-get widget :erc-buf)))
      ;; (widget-browse widget)
      ;; (when (marker-position (widget-get widget :from))
      ;; (widget-value-set widget (widget-value widget)))
      ;; (widget-setup)
      )
    (while (setq parent (widget-get widget :parent))
      (widget-value-set widget (widget-value widget)))))

(defun erc-status-sidebar-push-channel (l chanbuf)
  (with-current-buffer chanbuf
    (save-match-data
      (if (string-match "^#\\(.*\\)\\.\\(.*\\)$" (buffer-name chanbuf))
          (erc-status-sidebar-push-nested l erc-server-announced-name
                                          (list (match-string-no-properties 1 (buffer-name chanbuf))
                                                chanbuf))
        (erc-status-sidebar-push-nested l erc-server-announced-name chanbuf)))))

(defun erc-status-sidebar-push-nested (l cat val)
  (if (and l (assoc cat l))
      (if (listp val)
          (setf (alist-get cat l nil nil #'equal)
                (erc-status-sidebar-push-nested (alist-get cat l nil nil #'equal)
                                                (car val)
                                                (cadr val)))
        (setf (alist-get cat l nil nil #'equal)
              (append (cdr (assoc cat l)) (list val))))
    (push (list cat val) l))
  l)

(defun erc-status-sidebar-server-tree (parent server &optional sort)
  (cl-loop for chanbuf in (if sort
                              (apply erc-status-sidebar-channel-sort (cdr server) nil)
                            (cdr server))
           collect (if (listp chanbuf)
                       (widget-convert 'tree-widget
                                       :tag (car chanbuf)
                                       :open t
                                       :channels chanbuf
                                       :keep '(:open :channels)
                                       :expander (lambda (tree) (erc-status-sidebar-server-tree tree (widget-get tree :channels) t))
                                       :expander-p (lambda (&rest _) t))
                     (widget-convert 'item :tag (erc-status-sidebar-format chanbuf)
                                     :erc-buf chanbuf
                                     :keep '(:erc-buf)))
           into children
           finally return children))

(defun erc-status-sidebar-format (chanbuf)
  (save-match-data
    (let* ((tup (seq-find (lambda (tup) (eq (car tup) chanbuf))
                          erc-modified-channels-alist))
           (count (if tup (cadr tup)))
           (face (if tup (cddr tup)))
           (channame (apply erc-status-sidebar-channel-format
                            (buffer-name chanbuf) count face nil)))
      (propertize (if (string-match "^#.*\\.\\(.*\\)$" channame)
                      (concat "#" (match-string 1 channame))
                    channame)
                  'erc-buf chanbuf
                  'mouse-face 'highlight
                  'help-echo channame))))


(with-eval-after-load 'erc-status-sidebar
  (defun erc-status-sidebar-refresh ()
    "Update the content of the sidebar."
    (interactive)
    (let ((chanlist (apply erc-status-sidebar-channel-sort
                           (erc-channel-list nil) nil)))
      (with-current-buffer (erc-status-sidebar-get-buffer)
        (erc-status-sidebar-writable
         (delete-region (point-min) (point-max))
         (goto-char (point-min))
         (dolist (chanbuf chanlist)
           (let* ((tup (seq-find (lambda (tup) (eq (car tup) chanbuf))
                                 erc-modified-channels-alist))
                  (count (if tup (cadr tup)))
                  (face (if tup (cddr tup)))
                  (channame (apply erc-status-sidebar-channel-format
                                   (buffer-name chanbuf) count face nil))
                  (cnlen (length channame)))
             (put-text-property 0 cnlen 'erc-buf chanbuf channame)
             (put-text-property 0 cnlen 'mouse-face 'highlight channame)
             (put-text-property 0 cnlen 'help-echo channame channame)
             (insert channame "\n"))))))))

(add-hook 'erc-status-sidebar-mode-hook #'my/sans-serif-font)

(setq erc-modules '(completion
                    button
                    irccontrols
                    match
                    menu
                    netsplit
                    noncommands
                    readonly
                    smiley
                    spelling
                    stamp
                    track
                    ;; fill
                    networks
                    ring
                    autojoin
                    move-to-prompt
                    list
                    notifications
                    replace
                    netsplit
                    ;; align-nicks
                    ;; inline-images
                    ))
(erc-update-modules)
