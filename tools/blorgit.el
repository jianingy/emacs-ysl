
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode-contrib")
(require 'color-theme)
(require 'org)
(color-theme-initialize)
(setq org-export-creator-info t)
(load-file "/Users/jianingy/local/lib/blorgit/backend/acts_as_org/elisp/org-interaction.el")
