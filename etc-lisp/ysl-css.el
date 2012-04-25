(require 'ysl-init)

;; CSS Mode {{
(require 'rainbow-mode)
(setq css-indent-offset 2)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(autoload 'css-mode "css-mode" nil t)
(add-hook 'css-mode-hook 'rainbow-mode)
;; }}

(provide 'ysl-css)
