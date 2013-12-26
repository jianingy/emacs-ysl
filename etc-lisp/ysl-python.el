;;; ysl-python.el --- python configuration
;;; created at : 2013-09-02 15:40:08
;;; author     : Jianing Yang <jianingy@unitedstack.com>
;;; Commentary:
;;; Code:

(require 'ysl-init)

;; {{{ pylookup
(add-search-path "site-lisp/pylookup")
(require 'pylookup)
(setq pylookup-program (concat conf-root-dir "/site-lisp/pylookup/pylookup.py"))
(setq pylookup-db-file (concat conf-root-dir "/site-lisp/pylookup/pylookup.db"))
(global-set-key "\C-ch" 'pylookup-lookup)
;; }}}

(defvar ysl/python-syntax-checker "/usr/bin/pychecker")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.rpy\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; {{{ initial hook
(defun ysl/python-mode-hook ()
  "Set python mode preference."
            (setq indent-tabs-mode nil
                  tab-width 4
                  python-indent 4
                  py-indent-offset 4
                  py-smart-indentation nil)
            (py-smart-indentation-on)
            (local-set-key (kbd "C-c C-c") 'eval-buffer-as-python)
            (add-to-list 'ac-sources 'ac-source-pycomplete))

(add-hook 'python-mode-hook 'ysl/python-mode-hook)
(add-hook 'python-mode-hook 'jedi:setup)
;; }}}
;; do not start python shell at start
(setq py-start-run-py-shell nil)

(add-search-path "el-get/python-mode/completion")
(require 'auto-complete-pycomplete)

;; {{{ compile perl code
(defun eval-buffer-as-python ()
  "Run buffer content as python program."
  (interactive)
  (save-buffer)
  (shell-command (concat "python " (buffer-file-name))))
;; }}}

(provide 'ysl-python)
;;; ysl-python ends here
