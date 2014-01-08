
(setq
 tab-width 8                         ;; default tab width
 fill-column 78                      ;; default column width
 mouse-yank-at-point t               ;; dont insert at mouse point
 kill-ring-max 128                   ;; size of killing ring
 enable-recursive-minibuffers t      ;; [FINDOUT]
 frame-title-format "emacs@%b")      ;; display buffer name at title bar

(set-language-environment 'UTF-8)    ;; set default charset UTF-8
(mouse-avoidance-mode 'animate)      ;; move away mouse pointer while the
                                     ;; the cursor is near it
(fset 'yes-or-no-p 'y-or-n-p)        ;; use y/n instead of yes/no
(setq-default major-mode 'text-mode) ;; set major-mode
(setq confirm-kill-emacs 'y-or-n-p)    ;; ask confirmation to quit emacs

;; {{{ highlight instead of jumping to matched parenthes
(setq show-paren-style 'parentheses)
(show-paren-mode t)
;; }}}

;; {{{ Chinese Sentence Ending Characters
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;; }}}

;; {{{ scroll one line at a time (less "jumpy" than defaults)
(setq
 mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; scroll one line at a time
 mouse-wheel-progressive-speed nil            ;; don't acceleratescrolling
 mouse-wheel-follow-mouse 't                  ;; scroll window under mouse
 scroll-step 1                                ;; scroll one line at a time
 scroll-margin 3
 scroll-up-aggressively 0.01
 scroll-down-aggressively 0.01
 scroll-conservatively 10000)
;; }}}

;; --- enable prohibitive functions
(put 'narrow-to-region 'disabled nil)  ;; narrow-mode

;; {{{ enable ido: InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-max-directory-size 100000)
;; }}}

;; {{{ enable tramp: Transparent Remote Access, Multiple Protocols
(require 'tramp)
(setq tramp-default-method "rsync")
;; set default method to ssh if we are running on Unix-like system
(cond ((or (eq system-type 'gnu/linux) (eq system-type 'darwin))
       (setq tramp-default-method "ssh")))
;; }}}

;; {{{ enable auto-complete, yasnippet
(require 'ysl-auto-complete)
(require 'ysl-yasnippet)
;; }}}

;; {{{ enable session
;; added open-recently to menu
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;; }}}

;; Making C-c C-c end a emacsclient session
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (local-set-key (kbd "C-c C-c") 'server-edit)))

;; require word count module
(require 'wc)

;This is for general text mode behaviour

(setq fill-column 79)

;; {{{ layout-restore
;(require 'layout-restore)
;(setq layout-restore-after-switchbuffer nil)
;(setq layout-restore-after-killbuffer nil)
;(setq layout-restore-after-otherwindow nil)
;; }}}

;; {{{ wrap-region
(require 'wrap-region)
(wrap-region-global-mode t)
;; }}}

;; {{{ autopair
;; disable it since it conflicts with wrap-region
;; (autopair-global-mode t)
;; }}}

(provide 'ysl-editing)
