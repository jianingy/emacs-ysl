;; Setup basic variables
(defvar user-home-dir (getenv "HOME"))
(defvar conf-root-dir (concat user-home-dir "/.emacs.d"))
(defvar user-info-file (concat user-home-dir "/.userinfo.el"))
(defvar user-local-file (concat user-home-dir "/.userlocal.el"))
(setq custom-file (concat user-home-dir "/.userlocal.el"))
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
(require 'ysl-easypg)
(require 'ysl-keybindings)
(require 'ysl-frame-size)
;; (require 'ysl-mode-line)
(require 'ysl-anything)

;; start emacs server {{
(require 'server)
(if (server-running-p)
    (message "Another emacs server is running")
  (server-start))
;; }}

(if (file-exists-p user-local-file) (load-file user-local-file))
