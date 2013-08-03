(require 'ysl-init)
(require 'ysl-extra)

(require 'magit) ;; Git support
(require 'ahg) ;; Mercurial Push & Pull support
(require 'js) ;; require fixed js-mode
(require 'mql-mode) ;; MetaTrader Mode
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

;; {{{ other languages 
;; (add-hook 'sh-set-shell-hook 'flymake-shell-load)

;; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; }}}


;; {{{ disabled for performance reason 
;; (add-search-path "site-lisp/rfringe")
;; (require 'rfringe)
;; }}}

;; {{{ setup flymake 
(setq flymake-extension-use-showtip t)
;; }}}

;; {{{ setup whitespace detection 
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
;; }}}

;; delete trailing whitespace, hope it's safe
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; {{{ nxhtml 
(add-hook
 'nxml-mode-hook
 '(lambda ()
   (local-set-key "\r" 'newline-and-indent)
   (setq nxml-child-indent 4
         tab-width 4
         standard-indent 4
         indent-tabs-mode nil)))
;; }}}

;; {{{ auto-header 
(setq-default auto-insert-directory "~/.emacs.d/templates/")
(auto-insert-mode)
(setq auto-insert-query nil)

(define-auto-insert "\\.org$" "template.org")
(define-auto-insert "\\.ino$" "template.ino")
(define-auto-insert "\\.\\([C]\\|cc\\|cpp\\)$"  "template.c")
(define-auto-insert "\\.\\([Hh]\\|hh\\|hpp\\)$" "template.h")
(define-auto-insert "\\.tex$" "template.tex")
(define-auto-insert "\\.sh$" "template.sh")
(define-auto-insert "\\.rb$" "template.rb")
(define-auto-insert "\\.el$" "template.el")
(define-auto-insert "\\.py$" "template.py")
(define-auto-insert "\\.pl$" "template.pl")
(define-auto-insert "\\.pm$" "template.pm")
(define-auto-insert "\\.ml$" "template.ml")
(define-auto-insert "\\.mq4$" "template.mql")
(define-auto-insert "\\.mq5$" "template.mql")
(define-auto-insert "\\.mql$" "template.mql")

(defadvice auto-insert  (around yasnippet-expand-after-auto-insert activate)
  "expand auto-inserted content as yasnippet templete,
  so that we could use yasnippet in autoinsert mode"
  (let ((is-new-file (and (not buffer-read-only)
                          (or (eq this-command 'auto-insert)
                              (and auto-insert (bobp) (eobp))))))
    ad-do-it
    (let ((old-point-max (point-max))
          (yas-indent-line nil))
      (when is-new-file
        (goto-char old-point-max)
        (yas-expand-snippet (buffer-substring-no-properties (point-min) (point-max)))
        (delete-region (point-min) old-point-max)))))
;; }}}

;; {{{ arduino mode 
(add-search-path "site-lisp/arduino-mode")
(require 'arduino-mode)
(defun ysl/arduino-mode-hook ()
(local-set-key "\C-c\C-c" 'compile))
(add-hook 'arduino-mode-hook 'ysl/arduino-mode-hook)

;; }}}

;; {{{ plantuml-mode 
(setq plantuml-jar-path org-plantuml-jar-path)
(require 'plantuml-mode)
;; }}}

(provide 'ysl-coding)
