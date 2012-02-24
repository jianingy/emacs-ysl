(require 'ysl-init)

;; initialize emacs24 package-management {{
(if (>= emacs-major-version 24)
    (progn
      (package-initialize)
      ;; Add the original Emacs Lisp Package Archive
      (add-to-list 'package-archives
                   '("elpa" . "http://tromey.com/elpa/"))
      ;; Add the user-contributed repository
      (add-to-list 'package-archives
                   '("marmalade" . "http://marmalade-repo.org/packages/"))))
;; }}

;; setup el-get {{
(add-search-path "site-lisp/el-get")
(require 'el-get)
;; }}

(setq el-get-sources
      '(
;        (:name nxhtml
;               :type emacsmirror
;               :description "An addon for Emacs mainly for web development."
;               :build
;               (list (concat el-get-emacs " -batch -q -no-site-file -L . -l nxhtmlmaint.el -f nxhtmlmaint-start-byte-compilation"))
;               :load "autostart.el")

        (:name crontab-mode
               :description "Mode for editing crontab files"
               :type http
               :url "http://www.mahalito.net/~harley/elisp/crontab-mode.el")

        (:name css-mode :type elpa)
        (:name flymake-cursor :type elpa)
        (:name flymake-jslint :type elpa)
        (:name flymake-shell :type elpa)
        (:name rainbow-mode :type elpa)
        (:name yasnippet-bundle :type elpa)
        ))

(setq ysl-packages (append '(
                             ahg
                             anything
                             auto-complete
                             auto-complete-clang
                             auto-complete-css
                             auto-complete-emacs-lisp
                             auto-complete-ruby
                             auto-complete-yasnippet
                             color-theme
                             color-theme-ir-black
                             color-theme-tango
                             crontab-mode
                             css-mode
                             cssh
                             ecb
                             ess
                             flim
                             flymake-cursor
                             flymake-jslint
                             flymake-point
                             flymake-ruby
                             flymake-shell
                             google-c-style
                             google-maps
                             highlight-parentheses
                             htmlize
                             inf-ruby
							 nxhtml
                             org-mode
                             pymacs
                             python-mode
                             rainbow-mode
                             ruby-compilation
                             ruby-mode
                             session
                             slime
                             switch-window
                             virtualenv
                             vkill
                             xcscope
                             xml-rpc-el
                             yaml-mode
                             org2blog  ;; must place after xml-rpc-el
                          ;; yasnippet ;; use yasnippet-bundle since this one is broken
                             )(mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync ysl-packages)
;(el-get 'wait)

(provide 'ysl-package)
