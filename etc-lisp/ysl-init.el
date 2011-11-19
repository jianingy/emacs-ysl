(message (concat "ysl-init: user-home-dir: " user-home-dir))
(message (concat "ysl-init: conf-root-dir: " conf-root-dir))

;; define basic functions
(defun add-search-path (path)
  (add-to-list 'load-path (concat conf-root-dir "/" path))
  (message (concat "ysl-init: load-path added: " path)))

; reload dotemacs
(defun ysl-reload()
  (interactive)
  (load-file "~/.emacs.d/init.el") (message "dotEmacs reloaded successfully"))

;; load basic search path
(add-search-path "etc-lisp")
(add-search-path "site-lisp")
(add-search-path "site-lisp/extra")

(provide 'ysl-init)
