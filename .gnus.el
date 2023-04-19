;; -*- eval: (flycheck-mode -1); -*-
(require 'auth-source)
(defvar personal-email (plist-get (nth 0 (auth-source-search :host "personal.email")) :user))
(defvar work-email (plist-get (nth 0 (auth-source-search :host "professional.email")) :user))
(defvar full-name (plist-get (nth 0 (auth-source-search :host "personal.name")) :user))
;; (setq user-full-name (plist-get (nth 0 (auth-source-search :host "personal.name")) :user))
;; (setq user-mail-address personal-email)
(setq user-full-name ""
      user-mail-address "")

(setq message-confirm-send t
      gnus-user-agent "gnus"
      canlock-password (funcall (plist-get (nth 0 (auth-source-search :host "canlock.pass")) :secret)))

(setq gnus-select-method '(nnnil "")
      gnus-secondary-select-methods '(
                                      ;; (nnreddit "")
                                      (nnhackernews "")
                                      ;; (nnimap "personal"
                                      ;;         (nnimap-address "localhost")
                                      ;;         (nnimap-server-port 1143)
                                      ;;         (nnimap-record-commands t)
                                      ;;         (nnimap-fetch-partial-articles t)
                                      ;;         (nnimap-stream plain))
                                      ;; (nnimap "work"
	                                    ;;         (nnimap-address "outlook.office365.com")
	                                    ;;         (nnimap-server-port "imaps")
	                                    ;;         (nnimap-stream ssl))
                                      ;; (nntp "kernel"
                                      ;;       (nntp-address "nntp.lore.kernel.org")
                                      ;;       (nntp-open-connection-function nntp-open-tls-stream))
                                      (nntp "gwene"
                                            (nntp-address "news.gwene.org")
                                            ;; (nntp-port-number 119)
                                            ;; (nntp-port-number 563)
                                            (nntp-open-connection-function nntp-open-network-stream))
                                      (nntp "gmane"
                                            (nntp-address "news.gmane.io")
                                            ;; (nntp-port-number 119)
                                            ;; (nntp-port-number 563)
                                            (nntp-open-connection-function nntp-open-network-stream))
                                      (nntp "eternal-sep"
                                            (nntp-address "news.eternal-september.org")
                                            (nntp-port-number 563)
                                            (nntp-open-connection-function nntp-open-tls-stream))
                                      ;; (nnchan "")
                                      )
      gnus-posting-styles '(((message-mail-p)
                             (name full-name))
                            ;; ("personal"
                            ;;  (address personal-email))
                            ;; ("work"
                            ;;  (address work-email))
                            ((message-news-p)
                             (name "bunny")
                             (address "bunny@rabbit.invalid"))))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq smtpmail-send-mail-function 'my/custom-sendmail-smtp-multi
      send-mail-function 'my/custom-sendmail-smtp-multi
      message-send-mail-function 'my/custom-sendmail-smtp-multi)

(require 'smtpmail-multi)
(setq smtpmail-multi-accounts
      `((work . (,work-email "smtp.office365.com" 587 nil starttls nil nil ""))
        (personal . (,personal-email "localhost" 1025 nil plain nil nil "")))
      smtpmail-multi-associations `((,work-email work)
                                    (,personal-email personal)))

(defun my/custom-sendmail-smtp-multi ()
  (when-let ((account (car (smtpmail-multi-get-accounts))))
    (smtpmail-multi-change account)
    (smtpmail-send-it)))

(setq gnus-message-archive-group '((if (message-news-p)
                                       "sent.news"
                                     "sent.mail"))
      gnus-sum-thread-tree-indent "  "
      gnus-sum-thread-tree-root "● "
      gnus-sum-thread-tree-false-root "◯ "
      gnus-sum-thread-tree-single-indent "◯ "
      gnus-sum-thread-tree-vertical        "│"
      gnus-sum-thread-tree-leaf-with-other "├─ "
      gnus-sum-thread-tree-single-leaf     "└─ "
      gnus-use-trees nil
      gnus-thread-indent-level 1
      gnus-activate-level 6
      gnus-save-newsrc-file nil
      gnus-read-newsrc-file nil
      gnus-check-new-newsgroups 'ask-server
      gnus-check-bogus-newsgroups nil
      gnus-refer-article-method 'current
      gnus-registry-split-strategy 'first
      gnus-registry-ignored-groups '(("delayed$" t) ("drafts$" t) ("queue$" t) ("INBOX$" t)
                                     ("^nnmairix:" t) ("^nnselect:" t) ("archive" t) ("nntp" t)
                                     ("nnrss" t) ("spam" t))
      gnus-registry-max-entries 30000
      gnus-registry-track-extra '(sender subject)
      ;; gnus-thread-use-search t
      gnus-summary-line-format "%0{%U%R%z%} %3{│%}%*%1{%&user-date;%}%3{│%}  %4{%-20,20f%}  %3{│%}  %1{%B%}%s\n"
      ;; gnus-user-date-format-alist '(((gnus-seconds-today) . "Today %H:%M")
      ;;                               ;; ((+ 86400 (gnus-seconds-today)) . "Yesterday %H:%M")
      ;;                               (604800 . "%a %H:%M")
      ;;                               ;; ((gnus-seconds-month) . "%b %d")
      ;;                               ((gnus-seconds-year) . "%b %d")
      ;;                               (t . "%b %d %Y"))
      gnus-user-date-format-alist '((t . "%D"))
      gnus-article-date-headers '(combined-local-lapsed)
      gnus-group-uncollapsed-levels 1
      ;; gnus-group-line-format "%M%S%p%P%~(pad-left 2)y%*│%B%(%c%)\n"
      gnus-group-line-format "%M%B%P%~(pad-left 2)y%*│%B%(%c%)\n"
      gnus-topic-line-format "%i%([%{ %n ] %~(ignore 0)A%}%v%)\n"
      gnus-topic-indent-level 1
      gnus-summary-display-arrow t
      ;; gnus-summary-gather-subject-limit 'fuzzy
      ;; gnus-simplify-subject-fuzzy-regexp "Re: "
      gnus-simplify-subject-functions '(gnus-simplify-subject-re
                                        gnus-simplify-subject-fuzzy
                                        gnus-simplify-whitespace)
      gnus-summary-display-while-building nil
      gnus-asynchronous t
      gnus-use-article-prefetch 15
      ;; gnus-fetch-old-headers 'some
      gnus-fetch-old-headers nil
      gnus-fetch-old-ephemeral-headers nil
      gnus-build-sparse-threads nil
      ;; gnus-read-all-available-headers t
      gnus-use-cache 'passive
      gnus-group-use-permanent-levels t
      gnus-treat-display-smileys nil
      gnus-treat-display-x-face 'head
      gnus-large-newsgroup 50
      gnus-large-ephemeral-newsgroup 50
      gnus-completing-read-function #'gnus-ido-completing-read)

(add-hook 'gnus-summary-exit-hook #'gnus-summary-bubble-group)

;; (setq nnrss-use-local t)

(when (featurep 'dbusbind)
  (setq gnus-dbus-close-on-sleep t))

(add-hook 'message-mode 'flyspell-mode)

(setq gnus-global-groups (gnus-groups-from-server "nnreddit:"))

(gnus-add-configuration '(article (horizontal 1.0
                                              (group 38)
                                              (vertical 1.0
                                                        (summary 8 point)
                                                        (article 1.0)))))

(gnus-add-configuration '(summary (horizontal 1.0
                                              (group 38)
                                              (summary 1.0 point))))

;; rss
(with-eval-after-load 'nnrss
  (add-to-list 'gnus-parameters
               '("^nnrss"
                 (gnus-summary-line-format "%U%R%z% │ %d │ %*%s\n")
                 (gnus-show-threads nil))))
(add-to-list 'gnus-parameters
             '("^news.gwene.org"
               (gnus-summary-line-format "%U%R%z% │ %d │ %*%s\n")
               (gnus-show-threads nil)))

(add-to-list 'gnus-parameters
             '("^nnreddit"
               (gnus-summary-line-format "%R%uS%i% │ %d │ %*%s\n")))

(defun gnus-user-format-function-S (header)
  ;; (debug header)
  (alist-get 'X-Reddit-Score (mail-header-extra header)))

;; (defun nnreddit-sort-by-reddit-score (t1 t2)
;;   (> (string-to-number
;;       (alist-get 'X-Reddit-Score (mail-header-extra (gnus-thread-header t1))))
;;      (string-to-number
;;       (alist-get 'X-Reddit-Score (mail-header-extra (gnus-thread-header t2))))))

(defun gnus-browse-first-url ()
  (interactive)
  (save-excursion
    (set-buffer gnus-article-buffer)
    (goto-char (point-min))
    (re-search-forward gnus-button-url-regexp)
    (let ((string (match-string-no-properties 0)))
      (cond ((or (string-match-p ".*/i.redd.it/.*" string)
                 (string-match-p ".*\\.jpg" string)
                 (string-match-p ".*\\.png" string))
             (call-process "/home/rayes/bin/link-open" nil 0 nil "feh" string))
            ((string-match-p ".*/v.redd.it/.*" string)
             (call-process "/home/rayes/bin/link-open" nil 0 nil "mpv" string))
            (t (browse-url string))))))
(define-key gnus-summary-mode-map (kbd "v o") #'gnus-browse-first-url)

(setq nnreddit-render-submission nil
      nnhackernews-render-story nil)

;; (require 'gnus-registry)
;; (add-hook 'gnus-startup-hook #'gnus-registry-load)
;; (add-hook 'gnus-save-newsrc-hook #'gnus-registry-save)

(defun browse-gnus-url (arg)
  (interactive "p")
  (let ((url (cond ((eq (car (gnus-find-method-for-group gnus-newsgroup-name)) 'nnrss)
                    (cdr (assq nnrss-url-field
                               (mail-header-extra
                                (gnus-data-header
                                 (assq (gnus-summary-article-number)
                                       gnus-newsgroup-data))))))
                   ((eq (car (gnus-find-method-for-group gnus-newsgroup-name)) 'nnreddit)
                    (concat "https://www.reddit.com"
                            (alist-get 'X-Reddit-Permalink
                                       (mail-header-extra
                                        (gnus-data-header
                                         (assq (gnus-summary-article-number)
                                               gnus-newsgroup-data))))))
                   ((eq (car (gnus-find-method-for-group gnus-newsgroup-name)) 'nnhackernews)
                    (alist-get 'X-Hackernews-Permalink (mail-header-extra
                                                        (gnus-data-header
                                                         (assq (gnus-summary-article-number)
                                                               gnus-newsgroup-data))))))))
    (if (not url)
        (message "no url")
      (browse-url url)
      (gnus-summary-mark-as-read-forward 1))))
(define-key gnus-summary-mode-map (kbd "v b") #'browse-gnus-url)
;; (add-to-list 'nnmail-extra-headers nnrss-url-field)


;; theming
(require 'general)

;; groups
(set-face 'gnus-group-mail-1 'face-block)
(set-face 'gnus-group-mail-1-empty 'face-faded)
(set-face 'gnus-group-mail-2 'face-identifier)
(set-face 'gnus-group-mail-2-empty 'face-faded)
(set-face 'gnus-group-mail-3 'face-strong)
(set-face 'gnus-group-mail-3-empty 'face-faded)
(set-face 'gnus-group-mail-low 'face-light)
(set-face 'gnus-group-mail-low-empty 'face-faded)

(set-face 'gnus-group-news-5-empty 'face-faded)
(set-face 'gnus-group-news-low-empty 'face-faded)

;; summary
(set-face 'gnus-summary-selected 'face-block)
(set-face 'gnus-summary-normal-ancient 'face-faded)
(set-face 'gnus-summary-normal-read 'face-faded)
(set-face 'gnus-summary-normal-unread 'face-strong)
(set-face 'gnus-summary-cancelled 'face-light :strike-through t)
(set-face 'gnus-summary-normal-ticked 'face-popout)

;; headers
(set-face-attribute 'gnus-header nil :inherit 'variable-pitch-text)
(set-face 'gnus-header-name '(message-header-name variable-pitch-text)
          :background (face-background 'face-block)
          :height 0.9
          :weight 'semibold
          :box `(:color ,(face-background 'face-block) :line-width (7 . -3)))
(set-face 'gnus-header-from 'face-strong)
(set-face 'gnus-header-subject 'message-header-subject)
(set-face 'gnus-header-content '(face-light variable-pitch-text))
(set-face 'gnus-header-from '(face-strong variable-pitch-text))
(set-face 'gnus-header-newsgroups 'face-salient-yellow
          :family "Cascadia Code"
          :slant 'normal)

;; article
(with-eval-after-load 'gnus-cite
  (set-face-attribute 'gnus-cite-1 nil
                      :foreground 'unspecified
                      :inherit 'face-faded)
  (set-face-attribute 'gnus-cite-2 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-yellow)
  (set-face-attribute 'gnus-cite-3 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-green)
  (set-face-attribute 'gnus-cite-3 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-cyan)
  (set-face-attribute 'gnus-cite-4 nil
                      :foreground 'unspecified
                      :inherit 'face-faded)
  (set-face-attribute 'gnus-cite-5 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-yellow)
  (set-face-attribute 'gnus-cite-6 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-green)
  (set-face-attribute 'gnus-cite-7 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-cyan)
  (set-face-attribute 'gnus-cite-8 nil
                      :foreground 'unspecified
                      :inherit 'face-faded)
  (set-face-attribute 'gnus-cite-9 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-yellow)
  (set-face-attribute 'gnus-cite-10 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-green)
  (set-face-attribute 'gnus-cite-11 nil
                      :foreground 'unspecified
                      :inherit 'face-salient-cyan))

;; server
(with-eval-after-load 'gnus-srvr
  (set-face 'gnus-server-opened 'face-salient-yellow)
  (set-face 'gnus-server-denied 'face-critical))

;; fonts
;; (defun gnus/set-buffer-font-remap ()
;; (face-remap-add-relative 'default
;; :family "Go Mono"))

;; (add-hook 'gnus-group-mode-hook #'gnus/set-buffer-font-remap)
(add-hook 'gnus-article-mode-hook (lambda ()
                                    (cond ((or (eq (car (gnus-find-method-for-group gnus-newsgroup-name)) 'nnreddit)
                                               (eq (car (gnus-find-method-for-group gnus-newsgroup-name)) 'nnhackernews))
                                           (face-remap-add-relative 'gnus-cite-1 :family "ETBembo"))
                                          (t (face-remap-add-relative 'default
                                                                      :family "Go Mono"))
                                          )))

(autoload 'gnus-group-make-shimbun-group "nnshimbun" nil t)
