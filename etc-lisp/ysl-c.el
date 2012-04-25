(require 'ysl-init)

(defun ysl/c-mode-linux-style ()
  (message "c-set-style: K&R")
  (c-set-style "K&R")
  (set (make-local-variable 'c-basic-offset) 8)
       (make-local-variable 'tab-width) 8
       (make-local-variable 'indent-tabs-mode) t)


(defun ysl/c-mode-google-style ()
  (require 'google-c-style)
  (google-set-c-style)
  (google-make-newline-indent))

(add-hook 'c-mode-hook 'ysl/c-mode-linux-style)
(add-hook 'c++-mode-hook 'ysl/c-mode-google-style)

(provide 'ysl-c)
