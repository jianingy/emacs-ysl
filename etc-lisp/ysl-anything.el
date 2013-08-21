(require 'ysl-init)

(add-search-path "el-get/anything")
(require 'anything-config)

(defun ysl/anything-switch-to () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 15
   :sources
   '(
     anything-c-source-buffers
     anything-c-source-bm
     anything-c-source-fixme
     anything-c-source-bookmarks
     anything-c-source-recentf
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
