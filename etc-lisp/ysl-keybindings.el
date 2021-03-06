;; ===========================================================================
;; Yasnippet
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)

;; 全局快捷键设置
;(global-set-key [(control =)] 'tabbar-forward)
;(global-set-key [(control -)] 'tabbar-backward)
;(global-set-key (kbd "C-,") 'tabbar-backward-group)
;(global-set-key (kbd "C-.") 'tabbar-forward-group)

;; load layout key
(global-set-key "\C-c\C-l" 'layout-restore)

(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-x\C-a" 'ysl/switch-to-previous-buffer)
(global-set-key "\M-g" 'goto-line) ;; goto line
(global-set-key "\C-cd" 'ysl/ydcv) ;; 查字典
(global-set-key "\C-c\C-x\C-c" 'comment-region)
(global-set-key "\C-c\C-x\C-d" 'uncomment-region)
(global-set-key "\C-c\C-d" 'ysl/clone-last-line) ;; 复制上一行内容
(global-set-key "\C-cq" 'ysl/goto-match-paren) ;; 找到匹配的括号
(global-set-key "\C-cww" 'ysl/insert-dict-cn)
(global-set-key "\C-cv" 'mu4e)
(global-set-key (kbd "C-z") 'ysl/anything-terminals)
(global-set-key (kbd "C-x F") 'djcb-find-file-as-root)
;;
(global-set-key "\C-c\C-\\" 'winner-undo)
;; Org-mode Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-xb" 'ysl/anything-switch-to)
(global-set-key "\C-ci" 'ysl/anything-info)
(global-set-key "\C-cm" 'bm-toggle)
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cj" 'bm-next)
(global-set-key "\C-c\C-j" 'dirtree)
(global-set-key "\C-cs" 'ysl/insert-separator)
(global-set-key "\C-cg" 'grep-find)
(global-set-key "\C-c\M-m" 'message-mark-inserted-region)
(global-set-key "\C-c\M-b" 'boxquote-region)
(global-set-key "\C-o" 'ysl/occurs)

(global-set-key (kbd "C-<escape>") 'org-clock-goto)
(global-set-key (kbd "C-M-r") 'org-capture)

(setq outline-minor-mode-prefix [(control o)])

(global-set-key [C-f5] 'ysl/revert-all-buffers) ; F5 刷新全部BUFFER


;; ---- 功能键 - Dirk的按键，感受一下
; F1进入shell
;(global-set-key [C-s-escape] '(lambda ()
;                                (interactive)
;                                (ansi-term "/bin/bash" "terminal")))
;; (global-set-key [C-f2] 'split-window-horizontally) ; F2水平分割窗口
;; (global-set-key [C-f3] 'delete-other-windows)      ; F3关闭其他窗口
;; (global-set-key [C-f4] 'delete-window)             ; F4关闭当前窗口
;; (global-set-key [C-f5] 'gdb)                       ; F5调试程序
;; (global-set-key [C-f6] 'split-window-vertically)   ; F6垂直分割窗口
;; (global-set-key [C-f7] 'python-shell)              ; F7开启Python shell
;; (global-set-key [C-f8] 'other-window)              ; F8窗口间跳转
;; (global-set-key [C-f9] 'ecb-activate)              ; F9打开ecb
;; (global-set-key [C-f10] 'ecb-deactivate)           ; F10关闭ecb
;; (global-set-key [C-f11] 'speedbar)                 ; F11打开／关闭speedbar

(global-set-key (kbd "C-c 1") '(lambda () (interactive) (ysl/open-terminal "ansi-term 1")))
(global-set-key (kbd "C-c 2") '(lambda () (interactive) (ysl/open-terminal "ansi-term 2")))
(global-set-key (kbd "C-c 3") '(lambda () (interactive) (ysl/open-terminal "ansi-term 3")))




(global-set-key [C-f12] 'menu-bar-mode)            ; F12显示／隐藏菜单
(global-set-key [C-return] 'kill-buffer-and-window)      ; Kill & Close Current Buffer
(global-set-key "\C-cI" 'bh/punch-in)
(global-set-key "\C-cO" 'bh/punch-out)


(provide 'ysl-keybindings)
