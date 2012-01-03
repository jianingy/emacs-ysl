(if (eq system-type 'darwin)
    (custom-set-faces
;;     '(default ((t (:weight semi-bold :height 160 :family "Consolas"))))
     '(tabbar-default ((t (:weight thin :height 80
                                   :family "PF Tempesta Seven")))))
  (custom-set-faces
;;   '(default ((t (:weight semi-bold :height 120 :family "Consolas"))))
   '(tabbar-default ((t (:weight thin :height 60
                                 :family "PF Tempesta Seven"))))))

;; font setup function {{
(defun ysl/set-x-font ()
  (set-face-attribute 'default nil :font ysl/x-font-en)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset ysl/x-font-zh))
)
;; }}

(if window-system
    (ysl/set-x-font))
(provide 'ysl-font)
