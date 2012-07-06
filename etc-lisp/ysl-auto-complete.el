(require 'ysl-init)

(require 'auto-complete)
(require 'auto-complete-config nil t)
(add-to-list 'ac-dictionary-directories (concat conf-root-dir "/ac-dict"))
(ac-config-default)
(setq ac-sources (append ac-sources '(ac-source-yasnippet)))
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" nil)

;; (setq ac-dwim t) ;; Do What I Mean Mode: enabled by default
;; (setq ac-auto-start 3)

;; enable auto complete for all buffer

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

(provide 'ysl-auto-complete)
