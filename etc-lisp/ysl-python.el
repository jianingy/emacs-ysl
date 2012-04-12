(require 'ysl-init)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)

(defvar ysl/python-active-virtualenv "default")
(defvar ysl/python-executable "/usr/bin/python")
(defvar ysl/python-syntax-checker "/usr/bin/pychecker")
(add-hook 'python-mode-hook
          '(lambda () (progn
;                        (unless (eq buffer-file-name nil) (flymake-mode))
                        (setq py-indent-offset 4
                              py-smart-indentation nil
                              indent-tabs-mode nil)
                        (set (make-local-variable 'compilation-scroll-output) nil)
                        (set (make-local-variable 'virtualenv-workon-starts-python) nil)
                        (local-set-key "\C-m" 'newline-and-indent)
                        (local-set-key "\C-d" 'py-help-at-point)

                        ;; initialize virtualenv
                        (require 'virtualenv)
                        (if ysl/python-active-virtualenv
                            (progn
                              (virtualenv-minor-mode-on)
                              (virtualenv-workon ysl/python-active-virtualenv)))

                        ;; Initialize Pymacs
                        (autoload 'pymacs-apply "pymacs")
                        (autoload 'pymacs-call "pymacs")
                        (autoload 'pymacs-eval "pymacs" nil t)
                        (autoload 'pymacs-exec "pymacs" nil t)
                        (autoload 'pymacs-load "pymacs" nil t)

                        ;; Initialize Rope
                        (setq ropemacs-enable-shortcuts nil)
                        (setq ropemacs-local-prefix "C-c C-p")
                        ;; Stops from erroring if there's a syntax err
                        (setq ropemacs-codeassist-maxfixes 3)
                        (setq ropemacs-guess-project t)
                        (setq ropemacs-enable-autoimport t)
                        (setq ropemacs-confirm-saving 'nil)

                        (ac-ropemacs-setup)

                        (set (make-local-variable 'ac-sources)
                             (append ac-sources '(ac-source-yasnippet
                                                  ac-source-rope)))
                        (set (make-local-variable 'ac-find-function)
                             'ac-python-find)
                        (set (make-local-variable 'ac-candidate-function)
                             'ac-python-candidate)


                        ;; Adding hook to automatically open a rope project if
                        ;; there is one in the current or in the upper level
                        ;; directory
                        ;; (python-auto-fill-comments-only)
                        (cond ((file-exists-p ".ropeproject")
                               (rope-open-project default-directory))
                              ((file-exists-p "../.ropeproject")
                               (rope-open-project (concat default-directory ".."))))
                        )))


; compile python code {{
(defun compile-python ()
  "Use compile to run python programs"
  (interactive)
  (if ysl/python-active-virtualenv
      (compile (concat "python"
                       " " (buffer-file-name)))
    (compile (concat ysl/python-executable " " (buffer-file-name))))
  (switch-window))
(define-key python-mode-map (kbd "C-c C-c") 'compile-python)
;; }}


;; Autofill inside of comments
(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
       (setq value (cons (format "%s%s" prefix element) value))))))

(defun ac-ropemacs-require ()
  (with-no-warnings
    (unless ac-ropemacs-loaded
      (pymacs-load "ropemacs" "rope-")
      (if (boundp 'ropemacs-enable-autoimport)
          (setq ropemacs-enable-autoimport t))
      (setq ac-ropemacs-loaded t))))

(defun ac-ropemacs-setup ()
  (ac-ropemacs-require)
  (setq ac-sources (append (list 'ac-source-ropemacs) ac-sources))
  (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))


;; setup flymake {{
(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list ysl/python-syntax-checker  (list local-file))))
;; }}

(provide 'ysl-python)
