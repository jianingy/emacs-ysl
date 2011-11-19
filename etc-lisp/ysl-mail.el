(setq starttls-gnutls-program
      (cond
       ((file-executable-p "/usr/local/bin/gnutls-cli") "/usr/local/bin/gnutls-cli")
       (t "/usr/bin/gnutls-cli")
       ))

(provide 'ysl-mail)