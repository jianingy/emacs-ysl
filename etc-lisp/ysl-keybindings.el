;; ===========================================================================
;; Yasnippet
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)

;; 全局快捷键设置
(global-set-key [(control =)] 'tabbar-forward)
(global-set-key [(control -)] 'tabbar-backward)
;(global-set-key (kbd "C-,") 'tabbar-backward-group)
;(global-set-key (kbd "C-.") 'tabbar-forward-group)

(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-x\C-a" 'ysl/switch-to-previous-buffer)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\M-g" 'goto-line) ;; goto line
(global-set-key "\C-cd" 'ysl/star-dict-collins) ;; 查字典
(global-set-key "\C-c\C-x\C-c" 'comment-region)
(global-set-key "\C-c\C-x\C-d" 'uncomment-region)
(global-set-key "\C-c\C-d" 'ysl/clone-last-line) ;; 复制上一行内容
(global-set-key "\C-cq" 'ysl/goto-match-paren) ;; 找到匹配的括号
(global-set-key "\C-cww" 'ysl/insert-dict-cn)
;;(global-set-key (kbd "C-c l") 'ysl/copy-line) ;; 拷贝当前行
(global-set-key (kbd "C-z") 'switch-to-eshell)
;;
(global-set-key "\C-c\C-\\" 'winner-undo)
;; Org-mode Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "C-<escape>") 'org-clock-goto)
(global-set-key (kbd "C-M-r") 'org-capture)



(setq outline-minor-mode-prefix [(control o)])

;; ---- 功能键 - Dirk的按键，感受一下
; F1进入shell
(global-set-key [C-s-escape] '(lambda ()
                                (interactive)
                                (ansi-term "/bin/bash" "terminal")))
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
(global-set-key [C-f12] 'menu-bar-mode)            ; F12显示／隐藏菜单
(global-set-key [C-return] 'kill-buffer-and-window)      ; Kill & Close Current Buffer

(provide 'ysl-keybindings)

