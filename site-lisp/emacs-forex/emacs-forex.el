;; filename   : emacs-forex.el
;; created at : 2012-08-26 10:20:49
;; author     : Jianing Yang <jianingy.yang AT gmail DOT com>

(require 'widget)
(eval-when-compile (require 'wid-edit))

(defvar efx/widget-buffer-name "*Create A Trade Plan*")

(defvar efx/widget-alist
  "Save widget data"
  '())

(defvar efx/account-leverage
  "Account Leverage for calculation risk"
  100)

(defun efx/kill-trade-plan-buffer ()
  (interactive)
  (kill-buffer efx/widget-buffer-name))

(defun efx/generate-org-trade-plan (&rest ignore)
  "Generate a org-mode trade plan from widget inputs"
  (interactive)
  (let* ((position  (widget-value (cadr (assoc 'position efx/widget-alist))))
         (currency (widget-value (cadr (assoc 'currency efx/widget-alist))))
         (entry-point (widget-value (cadr (assoc 'entry-point efx/widget-alist))))
         (stop-loss (widget-value (cadr (assoc 'stop-loss efx/widget-alist))))
         (take-profit (widget-value (cadr (assoc 'take-profit efx/widget-alist))))
         (volume (widget-value (cadr (assoc 'volume efx/widget-alist))))
         (balance (widget-value (cadr (assoc 'balance efx/widget-alist))))
         (risk (efx/calculate-risk))
         (reward-to-risk-ratio (car risk))
         (risk-percentage (* 100 (cadr risk)))
         (rationale (widget-value (cadr (assoc 'rationale efx/widget-alist))))
         (memo (widget-value (cadr (assoc 'memo efx/widget-alist)))))
    (with-temp-buffer
      (insert (format (concat "* TODO [%s] %s \n"
                              "- Long or Short :: %s\n"
                              "- Entry Point :: %s\n"
                              "- Stop Loss :: %s\n"
                              "- Take Profit :: %s\n"
                              "- Volume :: %s\n"
                              "- Reward to Risk :: %.2f\n"
                              "- Risk Percentage :: %.2f\n"
                              "- Balance :: %s\n"
                              "\n** Rationale\n%s\n"
                              "\n** WARNINGS\n%s \n")
                      (time-stamp-string "%Y-%:m-%:d")
                      currency
                      position
                      entry-point
                      stop-loss
                      take-profit
                      volume
                      reward-to-risk-ratio
                      risk-percentage
                      balance
                      rationale
                      memo))
      (org-mode)
      (goto-char (point-min))
      (write-file (make-temp-file "my-trade-plan-"))
      (org-refile)
      (save-buffer)
      (delete-file buffer-file-name)
      (efx/kill-trade-plan-buffer))))

(defun efx/warn-risk (&rest ignore)
  "Warn about high risk trade plan"
  (interactive)
  (save-excursion
    (let* ((warnings "")
           (risk (efx/calculate-risk))
           (reward-to-risk-ratio (car risk))
           (risk-percentage (* 100 (cadr risk)))
           (memo (cadr (assoc 'memo efx/widget-alist))))
      (if (> risk-percentage 2.001)
          (setq warnings (concat warnings (format "\n- Risk Percentage is over 2 (%.2f)" risk-percentage))))
      (if (< reward-to-risk-ratio 2.999)
          (setq warnings (concat warnings (format "\n- Reward to Risk is less then 3:1 (%.2f)" reward-to-risk-ratio))))
      (widget-value-set memo warnings))))


(defun efx/calculate-risk (&rest ignore)
  "Calculate trade risk"
  (let ((position  (widget-value (cadr (assoc 'position efx/widget-alist))))
        (entry-point (string-to-number (widget-value (cadr (assoc 'entry-point efx/widget-alist)))))
        (stop-loss (string-to-number (widget-value (cadr (assoc 'stop-loss efx/widget-alist)))))
        (take-profit (string-to-number (widget-value (cadr (assoc 'take-profit efx/widget-alist)))))
        (volume (string-to-number (widget-value (cadr (assoc 'volume efx/widget-alist)))))
        (balance (string-to-number (widget-value (cadr (assoc 'balance efx/widget-alist))))))

    ;; position check
    (if (string= position "Long")
        (if (or (>= stop-loss entry-point) (<= take-profit entry-point))
            (error "Invalid S/L or T/P"))
      (if (or (<= stop-loss entry-point) (>= take-profit entry-point))
          (error "Invalid S/L or T/P")))

    ;; calcuation
    (list
     ;; reward to risk ratio
     (/ (abs (- take-profit entry-point)) (abs (- stop-loss entry-point)))
     ;; risk percentage
     (/ (* (abs (- stop-loss entry-point)) volume 100000) balance))))


(defun efx/build-trade-plan ()
  "Generate an Org-mode FX trade plan"
  (interactive)
  (switch-to-buffer efx/widget-buffer-name)

  ; initialize
  (kill-all-local-variables)

  (let ((inhibit-read-only t)
        (all (overlay-lists)))

    ;; clean buffer first
    (erase-buffer)
    (mapcar 'delete-overlay (car all))
    (mapcar 'delete-overlay (cdr all))

    (widget-insert (propertize "Create A Trade Plan" 'font-lock-face '(:height 2.0 :underline t :inherit font-lock-keyword-face)))
    (widget-insert "\n\nShortcuts: `C-c C-c' to commit; `r' to reset this form; `q' to quit without save \n")
    (push (list 'position
                (widget-create 'radio-button-choice
                                :value "Long"
                                :format (concat "\n" (propertize "Long or Short" 'face 'font-lock-function-name-face) "\n%v")
                                :entry-format "              %b %v"
                                '(item "Long") '(item "Short"))) efx/widget-alist)

    (push (list 'currency
                (widget-create 'radio-button-choice
                               :value "EURUSD"
                               :format (concat "\n" (propertize "Currency" 'face 'font-lock-function-name-face) "\n%v")
                               :entry-format "              %b %v"
                               '(item "EURUSD")
                               '(item "GBPUSD")
                               '(item "USDCHF")
                               '(item "USDCAD")
                               '(item "AUDUSD"))) efx/widget-alist)

    (push (list 'entry-point
                (widget-create 'editable-field
                               :format (concat "\n" (propertize "Entry Point" 'face 'font-lock-function-name-face) " :  %v")
                               :size 7
                               :value "0.00000"
                               :notify (lambda (widget &rest ignore)
                                         (condition-case nil (efx/warn-risk) (error nil)))
                               :valid-regexp "^[0-9]+\.[0-9]+$")) efx/widget-alist)


    (push (list 'stop-loss
                (widget-create 'editable-field
                               :format (concat "\n" (propertize "Stop Loss" 'face 'font-lock-function-name-face) "   :  %v")
                               :size 7
                               :value "0.00000"
                               :notify (lambda (widget &rest ignore)
                                         (condition-case nil (efx/warn-risk) (error nil)))
                               :valid-regexp "^[0-9]+\.[0-9]+$")) efx/widget-alist)


    (push (list 'take-profit
                (widget-create 'editable-field
                               :format (concat "\n" (propertize "Take Profit" 'face 'font-lock-function-name-face) " :  %v")
                               :size 7
                               :value "0.00000"
                               :notify (lambda (widget &rest ignore)
                                         (condition-case nil (efx/warn-risk) (error nil)))
                               :valid-regexp "^[0-9]+\.[0-9]+$")) efx/widget-alist)

    (push (list 'volume
                (widget-create 'editable-field
                               :format (concat "\n" (propertize "Volume" 'face 'font-lock-function-name-face) "      :  %v")
                               :size 7
                               :value "0.25"
                               :notify (lambda (widget &rest ignore)
                                         (condition-case nil (efx/warn-risk) (error nil)))
                               :valid-regexp "^[0-9]+\.[0-9]+$")) efx/widget-alist)

    (push (list 'balance
                (widget-create 'editable-field
                               :format (concat "\n" (propertize "Balance" 'face 'font-lock-function-name-face) "     :  %v")
                               :size 7
                               :value "5000.00"
                               :notify (lambda (widget &rest ignore)
                                         (condition-case nil (efx/warn-risk) (error nil)))
                               :valid-regexp "^[0-9]+\.[0-9]+$")) efx/widget-alist)


  (widget-insert (concat "\n" (propertize "Technologies" 'face 'font-lock-function-name-face)  ": "))

  (push (list 'rationale
              (widget-create 'text
                             :format (concat "\n" (propertize "Rationale" 'face 'font-lock-function-name-face) ":\n%v")
                             )) efx/widget-alist)
  (widget-insert "\n")
  (push (list 'memo
              (widget-create 'text
                             :format (concat "\n" (propertize "Memo" 'face 'font-lock-function-name-face) ":\n%v")
                             :value-face 'font-lock-comment-face
                             )) efx/widget-alist)

  (widget-insert "\n\n")

  (widget-create 'push-button
		 :notify 'efx/generate-org-trade-plan
		 "Create")
  (widget-insert " ")
  (widget-create 'push-button
                 :notify (lambda (&rest ignore)
                                (efx/build-trade-plan))
		 "Reset")
  (widget-insert " ")
  (widget-create 'push-button
		 :notify (lambda (&rest ignore)
			   (kill-buffer))
		 "Cancel")
  (widget-insert "\n")
  (make-local-variable 'widget-kemap)
  (use-local-map widget-keymap)
  (define-key widget-keymap (kbd "C-c C-c") 'efx/generate-org-trade-plan)
  (define-key widget-keymap (kbd "r") 'efx/build-trade-plan)
  (define-key widget-keymap (kbd "q") 'efx/kill-trade-plan-buffer)
  (goto-char (point-min))
  (widget-setup)))
