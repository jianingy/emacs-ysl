(require 'ysl-init)

(defun ysl/c-mode-linux-style ()
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8
        tab-width 8
        indent-tabs-mode t))


(defun ysl/c-mode-google-style ()
  (require 'google-c-style)
  (google-set-c-style)
  (google-make-newline-indent)
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil))

(add-hook 'c-mode-hook 'ysl/c-mode-google-style)
(add-hook 'c++-mode-hook 'ysl/c-mode-google-style)

(setq auto-mode-alist (cons '("linux.*/.*\\.[ch]$" . ysl/c-mode-linux-style) auto-mode-alist))

(provide 'ysl-c)
