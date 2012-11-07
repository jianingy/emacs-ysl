(require 'ysl-init)

(defvar ysl/python-active-virtualenv nil)
(defvar ysl/python-executable "/usr/bin/python")
(defvar ysl/python-syntax-checker "/usr/bin/pychecker")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.rpy\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; compile python code {{
(defun compile-python ()
  "Use compile to run python programs"
  (interactive)
  (if ysl/python-active-virtualenv
      (compile (concat "python"
                       " " (buffer-file-name)))
    (compile (concat ysl/python-executable " " (buffer-file-name)))))
;; }}

;; setup flymake {{
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list ysl/python-syntax-checker (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\([Rr]?[pP][Yy]\\)\\'" flymake-pyflakes-init))
;; }}

;; initial hook {{
(add-hook 'python-mode-hook
          (lambda ()

            (setq indent-tabs-mode nil
                  tab-width 4
                  python-indent 4
                  py-indent-offset 4
                  py-smart-indentation nil)

;            (set (make-local-variable 'virtualenv-workon-starts-python) nil)

            (unless (eq buffer-file-name nil) (flymake-mode))
            (require 'ac-python)

            (local-set-key "\C-m" 'newline-and-indent)
            (local-set-key "\C-d" 'py-help-at-point)
            (local-set-key (kbd "C-c C-c") 'compile-python)

            ;; initialize virtualenv
            (if ysl/python-active-virtualenv
                (progn
                  (require 'virtualenv)
                  (virtualenv-minor-mode-on)
                  (virtualenv-workon ysl/python-active-virtualenv)))))
;; }}


(provide 'ysl-python)
