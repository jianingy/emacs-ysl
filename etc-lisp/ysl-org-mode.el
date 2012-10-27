(require 'ysl-init)
(require 'org-location-google-maps nil t)
;; set tool path {{
(setq user-local-lib (concat user-home-dir "/local/lib"))
(defvar ysl/org-pygment-path
  (cond
   ((file-executable-p "/usr/local/bin/pygmentize")
    "/usr/local/bin/pygmentize")
   (t "/usr/bin/pygmentize")
   ))

(defvar ysl/org-twopi-path
  (cond
   ((file-executable-p "/usr/local/bin/twopi")
    "/usr/local/bin/twopi")
   (t "/usr/bin/twopi")
   ))
(defvar ysl/org-ditaa-jar-path (concat user-local-lib "/java/ditaa.jar"))
(defvar ysl/org-plantuml-jar-path (concat user-local-lib "/java/plantuml.jar"))
;; }}

;; fixed 'tab' key conflicts with yasnippet {{
(if (featurep 'yasnippet)
    (progn
      (defun yas/org-very-safe-expand ()
        (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
      (add-hook 'org-mode-hook
                (lambda ()
                  (make-variable-buffer-local 'yas/trigger-key)
                  ;; (highlight-current-line-on nil)
                  (setq yas/trigger-key [tab])
                  (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                  (auto-fill-mode)
                  (define-key yas/keymap [tab] 'yas/next-field)))))
;; }}

;; Basic Settings {{
(defvar ysl/default-notes-file "~/org/notes.org")
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-confirm-babel-evaluate nil
      org-export-htmlize-output-type 'css
      org-default-notes-file ysl/default-notes-file
      org-babel-temporary-directory "/tmp/babel" ;; babel directory will be clean up on exit
      org-use-fast-todo-selection t
      org-completion-use-ido t
      org-hide-leading-stars t ;; hide leading stars
      org-startup-indented t ;; indent at start
      org-enforce-todo-dependencies t ;; enable block
      org-clone-delete-id t
      org-log-done t)

;;; use xelatex for exporting pdf
(setq org-latex-to-pdf-process
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f")) ;; for multiple passes

; Targets include this file and any file contributing to the agenda - up to 2 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 (org-agenda-files :maxlevel . 2))))

; do not add a blank line before new entry
(setq org-blank-before-new-entry nil)

; Press return to follow link
(setq org-return-follows-link t)

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;; }}

;; Clock Settings {{
;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 28)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Set state to "STARTED" when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-started)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist (quote history))
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(defun bh/clock-in-to-started (kw)
  "Switch task from TODO or NEXT to STARTED when clocking in.
Skips capture tasks."
  (if (and (member (org-get-todo-state) (list "TODO" "NEXT"))
           (not (and (boundp 'org-capture-mode) org-capture-mode)))
      "STARTED"))
;; }}

;;; Babel {{
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(org-babel-do-load-languages
 'org-babel-load-languages (quote ((pygment . t)
                                   (dot . t)
                                   (twopi . t)
                                   (ditaa . t)
                                   (plantuml . t)
                                   (R . t)
                                   (latex . t)
                                   (gnuplot . t))))
;; ditaa generate {{{
(defun djcb-ditaa-generate ()
  (interactive)
  (shell-command (concat "java -jar " ysl/org-ditaa-jar-path " " buffer-file-name)))
;; }}}
(setq org-src-fontify-natively t)
;; }}

;; should be 'required' after setup {{
;; (require 'org-install) ;; deprecated
(require 'org-habit)
(require 'ob-twopi)
(require 'ob-pygment)
;; }}}


;; org-mime: send email using org-mode {{
(add-search-path "site-lisp/org-mode-contrib")
;; this one broken org-repeat
;;(require 'org-checklist)
(require 'org-mime)
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-htmlize)))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))

;; }}

;; load gtd settings {{
(require 'ysl-org-mode-gtd)
;; }}
;; load user custom settings {{
(setq ysl/org-project-file (concat user-home-dir "/.org-projects.el"))
(if (file-exists-p ysl/org-project-file)
    (load ysl/org-project-file))

(defun org-reload-project ()
  "reload project definitions"
  (interactive)
  (load-file "~/.org-projects.el"))

(defun ysl/org-publish (project &optional force)
  "fixed conflicts between auto-insert-mode, yasnippets and sitemap publishing"
  (interactive)
  (let ((prev-insert-mode auto-insert-mode))
    (if auto-insert-mode (auto-insert-mode -1))
    (org-publish project force)
    (if prev-insert-mode (auto-insert-mode t))))
;; }}

(provide 'ysl-org-mode)
