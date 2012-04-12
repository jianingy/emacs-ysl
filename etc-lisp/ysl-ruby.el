(require 'ruby-mode)
(add-hook 'ruby-mode-hook
          '(lambda () (progn
                        ;; Don't want flymake mode for ruby regions in
                        ;; rhtml files and also on read only files
                        (local-set-key"\C-c\C-c" 'compile-ruby)
                        (setq ruby-deep-arglist t)
                        (setq ruby-deep-indent-paren nil)
                        (require 'inf-ruby)
                        (require 'ruby-compilation)
                        (require 'flymake-ruby)
                        ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
                        (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                            (flymake-ruby-load))
                        )))

; compile ruby code {{
(defun compile-ruby ()
  "Use compile to run ruby programs"
  (interactive)
  (compile (concat "ruby '" (buffer-file-name) "'")))
;; }}

;; rhtml {{
(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode '(lambda ()
                         (define-key rhtml-mode-map (kbd "M-s") 'save-buffer)))
;; }}

;; auto mode list {{
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
;; }}

(provide 'ysl-ruby)
