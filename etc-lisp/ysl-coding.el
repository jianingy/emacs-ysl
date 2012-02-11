(require 'ysl-init)
(require 'ysl-extra)

(require 'ahg) ;; Mercurial Push & Pull support
(require 'js) ;; require fixed js-mode
(require 'htmlize)
(require 'flymake)
(require 'flymake-cursor)

(require 'ysl-ecb)
(require 'ysl-c)
(require 'ysl-perl)
(require 'ysl-python)
(require 'ysl-ruby)
(require 'ysl-elisp)
(require 'ysl-css)
(require 'ysl-ocaml)
;; (require 'ysl-mmm)

;; other languages {{
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

;; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; }}


;; disabled for performance reason {{
;; (add-search-path "site-lisp/rfringe")
;; (require 'rfringe)
;; }}

;; setup flymake {{
(setq flymake-extension-use-showtip t)
(setq flymake-allowed-file-name-masks
      (list
       '("\\.py\\'" flymake-pyflakes-init)
       '("\\.p[ml]\\'" flymake-perl-init)))
;; }}

;; setup whitespace detection {{
(ysl/set-whitespace-detection-mode
 '(python-mode
   ruby-mode
   css-mode
   html-mode
   mmm-mode
   c-mode
   cc-mode
   lisp-mode
   emacs-lisp-mode
   cperl-mode
   perl-mode))
;; }}

;; delete trailing whitespace, hope it's safe
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; nxhtml {{
(add-hook
 'nxml-mode-hook
 '(lambda ()
   (local-set-key "\r" 'newline-and-indent)
   (setq nxml-child-indent 4
    tab-width 4
    standard-indent 4
    indent-tabs-mode nil)))
;; }}

(provide 'ysl-coding)
