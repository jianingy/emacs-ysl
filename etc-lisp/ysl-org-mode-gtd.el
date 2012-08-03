;; Basic Settings {{
; Remind things those deadline are in 15 days
(setq org-deadline-warning-days 15)

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%65ITEM(Task) %20TAGS %Effort(Effort){:} %CLOCKSUM")

; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 1:30 2:00 4:00 8:00"))))


;; }}

;; WORK FLOW SETTING {{

;;; TODO KEYWORDS {{{
;;; Workflow:
;;; TODO: A thing need to be done
;;; NEXT: A dependent thing have to be done in order to
;;;       make progress in a project
;;; STARTED: Task be working on
;;; DONE: Task finished
;;; WAITING: Pending due to some reason
;;; HOLD:
;;; CANCELLED: Cancelled due to some reason
;;; OPEN: An issue need to be resolved
;;; CLOSED: An resolved issued
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h!)" "|" "CANCELLED(c@/!)")
              (sequence "OPEN(O!)" "CHECK(K)" "|" "CLOSED(C!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "orange" :weight bold)
              ("STARTED" :foreground "steelblue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("OPEN" :foreground "lightblue" :weight bold)
              ("CHECK" :foreground "yellow" :weight bold)
              ("CLOSED" :foreground "forest green" :weight bold))))

;; todo state trigger
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("STARTED" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
;;; }}}

;;; Tags with fast selection keys {{{
;;; OFFICE: things can only be done at office
;;; HOME: things can only be done at homne
;;; COMPUTER: things can be done using a computer
;;; STADIUM: things can only be done in a stadium
;;; PHONE: things need to communicate with others
;;; ---
;;; MAYBE: things may be done on someday
;;; IMPORTANT: an important thing
;;; NOTE: it is a note
(setq org-tag-alist (quote ((:startgroup)
                            ("@OFFICE" . ?o)
                            ("@HOME" . ?h)
                            ("@COMPUTER" . ?c)
                            ("@STADIUM" . ?s)
                            ("@PHONE" . ?p)
                            (:endgroup)
                            ("PERSONAL" . ?l)
                            ("WORK" . ?w)
                            ("MAYBE" . ?m)
                            ("IMPORTANT" . ?i)
                            ("NOTE" . ?n))))
;;; }}}

;; }}

;;; Capture templates {{{
(defvar ysl/default-gtd-org "~/org/gtd/default.org")
(setq org-capture-templates
      (quote (("t" "TODO" entry (file ysl/default-gtd-org)
               "* TODO %?\n%U\n%a\n  %i" :clock-in nil :clock-resume t)
              ("n" "NEXT" entry (file "~/org/default.org")
               "* NEXT %? \n%U\n%a\n  %i" :clock-in nil :clock-resume t)
              ("c" "CHECK" entry (file "~/org/default.org")
               "* CHECK %? \n%U\n%a\n  %i" :clock-in nil :clock-resume t)
              ("s" "SOMEDAY" entry (file "~/org/default.org")
               "* SOMEDAY %? \n%U\n%a\n  %i" :clock-in nil :clock-resume t)
              ("h" "HABIT" entry (file "~/org/default.org")
               "* NEXT %?\n%a\nSCHEDULED: %t\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n  %i\n%U"))))
;;; }}}

;;; Agenda Files {{{
(defvar ysl/org-agenda-files (quote ("~/org/gtd")))
(setq org-agenda-files ysl/org-agenda-files)
;;; }}}

;;; Custom agenda command definitions {{{
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
                (tags-todo "+PERSONAL-MAYBE/-STARTED"
                           ((org-agenda-overriding-header "Recently Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-view-columns-initially t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down))))
                (tags-todo "+PERSONAL+MAYBE"
                           ((org-agenda-overriding-header "Future Tasks")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-view-columns-initially t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down))))
                (tags-todo "+PERSONAL/WAITING|HOLD"
                           ((org-agenda-overriding-header "Pending Tasks")
                            (org-agenda-overriding-columns-format "%80ITEM %DEADLINE")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down priority-down))))))
              ("w" "Work Agenda"
               ((agenda ""
                        ((org-agenda-ndays 7)
                        (org-agenda-repeating-timestamp-show-all t)
                        (org-agenda-skip-function (ysl/org-agenda-skip-tag "WORK"))
                        (org-agenda-overriding-header "Work Agenda:")))
                (tags-todo "+WORK-WAITING-CANCELLED/!NEXT|STARTED"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-overriding-columns-format "%80ITEM %DEADLINE")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-MAYBE/!CHECK"
                           ((org-agenda-overriding-header "Checking Issues")
                            (org-agenda-overriding-columns-format "%80ITEM %DEADLINE")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-MAYBE/!OPEN"
                           ((org-agenda-overriding-header "Opening Issues")
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
               ((agenda "" nil)
                (tags "LEVEL=1+REFILE-NOTRACK"
                      ((org-agenda-overriding-header "Notes and Tasks to Refile")
                       (org-agenda-overriding-header "Tasks to Refile")))
                (tags-todo "-WAITING-CANCELLED-NOTRACK/!STARTED"
                           ((org-agenda-overriding-header "Started Tasks")
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-MAYBE-NOTRACK/!-STARTED-WAITING"
                           ((org-agenda-overriding-header "Recently Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "+MAYBE-REFILE-CANCELLED-NOTRACK/!-NEXT-STARTED-WAITING"
                           ((org-agenda-overriding-header "Future Tasks")
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (todo "WAITING-NOTRACK|HOLD"
                      ((org-agenda-overriding-header "Waiting and Postponed tasks")))
                (tags "-REFILE-PROJECT-NOTRACK/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks))))
               nil))))
;;; }}}

;;; functions {{{
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


;; bh functions for punch in and punch out {{
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

;; }}

;; punch-in/out on screensaver {{
(require 'dbus)

(defun ysl/org-check-in-out-on-screensaver (p-screen-locked)
  (if p-screen-locked
      (progn
        (bh/punch-out)
        (message "punch-out since screen is locked"))
    (progn
      (bh/punch-in 0)
      (message "punch-in since screen is unlocked"))))

(dbus-register-signal :session "org.gnome.ScreenSaver" "/org/gnome/ScreenSaver"
                      "org.gnome.ScreenSaver" "ActiveChanged"
                      'ysl/org-check-in-out-on-screensaver)

;; }}

(provide 'ysl-org-mode-gtd)
