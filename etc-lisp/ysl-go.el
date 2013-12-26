;;; ysl-go.el --- go configuration
;;; created at : 2013-09-02 15:40:08
;;; author     : Jianing Yang <jianingy@unitedstack.com>
;;; Commentary:

;;; Code:
(defvar ysl/go-executable "/usr/local/go/bin/go")
(defvar ysl/gofmt-executable "/usr/local/go/bin/gofmt")

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
  "Run buffer content as python program."
  (interactive)
  (save-buffer)
  (compilation-start (concat ysl/go-executable " run " (buffer-file-name))))
;; }}}


(require 'go-mode)

(provide 'ysl-go)
;;; ysl-go.el ends here
