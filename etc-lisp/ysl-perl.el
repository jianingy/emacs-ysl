(require 'ysl-init)

;; use cperl-mode instead of perl-mode
(fset 'perl-mode 'cperl-mode)

;; Use cperl-mode instead of the default perl-mode {{
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
;; }}

(add-hook 'cperl-mode-hook
	  '(lambda ()
             (unless (eq buffer-file-name nil) (flymake-mode))
             (setq ndent-tabs-mode nil
                   cperl-indent-level 4)
             (local-set-key "\C-m" 'newline-and-indent)
             (local-set-key (kbd "C-c C-c") 'eval-buffer-as-perl)
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

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\([pP][Llm]\\|al\\)\\'" flymake-perl-init))
;; }}

;; compile perl code {{
(defun eval-buffer-as-perl ()
  "run buffer content as perl program"
  (interactive)
  (save-buffer)
  (shell-command (concat "perl " (buffer-file-name))))
;; }}

(provide 'ysl-perl)
