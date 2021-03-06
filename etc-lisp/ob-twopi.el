;;; ob-twopi.el --- org-babel functions for twopi evaluation

;; Copyright (C) 2009, 2010  Free Software Foundation, Inc.

;; Author: Eric Schulte
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 7.3

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-Babel support for evaluating twopi source code.
;;
;; For information on twopi see http://www.graphviz.org/
;;
;; This differs from most standard languages in that
;;
;; 1) there is no such thing as a "session" in twopi
;;
;; 2) we are generally only going to return results of type "file"
;;
;; 3) we are adding the "file" and "cmdline" header arguments
;;
;; 4) there are no variables (at least for now)

;;; Code:
(require 'ob)
(require 'ob-eval)

(defvar org-babel-default-header-args:twopi
  '((:results . "file") (:exports . "results"))
  "Default arguments to use when evaluating a twopi source block.")

(defun org-babel-expand-body:twopi (body params)
  "Expand BODY according to PARAMS, return the expanded body."
  (let ((vars (mapcar #'cdr (org-babel-get-header params :var))))
    (mapc
     (lambda (pair)
       (let ((name (symbol-name (car pair)))
             (value (cdr pair)))
         (setq body
               (replace-regexp-in-string
                (concat "\$" (regexp-quote name))
                (if (stringp value) value (format "%S" value))
                body))))
     vars)
    body))

(defun org-babel-execute:twopi (body params)
  "Execute a block of Dot code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((result-params (cdr (assoc :result-params params)))
         (out-file (cdr (assoc :file params)))
         (cmdline (or (cdr (assoc :cmdline params))
                      (format "-T%s" (file-name-extension out-file))))
         (in-file (org-babel-temp-file "twopi-"))
    (cmd (concat ysl/org-twopi-path
             " " (org-babel-process-file-name in-file)
             " " cmdline
             " -o " (org-babel-process-file-name out-file))))
    (unless (file-exists-p ysl/org-twopi-path)
      (error "Could not find twopi at %s" ysl/org-twopi-path))
    (message (concat "Running twopi: " cmd))
    (with-temp-file in-file (insert body))
    (org-babel-eval cmd "")
    nil)) ;; signal that output has already been written to file

(defun org-babel-prep-session:twopi (session params)
  "Return an error because Dot does not support sessions."
  (error "Dot does not support sessions"))

(provide 'ob-twopi)

;; arch-tag: 817d0516-7b47-4f77-a8b2-2aadd8e4d0e2

;;; ob-twopi.el ends here
