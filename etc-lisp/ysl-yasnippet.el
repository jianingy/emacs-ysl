(require 'ysl-init)
(require 'yasnippet)

(yas/initialize)
(setq yas/root-directory (list (concat conf-root-dir "/yasnippets/vendor")
                               (concat conf-root-dir "/yasnippets/ysl")))

(mapc 'yas/load-directory yas/root-directory)

(provide 'ysl-yasnippet)
