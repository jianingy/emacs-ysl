(require 'ysl-init)

;; use cperl-mode instead of perl-mode
(fset 'perl-mode 'cperl-mode)
;; enter python by looking at shebang
(setq interpreter-mode-alist
      (cons '("perl" . cperl-mode) interpreter-mode-alist))

(add-hook 'cperl-mode-hook
	  '(lambda ()
            (unless (eq buffer-file-name nil) (flymake-mode))
	        (setq ndent-tabs-mode nil
                  cperl-indent-level 4)
			(local-set-key "\C-m" 'newline-and-indent)
			(local-set-key (kbd "C-c C-c") 'compile-perl)
			(set (make-local-variable 'compilation-scroll-output) nil)
			))

;; flyamke {{
(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
     	 (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc " local-file))))
;; }}

;; compile perl code {{
(defun compile-perl ()
  "Use compile to run perl programs"
  (interactive)
  (compile (concat "perl " (buffer-file-name)))
  (switch-window))
;; }}

(provide 'ysl-perl)
