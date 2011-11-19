(require 'ruby-mode)
(add-hook 'ruby-mode-hook
          '(lambda () (progn
                        ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
                        (local-set-key"\C-c\C-c" 'compile-ruby)
                        (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                            (flymake-ruby-load))
                        )))

; compile ruby code {{
(defun compile-ruby ()
  "Use compile to run ruby programs"
  (interactive)
  (compile (concat "/usr/bin/ruby '" (buffer-file-name) "'")))

;; }}

(provide 'ysl-ruby)
