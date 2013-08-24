(require 'ysl-init)

(add-search-path "el-get/anything")
(require 'anything-config)

(setq anything-c-boring-buffer-regexp
      "\\(\\` \\)\\|\\*anything\\|\\*ac-mode\\| \\*Echo Area\\| \\*Minibuf\\|\\*e?shell")




(defun ysl/anything-switch-to () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 9
   :sources
   '(
     anything-c-source-buffers+
     anything-c-source-bm
     anything-c-source-fixme
     anything-c-source-bookmarks
     anything-c-source-recentf
     anything-c-source-buffer-not-found
     )))

(defun ysl/anything-info () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 3
   :sources
   '(
     anything-c-source-man-pages
     anything-c-source-info-emacs
     )))


(provide 'ysl-anything)
