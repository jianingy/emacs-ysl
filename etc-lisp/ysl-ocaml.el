(require 'ysl-init)

;; {{ disable ocaml-mode since we start to use tugreg-mode
;;(setq auto-mode-alist
;;          (cons '("\\.ml[iyl]?$" .  caml-mode) auto-mode-alist))
;;(add-search-path "site-lisp/ocaml")
;; (autoload 'caml-mode "ocaml" (interactive)
;; "Major mode for editing Caml code." t)
;; (autoload 'camldebug "camldebug" (interactive) "Debug caml mode")
;; }}

;; {{ tuareg-mode
(add-search-path "site-lisp/tuareg-2.0.4")
(add-search-path "site-lisp/tuareg-caml-mode")
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;; }}
(provide 'ysl-ocaml)
