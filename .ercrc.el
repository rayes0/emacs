;; -*- eval: (flycheck-mode -1) -*-

;; general
(setq erc-prompt ">  ")

;; security
(setq erc-system-name ""
  erc-paranoid t
  erc-disable-ctcp-replies t
  erc-part-reason '(lambda (arg) "quit")
  erc-quit-reason '(lambda (arg) "quit"))

;; appearance
(require 'general)
(set-face 'erc-timestamp-face 'face-faded)
(set-face 'erc-notice-face 'face-salient)
(set-face 'erc-current-nick-face 'face-pre)
(set-face 'erc-prompt-face 'face-popout)
(set-face 'erc-error-face 'face-identifier)
(set-face 'erc-direct-msg-face 'face-popout)
(set-face 'erc-nick-msg-face 'face-popout)