(require 'ysl-init)

(add-hook 'c-mode-common-hook
	  '(lambda() (progn
	           (setq
                    tab-width 4
                    c-basic-offset 4)
                   (require 'google-c-style)
                   (google-set-c-style)
                   (google-make-newline-indent))))

(provide 'ysl-c)
