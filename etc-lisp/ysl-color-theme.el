(require 'ysl-init)

;; (require 'color-theme)
;; (add-search-path "themes")

(defun ysl/enable-window-theme ()
  (progn

    (require 'color-theme-zenburn)
    (color-theme-zenburn)

    (custom-set-faces
     '(org-hide (( t (:foreground "#3f3f3f")))))))

(defun ysl/enable-terminal-theme ()
  (progn
    (require 'color-theme-ir-black)
    (color-theme-ir-black)
    (set-face-background 'modeline "grey20")
    (set-face-foreground 'modeline "grey70")))

;; ;; INSIPRED BY http://emacs-fu.blogspot.com/2009/03/color-theming.html

(defun ysl/select-color-theme (frame)
; must be current local ctheme
  (select-frame frame)
  (if (window-system frame)
      (ysl/enable-window-theme)
    (ysl/enable-terminal-theme)))

(add-hook 'after-make-frame-functions 'ysl/select-color-theme)

(if (window-system)
    (ysl/enable-window-theme)
  (ysl/enable-terminal-theme))

(setq color-theme-is-global nil)


(provide 'ysl-color-theme)
