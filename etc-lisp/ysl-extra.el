;; {{{ motd 
(defvar ysl/motd (concat user-home-dir "/.motd.el"))
(defun ysl/show-motd ()
  (let ((scratch-buffer (get-buffer "*scratch*")))
    (with-current-buffer scratch-buffer
      (insert-file-contents ysl/motd)
      (goto-char (point-max)))))
(if (file-exists-p ysl/motd)
  (add-hook 'emacs-startup-hook 'ysl/show-motd))
;; }}}

;; {{{ highlight leading and trailing whitespaces 

(defface ysl/font-lock-leading-whitespace-face
  `((t (:background "#1f1f1f")))
  "Face for leading whitespaces")

(defface ysl/font-lock-trailing-whitespace-face
  `((t (:background "#1f1f1f")))
  "Face for leading whitespaces")

(defun ysl/set-whitespace-detection (mode)
  "highlight heading or trailing whitespaces and characters over 80th column"
  (font-lock-add-keywords
   mode
   '(; ("\t+" (0 'ysl/font-lock-leading-whitespace-face append))
     ("^\s+$" (0 'ysl/font-lock-leading-whitespace-face append))
     ("\s+$" (0 'ysl/font-lock-leading-whitespace-face append))
     ("^.\\{80\\}\\(.+\\)$" (1 'ysl/font-lock-trailing-whitespace-face append)))))

(defun ysl/set-whitespace-detection-mode (modes)
  (loop for mode in modes do (ysl/set-whitespace-detection mode)))

;; }}}

;; {{{ Useful functions 
(defun ysl/switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer)))

(defun ysl/curl-dict-cn ()
"look up current word in dict.cn online dictionary"
  (interactive)
  (message
   (replace-regexp-in-string
   "<[^>]+>" " "
   (reduce 'concat
           (remove-if-not (lambda(s) (numberp (string-match "<key\\|<def" s)))
                          (split-string
                           (shell-command-to-string
                            (concat
                             "curl -s 'http://api.dict.cn/ws.php?utf8=true&q="
                             (current-word) "'")) "\n"  t)
                          )))))

(defun ysl/insert-dict-cn ()
  "look up current word in dict.cn online dictionary"
  (interactive)
  (insert
   (concat " :: "
          (replace-regexp-in-string
           "<[^>]+>" " "
           (reduce 'concat
                   (remove-if-not (lambda(s) (numberp (string-match "<def" s)))
                                  (split-string
                                   (shell-command-to-string
                                    (concat
                                     "curl -s 'http://api.dict.cn/ws.php?utf8=true&q="
                                     (current-word) "'")) "\n"  t)
                                  ))))))

(defun ysl/star-dict-collins ()
  "look up current word in star-dict collins advanced learner's dictionary"
  (interactive)
  (let ((my-current-word (current-word))
        (minibuffer-message-timeout nil))
    (with-current-buffer (get-buffer-create "*Star-Dict*")
       (erase-buffer)
       (insert (shell-command-to-string
                (concat "sdcv -n '" my-current-word "'")))
       (w3m-buffer)
       (minibuffer-message (buffer-string)))))

(defun ysl/clone-last-line()
"duplicate last line in current line"
  (interactive)
  (previous-line)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(defun ysl/goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

;; }}}


(defun ysl/copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(defun ysl/region-to-checklist (rbegin rend)
  (interactive "r")
  (replace-regexp "^\s*" "- [ ] " nil rbegin rend))

;; COPIED FROM  http://www.emacswiki.org/emacs/RevertBuffer
(defun ysl/revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

;; compile & upload arscons
(defun compile-arscons ()
  (interactive)
  (compile "scons ARDUINO_PORT=/dev/ttyACM0 upload"))

;; get color code from tomorrow theme
(defun ysl/get-tomorrow-color (theme color)
  (cdr (assoc color (cdr (assoc theme color-theme-tomorrow-colors)))))


(defun djcb-find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))

;; {{{ http://www.emacswiki.org/cgi-bin/wiki/ToggleWindowSplit 
(defun toggle-frame-split ()
  "If the frame is split vertically, split it horizontally or vice versa.
Assumes that the frame is only split into two."
  (interactive)
  (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
  (let ((split-vertically-p (window-combined-p)))
    (delete-window) ; closes current window
    (if split-vertically-p
        (split-window-horizontally)
      (split-window-vertically)) ; gives us a split with the other window twice
    (switch-to-buffer nil))) ; restore the original window in this part of the frame

;; I don't use the default binding of 'C-x 5', so use toggle-frame-split instead
(global-set-key (kbd "C-x 5") 'toggle-frame-split)

;; }}}
(provide 'ysl-extra)
