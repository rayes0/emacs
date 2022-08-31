;; -*- eval: (flycheck-mode -1) -*-

;; general
(setq erc-prompt "> ")

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
      erc-fill-column 100)

(add-to-list 'erc-modules 'notifications)

;; appearance
(require 'general)
(set-face 'erc-default-face 'default :family "Cantarell")
(set-face 'erc-timestamp-face 'face-faded :family "Cantarell" :height 0.9)
(set-face 'erc-notice-face 'face-salient-yellow :family "Cantarell")
(set-face 'erc-current-nick-face 'face-pre)
(set-face 'erc-prompt-face 'face-faded :weight 'bold)
(set-face 'erc-error-face 'face-identifier)
(set-face 'erc-direct-msg-face 'face-salient)
(set-face 'erc-nick-msg-face 'face-salient-green)

(set-face 'erc-input-face 'face-light :family "Cantarell")
(set-face 'erc-my-nick-face 'face-light :family "Cantarell" :weight 'bold)

(set-face 'erc-action-face 'face-italic-faded)
(set-face 'erc-nick-default-face 'face-identifier :family "Cantarell" :height 1.0)
