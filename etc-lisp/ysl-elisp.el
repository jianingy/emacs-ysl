(require 'ysl-init)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-c" 'eval-buffer)
            (setq indent-tabs-mode nil)))

;; slime for common-lisp editing {{
(require 'slime-autoloads)
(slime-setup '(slime-fancy))

(add-hook 'slime-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-q" 'slime-close-all-parens-in-sexp)))
;; }}

(provide 'ysl-elisp)
