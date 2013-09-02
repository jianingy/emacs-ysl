;; filename   : ysl-go.el
;; created at : 2013-09-02 15:40:08
;; author     : Jianing Yang <jianingy@unitedstack.com>

(defvar ysl/go-executable "/usr/local/go/bin/go")

;;; {{{
(defun ysl/go-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width 4)
  (local-set-key (kbd "C-c C-c") 'eval-buffer-as-go))
(add-hook 'go-mode-hook 'ysl/go-mode-hook)
;;; }}}

;; {{{ compile perl code
(defun eval-buffer-as-go ()
  "run buffer content as python program"
  (interactive)
  (save-buffer)
  (shell-command (concat ysl/go-executable " run " (buffer-file-name))))
;; }}}


(provide 'ysl-go)
