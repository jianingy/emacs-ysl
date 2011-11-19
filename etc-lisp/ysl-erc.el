;; ERC 频道编码设置 From http://darksair.org/wiki/erc.html
(setq erc-encoding-coding-alist '(("#linuxfire" . chinese-iso-8bit)))
(require 'erc)
(require 'erc-ring)
(require 'erc-services)
(require 'erc-fill)
(require 'erc-autoaway)
(require 'erc-log)
;; (require 'ssl)

(erc-netsplit-mode nil)                 ; I don't need this.
(erc-ring-enable)
(erc-log-enable)

(setq erc-nick "jianingy")
(setq erc-away-nickname "jianingy{away}")
(setq erc-user-full-name "Jianing Yang")

;; Auto un-away
(setq erc-auto-discard-away t)
;; Spell check disabled
(erc-spelling-mode 0)
;; Do not make nicks as buttons
(setq erc-button-buttonize-nicks nil)

;; Don't track server buffer
(setq erc-track-exclude-server-buffer t)
;; Don't track join/quit
(setq erc-track-exclude-types '("NICK" "333" "353" "JOIN" "PART" "QUIT"))

;; Auto Window Width
 (add-hook 'window-configuration-change-hook 
	   '(lambda ()
	      (setq erc-fill-column (- (window-width) 2))))

;; Logging
(setq erc-log-channels t
      erc-log-channels-directory (concat user-home-dir "/.emacs.d/log/erc")
      erc-log-insert-log-on-open nil
      erc-log-file-coding-system 'utf-8)

;; Channel specific prompt
(setq erc-prompt (lambda ()
                   (if (and (boundp 'erc-default-recipients)
                            (erc-default-target))
                       (erc-propertize (concat (erc-default-target) ">")
                                       'read-only t
                                       'rear-nonsticky t
                                       'front-nonsticky t)
                     (erc-propertize (concat "ERC>")
                                     'read-only t
                                     'rear-nonsticky t
                                     'front-nonsticky t))))

;; Automatically truncate buffer
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook
          'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)

; settings for bitlbee
;; (defun erc-bitlbee ()
;;   (interactive)
;;   (erc :server "192.168.172.10" :port 6667 :nick erc-nick :password ""))
;; 
;; (defun bitlbee-identify ()
;;   "If we're on the bitlbee server, send the identify command to
;;  the &bitlbee channel."
;;   (when (and (string= "127.0.0.1" erc-session-server)
;;              (string= "&bitlbee" (buffer-name)))
;;     (erc-message "PRIVMSG" (format "%s identify %s"
;;                                    (erc-default-target)
;;                                     bitlbeepw))))

(provide 'ysl-erc)
