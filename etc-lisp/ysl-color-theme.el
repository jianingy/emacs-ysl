(require 'ysl-init)

(require 'color-theme)
(add-search-path "themes")

(defun ysl/enable-window-theme ()
  (progn

    (color-theme-tango)

    (custom-set-faces
     '(org-hide (( t (:background "#2e3436" :foreground "#2e3436")))))))

(defun ysl/enable-window-theme-alt ()
  (progn
;    (require 'zenburn)
;    (color-theme-zenburn)
;    (require 'color-theme-tm)
;    (color-theme-tm)
    (require 'color-theme-dotshare)
    (color-theme-dotshare)
    (custom-set-faces
     '(org-hide (( t (:background "#101010" :foreground "#101010")))))))

(defun ysl/enable-window-theme-tomorrow ()
  (progn
    (add-search-path "el-get/tomorrow-theme/GNU Emacs")
    (require 'tomorrow-night-theme)
    (custom-set-faces
     '(highlight (( t (:foreground "#1d1f21"))))
     '(org-hide (( t (:background "#1d1f21" :foreground "#1d1f21")))))))

(defun ysl/enable-terminal-theme ()
  (progn
    (require 'color-theme-ir-black)
    (color-theme-ir-black)
    (set-face-background 'mode-line "grey20")
    (set-face-foreground 'mode-line "grey70")))

;; ;; INSIPRED BY http://emacs-fu.blogspot.com/2009/03/color-theming.html

(defun ysl/select-color-theme (frame)
; must be current local ctheme
  (select-frame frame)
  (if (window-system frame)
      (if (eq system-type 'darwin)
          (ysl/enable-window-theme-alt)
          (ysl/enable-window-theme-alt))
    (ysl/enable-terminal-theme)))

(add-hook 'after-make-frame-functions 'ysl/select-color-theme)
(defvar ysl/disable-default-color-theme nil)

(unless ysl/disable-default-color-theme
  (if (window-system)
      (if (eq system-type 'darwin)
          (ysl/enable-window-theme-tomorrow)
        (ysl/enable-window-theme-tomorrow))
    (ysl/enable-terminal-theme)))

(setq color-theme-is-global nil)


(provide 'ysl-color-theme)
