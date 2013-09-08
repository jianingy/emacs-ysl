;; filename   : ysl-go.el
;; created at : 2013-09-02 15:40:08
;; author     : Jianing Yang <jianingy@unitedstack.com>

(defvar ysl/go-executable "/usr/local/go/bin/go")
(defvar ysl/gofmt-executable "/usr/local/go/bin/gofmt")

(eval-after-load "go-mode"
  '(progn
     (flycheck-declare-checker go-fmt
       "A Go syntax and style checker using the gofmt utility."
       :command `(,ysl/gofmt-executable source-inplace)
       :error-patterns '(("^\\(?1:.*\\):\\(?2:[0-9]+\\):\\(?3:[0-9]+\\): \\(?4:.*\\)$" error))
       :modes 'go-mode)
     (add-to-list 'flycheck-checkers 'go-fmt)))

;;; {{{
(defun ysl/go-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width 4)
  (flycheck-mode)
  (local-set-key (kbd "C-c C-c") 'eval-buffer-as-go))
(add-hook 'go-mode-hook 'ysl/go-mode-hook)
;;; }}}

;; {{{ compile perl code
(defun eval-buffer-as-go ()
  "run buffer content as python program"
  (interactive)
  (save-buffer)
  (compilation-start (concat ysl/go-executable " run " (buffer-file-name))))
;; }}}


(require 'go-mode)

(provide 'ysl-go)
