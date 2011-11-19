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
(require 'ysl-org-mode)
(require 'ysl-erc)
(require 'ysl-keybindings)
(require 'ysl-frame-size)

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
 '(org-hide ((t (:background "#2e3436" :foreground "#2e3436"))))
 '(tabbar-default ((t (:weight thin :height 80 :family "PF Tempesta Seven")))))
