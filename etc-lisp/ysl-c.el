(require 'ysl-init)

(add-hook 'c-mode-common-hook
	  '(lambda() (progn
		       (require 'google-c-style)
		       (google-set-c-style)
		       (google-make-newline-indent))))

(provide 'ysl-c)
