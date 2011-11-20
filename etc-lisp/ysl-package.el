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
(add-search-path "el-get/el-get")
(require 'el-get)
;; }}

(setq el-get-sources
      '(
        (:name ruby-compilation :type elpa)
        (:name ahg :type elpa)
        (:name auto-complete :type elpa)
        (:name color-theme :type elpa)
        (:name color-theme-tango :type elpa)
        (:name color-theme-ir-black :type elpa)
        (:name css-mode :type elpa)
        (:name flymake-cursor :type elpa)
        (:name flymake-jslint :type elpa)
        (:name flymake-ruby :type elpa)
        (:name flymake-shell :type elpa)
        (:name highlight-parentheses :type elpa)
        (:name htmlize :type elpa)
        (:name inf-ruby :type elpa)
        (:name org :type elpa)
        (:name pymacs :type elpa)
        (:name python-mode :type elpa)
        (:name rainbow-mode :type elpa)
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode)
        (:name ruby-mode :type elpa)
                                        ;        (:name rvm
                                        ;               :type git
                                        ;               :url "http://github.com/djwhitt/rvm.el.git"
                                        ;               :load "rvm.el"
                                        ;               :compile ("rvm.el")
                                        ;               :after (lambda() (rvm-use-default)))
        (:name session :type elpa)
        (:name xml-rpc :type elpa)
        (:name yaml-mode
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode)
        (:name yasnippet-bundle :type elpa)))

(setq ysl-packages
      (append '(el-get switch-window vkill google-maps nxhtml
                       xcscope cssh virtualenv slime ecb
                       google-c-style)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync ysl-packages)
;(el-get 'wait)

(provide 'ysl-package)
