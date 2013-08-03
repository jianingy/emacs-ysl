(require 'ysl-init)
(require 'ysl-font)
(require 'generic-x)
;; tabbar is buggy so disable it
;; (require 'ysl-tabbar)

(custom-set-variables
 '(current-language-environment "UTF-8")

 '(display-time-day-and-date t)     ;; Show date
 '(display-time-24hr-format  t)     ;; Show time in 24-hour format
 '(show-paren-mode     t)
 '(visible-bell        t)                  ;; turn on visible bell, it looks ugly on my mac
 '(scroll-bar-mode     nil)                ;; disable scrollbar as it looks ugly
 '(tool-bar-mode       nil)                ;; disable toolbar
 '(column-number-mode  t)                  ;; display column number
 '(display-time-mode   t)                  ;; Show time on status bar
 '(blink-cursor-mode   nil)                ;; Stop cursor blinking
 '(inhibit-startup-message t))             ;; disable splash screen


(add-search-path "site-lisp/emacs-powerline")
(require 'powerline)

;; enable iswtchb-mode
(iswitchb-mode t)

;; {{{ auto kill buffer with running process 
;(setq kill-buffer-query-functions
; (remove 'process-kill-buffer-query-function
;         kill-buffer-query-functions))
;; }}}

;; no need to change fringe if we don't use linum mode
;; (when (fboundp 'fringe-mode) (fringe-mode '(0 . 7))) ;; set fringe size

;; {{{ disable menu-bar when using gnu/linux 
;; (if (eq system-type 'gnu/linux) (menu-bar-mode -1))
;; }}}

;; {{{ set linum format 
;; linum is buggy in org/erc/gnus mode and fringe, disable it completely
;; (setq linum-format
;;       (lambda (line)
;;         (propertize (format
;;                      (let ((w (length (number-to-string
;;                                        (count-lines (point-min) (point-max))))))
;;                        (concat "%" (number-to-string (max w 3)) "d|"))
;;                      line)
;;                     'face 'linum)))
;; (global-linum-mode nil)
;; (setq linum-disabled-modes-list
;;       '(term-mode eshell-mode wl-summary-mode compilation-mode erc-mode org-mode))
;; (defun linum-on ()
;;   (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
;;       (linum-mode 1)))
;; }}}

;; {{{ enable advanced buffer managment 
(require 'bs)
(require 'ibs)
;; }}}

;; {{{ Highlight parentheses 
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
;; }}}

;; {{{ TODO: Highlight Current Line 
;(add-search-path "site-lisp/highlight-current-line")
;(require 'highlight-current-line)
;(highlight-current-line-on t)
;(setq highlight-current-line-ignore-regexp
;      (concat "*ansi-term\\|"
;              "*eshell\\|"
;              highlight-current-line-ignore-regexp))
;; }}}

;; Chinese Input method for linux
;; disabled ibus
;; (if (eq system-type 'gnu/linux)
;;     (list
;;      (add-search-path "site-lisp/ibus")
;;      (require 'ibus)
;;      (add-hook 'after-init-hook 'ibus-mode-on)
;;      (setq ibus-agent-file-name (concat conf-root-dir
;;                                         "/site-lisp/ibus/ibus-el-agent"))
;;      ))

;; enable winner-mode
(winner-mode t)

;; {{{ layout-restore 
;;(add-search-path "site-lisp/layout-restore")
;; (require 'layout-restore)
;; }}}

;; {{{ golden ratio 
(add-search-path "site-lisp/golden-ratio")
(require 'golden-ratio)
(golden-ratio-enable)
;; }}}

(provide 'ysl-ui)
