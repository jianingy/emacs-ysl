(require 'ysl-init)

(add-search-path "el-get/anything")
(require 'anything-config)

(setq anything-c-boring-buffer-regexp
      "\\(\\` \\)\\|\\*anything\\|\\*ac-mode\\| \\*Echo Area\\| \\*Minibuf\\|\\*e?shell")

(defvar ysl/anything-c-boring-bookmark-regex "^org-\\(capture\\|refile\\)-")
(defvar ysl/anything-c-source-bookmarks
  `((name . "Bookmarks")
    (init . (lambda ()
              (require 'bookmark)))
    (candidates . (lambda ()
                    (remove-if (lambda (x) (string-match
                                            ysl/anything-c-boring-bookmark-regex x))
                               (bookmark-all-names))))
    (type . bookmark))
  "See (info \"(emacs)Bookmarks\").")

(defun ysl/anything-switch-to () (interactive)
  (anything
   :prompt "Switch to: "
   :candidate-number-limit 9
   :sources
   '(
     anything-c-source-buffers+
     anything-c-source-bm
     anything-c-source-fixme
     ysl/anything-c-source-bookmarks
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
