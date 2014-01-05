(require 'ysl-init)

;; {{{ initialize emacs24 package-management
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; }}}

;; {{{ setup el-get
(add-search-path "site-lisp/el-get")
(require 'el-get)
;; }}}

(setq el-get-sources
      '(
        (:name css-mode :type emacswiki)
        (:name hexrgb :type emacswiki)
        (:name layout-restore :type emacswiki)
        (:name ecb
         :description "Emacs Code Browser"
         :type github
         :pkgname "alexott/ecb"
         :build `(("make" "CEDET=" ,(car (delq nil (mapcar (lambda (x) (and (string-match "cedet" x) x)) load-path))) ,(concat "EMACS=" (shell-quote-argument el-get-emacs)))))
))

(setq ysl-packages (append '(
                             ;; some prerequisites
                             smart-operator
                             autopair
                             xml-rpc-el
                             metaweblog ;; must be placed after xml-rpc-el

                             ahg
                             anything
                             auctex
                             boxquote
                             popup
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
                             dash
                             ecb
                             edit-server
                             ess
                             emacs-w3m
                             flim
                             flycheck
                             fuzzy
                             go-mode
                             google-c-style
                             google-maps
                             haskell-mode
                             hexrgb
                             highlight-parentheses
                             htmlize
                             inf-ruby
                             jedi
                             lorem-ipsum
                             magit
                             markdown-mode
                             ;mu4e
                             nxhtml
                             org-mode
                             org-jekyll
                             org-impress-js
                             puppet-mode
                             pymacs
                             python-mode
                             ruby-compilation
                             ruby-mode
                             session
                             slime
                             switch-window
                             virtualenv
                             vkill
                             xcscope
                             yaml-mode
                             org2blog    ;; must be placed after xml-rpc-el & metaweblog
                             o-blog
                             popup
                             tail
                             tomorrow-theme
                             yasnippet
                             weblogger-el
                             window-numbering
                             wrap-region
                             )(mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync ysl-packages)
;(el-get 'wait)

(provide 'ysl-package)
