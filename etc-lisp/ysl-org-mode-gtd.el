(require 'ysl-extra)

;; {{{ Basic Settings
; task juggler settings
(setq org-taskjuggler-project-tag "PROJECT"
      org-taskjuggler-resource-tag "RESOURCE"
      org-taskjuggler-report-tag "REPORT")

; Remind things those deadline are in 15 days
(setq org-deadline-warning-days 15)

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%65ITEM(Task) %20TAGS %Effort(Effort){:} %CLOCKSUM")

; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 1:30 2:00 4:00 8:00"))))


;; }}}

;; {{{ WORK FLOW SETTING

;; {{{ TODO KEYWORDS
;;; Workflow:
;;; TODO: A thing need to be done
;;; NEXT: A thing need to be done ASAP
;;; STARTED: Task on the go
;;; DONE: Task finished
;;; WAITING: Pending due to some reason
;;; CANCELLED: Cancelled due to some reason
;;; MEETING: Interrupted Meetings
;;; CHECK: Check the progress of someone else
;;; VERIFIED: Well done
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")
              (sequence "CHECK(k)" "|" "VERIFIED(v!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "#cc6666" :weight normal)
              ("NEXT" :foreground "#de935f" :weight normal)
              ("STARTED" :foreground "#8abeb7" :weight normal)
              ("DONE" :foreground "#b5bd68" :weight normal)
              ("WAITING" :foreground "#de935f" :weight bold)
              ("MEETING" :foreground "#b294bb" :weight normal)
              ("CANCELLED" :foreground "#b5bd68" :weight normal)
              ("CHECK" :foreground "#f0c674" :weight normal)
              ("VERIFIED" :foreground "#de935f" :weight normal))))

;; todo state trigger
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              (done ("WAITING"))
              ("TODO" ("WAITING") ("CANCELLED"))
              ("NEXT" ("WAITING") ("CANCELLED"))
              ("STARTED" ("WAITING") ("CANCELLED"))
              ("DONE" ("WAITING") ("CANCELLED")))))
;;; }}}

;; {{{ Tags with fast selection keys
;;; OFFICE: things can only be done at office
;;; HOME: things can only be done at homne
;;; COMPUTER: things can be done using a computer
;;; STADIUM: things can only be done in a stadium
;;; PHONE: things need to communicate with others
;;; ---
;;; MAYBE: things may be done on someday
(setq org-tag-alist (quote ((:startgroup)
                            ("@HOME" . ?h)
                            ("@WORK" . ?w)
                            ("@STADIUM" . ?s)
                            (:endgroup)
                            ("ADTIME" . ?a)
                            ("PERSONAL" . ?p)
                            ("TAOBAO" . ?t)
                            ("MAYBE" . ?m)
                            ("USTACK" . ?u))))
;;; }}}

;; }}}

;; {{{ Capture templates
(defvar ysl/org-base-directory "~/notes/")
(defvar ysl/org-default-schedule-file "schedule/default.org")
(defvar ysl/org-default-note-file "kb/note.org")
(defvar ysl/org-default-solution-file "kb/solution.org")
(setq org-reverse-note-order t)
(setq org-capture-templates
      (quote (("t" "TODO" entry (file (concat ysl/org-base-directory ysl/org-default-schedule-file))
               "* TODO %?\n%U\n%a\n  %i" :clock-in nil :clock-resume t :prepend t)
              ("c" "CHECK" entry (file (concat ysl/org-base-directory ysl/org-default-schedule-file))
               "* CHECK %? \n%U\n%a\n  %i" :clock-in nil :clock-resume t :prepend t)
              ("m" "MEETING" entry (file (concat ysl/org-base-directory ysl/org-default-schedule-file))
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t :prepend t)
              ("n" "NOTE" entry (file (concat ysl/org-base-directory ysl/org-default-note-file))
               "* %?\n%U\n%i" :clock-in nil :clock-resume t :prepend t)
              ("s" "SOLUTION" entry (file (concat ysl/org-base-directory ysl/org-default-solution-file))
               "* %?\n%U\n\n** description\n%x\n\n** solution\n\n** environment\n\n** analysis\n\n"
               :clock-in nil :clock-resume t :prepend t)
              ("h" "HABIT" entry (file (concat ysl/org-base-directory ysl/org-default-schedule-file))
               "* NEXT %?\n%a\nSCHEDULED: %t\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n  %i\n%U"))))
;;; }}}

;; {{{ Agenda Files
(defvar ysl/org-agenda-files (quote ("~/notes/schedule")))
(setq org-agenda-files ysl/org-agenda-files)
;;; }}}

;; {{{ Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("r" "Tasks to Refile" tags "+REFILE"
               ((org-agenda-overriding-header "Notes and Tasks to Refile")
                (org-agenda-overriding-header "Tasks to Refile")))
              ("s" "Self Agenda"
               ((agenda ""
                        ((org-agenda-ndays 7)
                        (org-agenda-repeating-timestamp-show-all t)
                        (org-agenda-skip-function (ysl/org-agenda-skip-tag "PERSONAL"))
                        (org-agenda-overriding-header "Personal Agenda:")))
                (tags-todo "+PERSONAL/STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-view-columns-initially t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down))))
                (tags-todo "-WAITING-CANCELLED-NOTRACK/!NEXT"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "+PERSONAL-MAYBE/-STARTED-HOLD"
                           ((org-agenda-overriding-header "Recently Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-view-columns-initially t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down))))
                (tags-todo "+PERSONAL/WAITING|HOLD"
                           ((org-agenda-overriding-header "Pending Tasks")
                            (org-agenda-overriding-columns-format "%80ITEM %DEADLINE")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down)))
                (tags-todo "+PERSONAL+MAYBE"
                           ((org-agenda-overriding-header "Future Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-view-columns-initially t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down)))))))
              ("w" "Work Agenda"
               ((agenda ""
                        ((org-agenda-ndays 7)
                        (org-agenda-repeating-timestamp-show-all t)
                        (org-agenda-skip-function (ysl/org-agenda-skip-tag "WORK"))
                        (org-agenda-overriding-header "Work Agenda:")))
                (tags-todo "-REFILE-CANCELLED-MAYBE/!CHECK"
                           ((org-agenda-overriding-header "Checking Issues")
                            (org-agenda-overriding-columns-format "%80ITEM %DEADLINE")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(effort-up category-keep))))
                (todo "+WORK/WAITING|HOLD"
                      ((org-agenda-overriding-header "Waiting and Postponed tasks")))
                (tags-todo "+WORK+allocate=\"jianingy\"-REFILE-CANCELLED/!-NEXT-STARTED-WAITING"
                           ((org-agenda-overriding-header "My Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "+WORK-REFILE-CANCELLED/!-NEXT-STARTED-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))))
              ("a" "Default Agenda"
               ((agenda ""
                        ((org-agenda-ndays 1)
                         (org-agenda-priority '(priority-up effort-down))))
                (tags-todo "-WAITING-CANCELLED-NOTRACK/!STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-WAITING-CANCELLED-NOTRACK/!NEXT"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-MAYBE-NOTRACK/!-STARTED-HOLD-NEXT"
                           ((org-agenda-overriding-header "Time Insensitive Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags "LEVEL=1+REFILE-NOTRACK"
                      ((org-agenda-overriding-header "Notes and Tasks to Refile")
                       (org-agenda-overriding-header "Tasks to Refile")))
                (todo "CLOSED"
                      ((org-agenda-overriding-header "Closed tasks")))
                (tags-todo "+MAYBE-REFILE-CANCELLED-NOTRACK/!-NEXT-STARTED-WAITING"
                           ((org-agenda-overriding-header "Future Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags "-REFILE-PROJECT-NOTRACK/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks))))
               nil))))
;;; }}}

;; {{{ functions
(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (let ((next-headline (save-excursion (outline-next-heading))))
    ;; Consider only tasks with done todo headings as archivable candidates
    (if (member (org-get-todo-state) org-done-keywords)
        (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
               (daynr (string-to-int (format-time-string "%d" (current-time))))
               (a-month-ago (* 60 60 24 (+ daynr 1)))
               (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
               (this-month (format-time-string "%Y-%m-" (current-time)))
               (subtree-is-current (save-excursion
                                     (forward-line 1)
                                     (and (< (point) subtree-end)
                                          (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
          (if subtree-is-current
              subtree-end ; Has a date in this month or last month, skip it
            nil))  ; available to archive
      (or next-headline (point-max)))))

(defmacro ysl/org-agenda-skip-tag (tag)
  `(lambda ()
     "Skip certain tags"
     (let ((next-headline (save-excursion (outline-next-heading))))
       (if (member ,tag (org-get-tags-at))
           nil          ; tag found, do not skip
         (or next-headline (point-max)))))) ; tag not found, continue after end of subtree
;;; }}}


;; {{{ bh functions for punch in and punch out
(defvar bh/keep-clock-running nil)

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
                                        ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find bh/organization-task-id 'marker)
      (org-clock-in '(16)))))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at (or parent-task)
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(add-hook 'org-agenda-mode-hook '(lambda () (org-defkey org-agenda-mode-map "\C-c\C-x<" 'bh/set-agenda-restriction-lock) 'append))

(defun bh/set-agenda-restriction-lock (arg)
  "Set restriction lock to current subtree or file if prefix is specified"
  (interactive "p")
  (let* ((pom (org-get-at-bol 'org-hd-marker))
         (tags (org-with-point-at pom (org-get-tags-at))))
    (let ((restriction-type (if (equal arg 4) 'file 'subtree)))
      (cond
       ((equal major-mode 'org-agenda-mode)
        (org-with-point-at pom
          (org-agenda-set-restriction-lock restriction-type)))
       ((and (equal major-mode 'org-mode) (org-before-first-heading-p))
        (org-agenda-set-restriction-lock 'file))
       (t
        (org-with-point-at pom
          (org-agenda-set-restriction-lock restriction-type)))))))

;; }}}

;; {{{ punch-in/out on screensaver
(require 'dbus)

(defun ysl/org-check-in-out-on-screensaver (p-screen-locked)
  (if p-screen-locked
      (progn
        (bh/punch-out)
        (message "punch-out because screen is locked"))
    (progn
      (bh/punch-in 0)
      (message "punch-in because screen is unlocked"))))

(if (eq system-type 'gnu/linux)
    (condition-case nil
        (dbus-register-signal :session "org.gnome.ScreenSaver"
                              "/org/gnome/ScreenSaver"
                              "org.gnome.ScreenSaver"
                              "ActiveChanged"
                              'ysl/org-check-in-out-on-screensaver)
      (error nil)))

;; }}}

;; {{{ autosave agenda files
;(add-hook 'org-mode-hook 'my-org-mode-autosave-settings)
;(defun my-org-mode-autosave-settings ()
;  (set (make-local-variable 'auto-save-visited-file-name) t)
;  (setq auto-save-interval 5))
;; }}}

(provide 'ysl-org-mode-gtd)
