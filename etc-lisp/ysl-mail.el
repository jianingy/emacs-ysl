;;; package --- mu4e mail processing and smtp settings
;;; Commentary:
;;; Code:

;; {{{ smtp
(require 'smtpmail)

;; ;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; (setq starttls-gnutls-program
;;       (cond
;;        ((file-executable-p "/usr/local/bin/gnutls-cli") "/usr/local/bin/gnutls-cli")
;;        (t "/usr/bin/gnutls-cli")
;;        ))
;; ;; }}}


;; {{{ mu4e mail client
(require 'mu4e)

(setq
 mail-user-agent 'mu4e-user-agent     ;; set mu4e default emacs mail client
 mu4e-maildir (concat user-home-dir "/Mails")
 mu4e-sent-messages-behavior 'delete  ;; don't save message to Sent Messages,
                                      ;; Gmail/IMAP takes care of this
 mu4e-confirm-quit nil                ;; dont ask when quit
 message-kill-buffer-on-exit t        ;; don't keep message buffers around
 org-mu4e-conver-to-html t
 mu4e-html2text-command "html2text -utf8 -width 72")


;; choose account when composing
(defvar ysl/mu4e-account-alist '())
(defun ysl/mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) ysl/mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) ysl/mu4e-account-alist)
                             nil t nil nil (caar ysl/mu4e-account-alist))))
         (account-vars (cdr (assoc account ysl/mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'ysl/mu4e-set-account)

;; default account settings
(setq mu4e-sent-folder "/main/sent"
      mu4e-drafts-folder "/main/drafts"
      user-mail-address "jianingy.yang@gmail.com"
      ;message-signature-file ".signature1.txt"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-user "jianingy.yang@gmail.com"
      ;smtpmail-local-domain "main.tld"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; display inline image, use imagemagick, if available
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types) (imagemagick-register-types))

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.
(setq mu4e-maildir-shortcuts
      '(("/main/INBOX"               . ?i)
        ("/main/flagged"             . ?f)
        ("/unitedstack/INBOX"        . ?u)
        ("/unitedstack/flagged"      . ?g)
        ))

;; allow for updating mail using 'U' in the main view:
;; uncomment  if don't have offlineimap run background separatedly
;; (setq mu4e-get-mail-command "offlineimap")

;; bookmarks ignore items
;; (setq mu4e-bm-ignore (concat " AND NOT maildir:/[Gmail].*"
;; 			     " AND NOT maildir:/Sent Messages"
;; 			     " AND NOT maildir:/Deleted Messages"
;; 			     " AND NOT flag:trashed"))
(setq mu4e-bm-ignore "")

(setq mu4e-bookmarks
  `( ("flag:unread AND NOT flag:trashed"                               "Unread messages"      ?u)
;     ("subject:PMO AND maildir:/INBOX"                                 "Project messages"     ?p)
;     ("subject:RFC AND maildir:/INBOX"                                 "Discussions"          ?d)
     (,(concat "to:" user-mail-address mu4e-bm-ignore)                 "Messages for me"      ?m)
     (,(concat "date:today..now" mu4e-bm-ignore)                       "Today's messages"     ?t)
     (,(concat "date:7d..now" mu4e-bm-ignore)                          "Last 7 days"          ?w)))

;; integration with org-mode
(require 'org-mu4e)

;; mu-cite
(add-search-path "site-lisp/mu-cite")
(require 'mu-cite)
(setq message-cite-function 'mu-cite-original
      mu-cite-top-format '("On " date ", " from " wrote:\n\n")
      mu-cite-prefix-format '(" > "))

(provide 'ysl-mail)
;;; ysl-mail ends here
