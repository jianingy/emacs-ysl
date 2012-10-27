(require 'ysl-init)
(require 'yasnippet)
(yas-global-mode 1)

;; (yas/initialize)
(setq yas/root-directory (list (concat conf-root-dir "/yasnippets/vendor")
                               (concat conf-root-dir "/yasnippets/ysl")))

;; disable auto-indent
;; (setf yas/indent-line nil)

(mapc 'yas/load-directory yas/root-directory)

(provide 'ysl-yasnippet)
