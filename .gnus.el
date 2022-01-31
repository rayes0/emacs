;; -*- eval: (flycheck-mode -1); -*-
(defvar personal-email (plist-get (nth 0 (auth-source-search :host "personal.email")) :user))
(defvar work-email (plist-get (nth 0 (auth-source-search :host "professional.email")) :user))
(setq user-full-name (plist-get (nth 0 (auth-source-search :host "personal.name")) :user))
(setq user-email-address personal-email)

(setq gnus-select-method '(nntp "news.gwene.org"))

(setq smtpmail-send-mail-function 'my/custom-sendmail-smtp-multi
  send-mail-function 'my/custom-sendmail-smtp-multi
  message-send-mail-function 'my/custom-sendmail-smtp-multi)

(setq gnus-secondary-select-methods
  '((nnimap "personal"
      (nnimap-address "localhost")
      (nnimap-server-port 1143)
      (nnimap-record-commands t)
      (nnimap-fetch-partial-articles t)
      (nnimap-stream plain))
     (nnimap "work"
	     (nnimap-address "outlook.office365.com")
	     (nnimap-server-port "imaps")
	     (nnimap-stream ssl))))

(setq gnus-posting-styles
  '(("personal"
      (address personal-email))
     ("work"
       (address work-email))))


(require 'smtpmail-multi)
(setq smtpmail-multi-accounts
  (quote ((work . (work-email "smtp.office365.com" 587 nil starttls nil nil nil))
           (personal . (personal-email "localhost" 1025 nil plain nil nil nil)))))
(setq smtpmail-multi-associations
  (quote ((work work)
           (personal personal))))

(defun my/custom-sendmail-smtp-multi ()
  (let ((account (car (smtpmail-multi-get-accounts))))
    (smtpmail-multi-change account)
    (smtpmail-send-it)))

(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "● ")
  (setq gnus-sum-thread-tree-false-root "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◯ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))

(setq gnus-summary-line-format
  (concat
    "%0{%U%R%z%}"
    "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
    "  "
    "%4{%-20,20f%}"               ;; name
    "  "
    "%3{│%}"
    " "
    "%1{%B%}"
    "%s\n"))

(setq gnus-summary-display-arrow t
  gnus-asynchronous t
  gnus-use-article-prefetch 15
  gnus-fetch-old-headers t
  gnus-use-trees t
  gnus-use-cache nil)

(gnus-demon-add-handler 'gnus-demon-add-rescan 600 nil)

;; theming
(require 'general)

;; group
;; (set-face 'gnus-group-mail-1 ')

;; headers
(set-face 'gnus-header-name 'face-salient)
(set-face 'gnus-header-from 'face-strong)
(set-face 'gnus-header-subject 'face-strong)
(set-face-attribute 'gnus-header-subject nil :weight 'bold :underline t)
(set-face 'gnus-header-content 'face-light)

;; summary buffer
(set-face 'gnus-summary-selected 'face-block)
(set-face 'gnus-summary-normal-ancient 'face-faded)
(set-face 'gnus-summary-normal-read 'face-faded)
(set-face 'gnus-summary-normal-unread 'face-strong)
(set-face 'gnus-summary-cancelled 'face-light)
(set-face-attribute 'gnus-summary-cancelled nil :strike-through t)
