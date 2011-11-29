;; Setup basic variables
(defvar user-home-dir (getenv "HOME"))
(defvar conf-root-dir (concat user-home-dir "/.emacs.d"))
(defvar user-info-file (concat user-home-dir "/.userinfo.el"))
(if (file-exists-p user-info-file) (load-file user-info-file))

(add-to-list 'load-path (concat conf-root-dir "/etc-lisp"))

;; import submodules
(require 'ysl-init)
(require 'ysl-package)
(require 'ysl-color-theme)
(require 'ysl-ui)
(require 'ysl-editing)
(require 'ysl-backup)
(require 'ysl-mail)
(require 'ysl-shell)
(require 'ysl-coding)
(require 'ysl-ess)
(require 'ysl-org-mode)
(require 'ysl-erc)
(require 'ysl-keybindings)
(require 'ysl-frame-size)
(require 'ysl-mode-line)

;; start emacs server {{
(require 'server)
(if (server-running-p)
    (message "Another emacs server is running")
  (server-start))
;; }}

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(ecb-layout-name "leftright2")
 '(ecb-layout-window-sizes (quote (("leftright2" (ecb-directories-buffer-name 0.13526570048309178 . 0.6379310344827587) (ecb-sources-buffer-name 0.13526570048309178 . 0.3448275862068966) (ecb-methods-buffer-name 0.21739130434782608 . 0.6379310344827587) (ecb-history-buffer-name 0.21739130434782608 . 0.3448275862068966)))))
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block-begin-line ((t (:background "transparent" ))))
 '(org-block-end-line ((t (:background "transparent" ))))
 '(org-hide ((t (:background "transparent" :foreground "#2e3436"))))
 '(tabbar-default ((t (:weight thin :height 60 :family "PF Tempesta Seven")))))
