;;----------------------------------------------------------
;; ---- BEGIN Email client ----
;;----------------------------------------------------------

;; {{{ smtp 
(require 'smtpmail)

;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 587)

(setq starttls-gnutls-program
      (cond
       ((file-executable-p "/usr/local/bin/gnutls-cli") "/usr/local/bin/gnutls-cli")
       (t "/usr/bin/gnutls-cli")
       ))
;; }}}


;; {{{ mu4e mail client 
(require 'mu4e)

;; default
(setq mu4e-maildir "~/mails"
      mu4e-drafts-folder "/[Gmail].Drafts"
      mu4e-sent-folder   "/[Gmail].Sent Mail"
      mu4e-trash-folder  "/[Gmail].Trash")

;; dont ask when quit
(setq mu4e-confirm-quit nil)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/OpenStack.Heat"      . ?h)
         ("/ZOHO"                . ?z)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
;; uncomment  if don't have offlineimap run background separatedly
;; (setq mu4e-get-mail-command "offlineimap")

;; display inline image, use imagemagick, if available
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types) (imagemagick-register-types))

(setq
 message-kill-buffer-on-exit t ;; don't keep message buffers around
 org-mu4e-conver-to-html t
 mu4e-html2text-command "html2text -utf8 -width 72")


;; bookmarks
(setq bm-ignore (concat " AND NOT maildir:/[Gmail].*"
                        " AND NOT maildir:/Sent Messages"
                        " AND NOT maildir:/Deleted Messages"
                        " AND NOT flag:trashed"))
(setq mu4e-bookmarks
  `( ("flag:unread AND NOT flag:trashed AND maildir:/INBOX"            "Unread messages"      ?u)
     ("subject:PMO AND maildir:/INBOX"                                 "Project messages"     ?p)
     ("subject:RFC AND maildir:/INBOX"                                 "Discussions"          ?d)
     (,(concat "date:today..now" bm-ignore)                            "Today's messages"     ?t)
     (,(concat "date:7d..now" bm-ignore)                               "Last 7 days"          ?w)
     (,(concat "to:" user-mail-address bm-ignore)                      "Messages for me"      ?m)))

;; integration with org-mode
(require 'org-mu4e)
(setq mail-user-agent 'mu4e-user-agent)

(add-search-path "site-lisp/mu-cite")
(require 'mu-cite)
(setq message-cite-function 'mu-cite-original)
(setq mu-cite-top-format
      '("On " date ", " from " wrote:\n\n"))
(setq mu-cite-prefix-format '(" > "))


;;----------------------------------------------------------
;; ---- END Email client ----
;;----------------------------------------------------------

(provide 'ysl-mail)
