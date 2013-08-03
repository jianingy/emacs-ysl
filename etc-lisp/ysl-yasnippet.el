(require 'ysl-init)
(require 'yasnippet)


;; (yas/initialize)
(setq yas/snippet-dirs '("~/.emacs.d/yasnippets/ysl"
                         "~/.emacs.d/el-get/yasnippet/snippets"))
(yas/global-mode 1)

;; {{{ snippet directory old fashion 
;; (setq yas/root-directory (list (concat conf-root-dir "/yasnippets/vendor")
;;                               (concat conf-root-dir "/yasnippets/ysl")))
;; (mapc 'yas/load-directory yas/root-directory)
;; }}}

;; disable auto-indent
;; (setf yas/indent-line nil)



(provide 'ysl-yasnippet)
