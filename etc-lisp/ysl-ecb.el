(require 'ysl-init)

;; Load CEDET first
(setq stack-trace-on-error t) ;; emacs24 fix
(load-file (concat built-in-lisp-dir "/cedet/cedet.elc"))
;; Enable EDE (Project Management) features
(global-ede-mode 1)
(setq semanticdb-default-save-directory (concat user-home-dir "/.semantic.cache/"))
;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)
;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)
;; Load ecb
(require 'ecb)

(provide 'ysl-ecb)
