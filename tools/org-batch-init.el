;; Setup basic variables
(setq user-home-dir (getenv "HOME")
      conf-root-dir (concat user-home-dir "/.emacs.d"))
(load-file (concat user-home-dir "/.userinfo.el"))
(add-to-list 'load-path (concat conf-root-dir "/etc-lisp"))
(require 'ysl-init)
(require 'ysl-org-mode)
(require 'ysl-org-mode-gtd)
