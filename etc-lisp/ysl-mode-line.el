;; use setq-default to set it for /all/ modes
;; COPIED FROM http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
(require 'ysl-init)

(defvar foundnewmbox "") ;; mail notification

(custom-set-variables
 '(mode-line-format
   (list
    "  "
    "%z:"
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize " %b " 'face 'font-lock-keyword-face
                        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
    (propertize "%02l" 'face 'font-lock-type-face) ","
    (propertize "%02c" 'face 'font-lock-type-face)
    ") "

    ;; relative position, size of file
    "("
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    ") "

    ;; the current major mode for the buffer.
    "["
    '(:eval (propertize "%m" 'face 'font-lock-keyword-face
                        'help-echo buffer-file-coding-system))
    minor-mode-alist
    "] "


    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
                        'face 'font-lock-preprocessor-face
                        'help-echo (concat "Buffer is in "
                                           (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
              (concat " "  (propertize "Mod"
                                       'face 'font-lock-warning-face
                                       'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat " "  (propertize "RO"
                                       'face 'font-lock-type-face
                                       'help-echo "Buffer is read-only"))))

    (propertize "%n" 'face 'font-lock-constant-face 'help-echo "Buffer is narrowed")

    "] "

    '(:eval (when org-clock-current-task
              (concat "-== " (propertize org-clock-current-task
                          'face 'font-lock-constant-face) " ==- ")))


    ;; add the time, with the date and the emacs uptime in the tooltip
    '(:eval (propertize (format-time-string "%H:%M")
                        'help-echo
                        (concat (format-time-string "%c; ")
                                (emacs-uptime "Uptime:%hh"))))

    " "
    '(:eval (propertize foundnewmbox 'face 'flymake-errline))
    ;; i don't want to see minor-modes; but if you want, uncomment this:

    "% " ;; fill with '-'
    )))

(provide 'ysl-mode-line)
