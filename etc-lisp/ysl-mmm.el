(add-search-path "site-lisp/mmm-mode")
(require 'mmm-mode)
(require 'mmm-mako)
(setq mmm-global-mode 'maybe)
(setq sgml-warn-about-undefined-entities nil)

(mmm-add-group
 'ysl/html-js
 '((ysl/js-tag
    :submode javascript-mode
    :face mmm-code-submode-face
    :delimiter-mode nil
    :front "<script>"
    :back "</script>")
    (ysl/js-inline
     :submode javascript-mode
     :face mmm-code-submode-face
     :delimiter-mode nil
     :front "\\bon\\w+=\""
     :back "\"")))

(mmm-add-group
 'ysl/fancy-html
 '(
   (ysl/css-inline
    :submode css-mode
    :face mmm-declaration-submode-face
    :front "style=\""
    :back "\"")))
;;

(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
;; What features should be turned on in this html-mode? {{
(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)
(mmm-add-mode-ext-class 'html-mode nil 'ysl/fancy-html)
(mmm-add-mode-ext-class 'html-mode nil 'ysl/html-js)
(mmm-add-mode-ext-class 'html-mode nil 'embedded-css)
;; }}

(provide 'ysl-mmm)
