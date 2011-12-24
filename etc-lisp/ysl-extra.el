;; highlight leading and trailing whitespaces {{

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
   '(("\t+" (0 'ysl/font-lock-leading-whitespace-face append))
     ("^\s+$" (0 'ysl/font-lock-leading-whitespace-face append))
     ("\s+$" (0 'ysl/font-lock-leading-whitespace-face append))
     ("^.\\{80\\}\\(.+\\)$" (1 'ysl/font-lock-trailing-whitespace-face append)))))

(defun ysl/set-whitespace-detection-mode (modes)
  (loop for mode in modes do (ysl/set-whitespace-detection mode)))

;; }}

;; Useful functions {{
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

;; }}


(defun ysl/copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(defun ysl/region-to-checklist (rbegin rend)
  (interactive "r")
  (replace-regexp "^\s*" "- [ ] " nil rbegin rend))

(provide 'ysl-extra)
