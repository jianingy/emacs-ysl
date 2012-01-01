;; Setup basic variables
(defvar user-home-dir (getenv "HOME"))
(defvar conf-root-dir (concat user-home-dir "/.emacs.d"))
(defvar user-info-file (concat user-home-dir "/.userinfo.el"))
(defvar user-local-file (concat user-home-dir "/.userlocal.el"))
(add-to-list 'load-path (concat conf-root-dir "/etc-lisp"))

;; import submodules
(require 'ysl-init)
(if (file-exists-p user-info-file) (load-file user-info-file))
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
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(inhibit-startup-screen t)
 '(mode-line-format (list "  " "%z:" (quote (:eval (propertize " %b " (quote face) (quote font-lock-keyword-face) (quote help-echo) (buffer-file-name)))) "(" (propertize "%02l" (quote face) (quote font-lock-type-face)) "," (propertize "%02c" (quote face) (quote font-lock-type-face)) ") " "(" (propertize "%p" (quote face) (quote font-lock-constant-face)) "/" (propertize "%I" (quote face) (quote font-lock-constant-face)) ") " "[" (quote (:eval (propertize "%m" (quote face) (quote font-lock-keyword-face) (quote help-echo) buffer-file-coding-system))) minor-mode-alist "] " "[" (quote (:eval (propertize (if overwrite-mode "Ovr" "Ins") (quote face) (quote font-lock-preprocessor-face) (quote help-echo) (concat "Buffer is in " (if overwrite-mode "overwrite" "insert") " mode")))) (quote (:eval (when (buffer-modified-p) (concat " " (propertize "Mod" (quote face) (quote font-lock-warning-face) (quote help-echo) "Buffer has been modified"))))) (quote (:eval (when buffer-read-only (concat " " (propertize "RO" (quote face) (quote font-lock-type-face) (quote help-echo) "Buffer is read-only"))))) (propertize "%n" (quote face) (quote font-lock-constant-face) (quote help-echo) "Buffer is narrowed") "] " (quote (:eval (when org-clock-current-task (concat "-== " (propertize org-clock-current-task (quote face) (quote font-lock-constant-face)) " ==- ")))) (quote (:eval (propertize (format-time-string "%H:%M") (quote help-echo) (concat (format-time-string "%c; ") (emacs-uptime "Uptime:%hh"))))) " " (quote (:eval (propertize foundnewmbox (quote face) (quote flymake-errline)))) "% "))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))

(if (file-exists-p user-local-file) (load-file user-local-file))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((t (:background "#33c"))))
 '(org-hide ((t (:background "#111" :foreground "#111"))))
 '(tabbar-default ((t (:weight thin :height 80 :family "PF Tempesta Seven")))))
