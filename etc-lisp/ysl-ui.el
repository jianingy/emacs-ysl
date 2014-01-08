(require 'ysl-init)
(require 'ysl-font)
(require 'generic-x)

;; bookmark
(setq bookmark-save-flag 1)

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

;; {{{ enable advanced buffer managment
(require 'bs)

(add-to-list 'bs-configurations
             '("terminals"
               "^\\*shell:" nil
               nil nil
               bs-sort-buffer-interns-are-last))

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

;; {{{ highlight-tail
;; (require 'highlight-tail)
;; (let ((background (cdr (assoc
;;                         'background
;;                         (cdr (assoc 'night color-theme-tomorrow-colors))))))
;;   (setq highlight-tail-colors `((,background . 0)
;;                                 ("#4271ae" . 25)
;;                                 (,background . 66))))
;; (highlight-tail-mode)
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

;; enable window numbering mode
(require 'window-numbering)
(window-numbering-mode)

;; enable winner-mode
(winner-mode t)

;; {{{ layout-restore
;;(add-search-path "site-lisp/layout-restore")
;; (require 'layout-restore)
;; }}}

;; {{{ golden ratio
;; (add-search-path "site-lisp/golden-ratio")
;; (require 'golden-ratio)
;; (golden-ratio-enable)
;; }}}

;; {{{ bm
(require 'bm)
(set-face-background bm-face "#de935f")
;; }}}

;; {{{ lambda mode
(require 'lambda-mode)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(add-hook 'python-mode-hook (lambda () (lambda-mode 1)))
;; }}}


(provide 'ysl-ui)
