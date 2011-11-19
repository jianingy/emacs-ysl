(require 'ysl-init)

;; CSS Mode {{
(setq css-indent-offset 2)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(autoload 'css-mode "css-mode" nil t)
;; }}

(provide 'ysl-css)
