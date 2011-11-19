(require 'ysl-init)

(require 'color-theme)
(add-search-path "themes")

(if window-system
    (progn
      (require 'color-theme-tango)
      (color-theme-tango)
      (custom-set-faces
       '(org-hide (( t (:background "#2e3436" :foreground "#2e3436"))))
       ))

  (progn
    (require 'color-theme-ir-black)
    (color-theme-ir-black)))

(provide 'ysl-color-theme)
