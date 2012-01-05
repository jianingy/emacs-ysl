(require 'ysl-init)

(add-search-path "el-get/anything")
(require 'anything-config)

(defun ysl/anything-switch-to () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 10
   :sources
   '(
     anything-c-source-buffers
     anything-c-source-recentf
     anything-c-source-bookmarks
     )))        ;; emacs

(defun ysl/anything-info () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 3
   :sources
   '(
     anything-c-source-man-pages
     anything-c-source-info-emacs
     )))        ;; emacs


(provide 'ysl-anything)
