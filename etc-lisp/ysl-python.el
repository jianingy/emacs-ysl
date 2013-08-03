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

;; {{{ setup flymake 
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list ysl/python-syntax-checker (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\([Rr]?[pP][Yy]\\)\\'" flymake-pyflakes-init))
;; }}}

;; {{{ initial hook 
(defun ysl/python-mode-hook ()
            (setq indent-tabs-mode nil
                  tab-width 4
                  python-indent 4
                  py-indent-offset 4
                  py-smart-indentation nil)
            (py-smart-indentation-on)
            (local-set-key (kbd "C-c C-c") 'eval-buffer-as-python)
            (add-to-list 'ac-sources 'ac-source-pycomplete)
            (unless (eq buffer-file-name nil) (flymake-mode)))

(add-hook 'python-mode-hook 'ysl/python-mode-hook)
;; }}}
;; do not start python shell at start
(setq py-start-run-py-shell nil)

(add-search-path "el-get/python-mode/completion")
(require 'auto-complete-pycomplete)

;; {{{ compile perl code 
(defun eval-buffer-as-python ()
  "run buffer content as python program"
  (interactive)
  (save-buffer)
  (shell-command (concat "python " (buffer-file-name))))
;; }}}

(provide 'ysl-python)
