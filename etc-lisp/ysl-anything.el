(require 'ysl-init)

(add-search-path "el-get/anything")
(require 'anything-config)
(global-set-key (kbd "C-x b")
  (lambda() (interactive)
    (anything
     :prompt "Switch to: "
     :candidate-number-limit 10                 ;; up to 10 of each
     :sources
     '( anything-c-source-buffers               ;; buffers
        anything-c-source-recentf               ;; recent files
        anything-c-source-bookmarks             ;; bookmarks
        anything-c-source-files-in-current-dir+ ;; current dir
        anything-c-source-locate))))            ;; use 'locate'

(global-set-key (kbd "C-c i")  ;; i -> info
  (lambda () (interactive)
    (anything
      :prompt "Info about: "
      :candidate-number-limit 3
      :sources
      '( ;;anything-c-source-info-libc             ;; glibc docs
         anything-c-source-man-pages             ;; man pages
         anything-c-source-info-emacs))))        ;; emacs


(provide 'ysl-anything)
