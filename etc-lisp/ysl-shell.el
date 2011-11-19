;; shell-mode color {{
(setq ansi-color-names-vector
      ["black" "red4" "green4" "yellow4"
       "DeepSkyBlue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq comint-prompt-read-only t)
;; }}

;; eshell {{
(add-hook 'eshell-mode-hook
   (lambda () 
     (set (make-local-variable 'scroll-margin) 0)
     (local-set-key "\C-l" 'eshell-clear-interactive)))

(defun eshell-clear-interactive ()
  (interactive) (eshell/clear) (eshell-send-input))

(defun switch-to-eshell ()
  "Switch to eshell buffer,creat one if none exists
Switch to last recent buffer if current buffer is eshell's"
  (interactive)
  (if (eq (current-buffer) (get-buffer "*eshell*"))
      (switch-to-buffer (other-buffer))
    (if (eq (get-buffer "*eshell*") nil)
        (eshell))
    (switch-to-buffer "*eshell*")))

;; COPIED FROM http://www.northbound-train.com/emacs/em-joc.el
(defun eshell/clear ()
  "Clears the shell buffer ala Unix's clear or DOS' cls"
  (interactive)
  ;; the shell prompts are read-only, so clear that for the duration
  (let ((inhibit-read-only t))
    ;; simply delete the region
    (delete-region (point-min) (point-max))))
;; }}

;; ansi-term color {{
;; ---- http://emacsworld.blogspot.com/2009/02/setting-term-mode-colours.html
(setq ansi-term-color-vector
[unspecified "#000000" "#963F3C" "#5FFB65" "#FFFD65"
             "#0082FF" "#FF2180" "#57DCDB" "#FFFFFF"])
;; }}
;; COPIED FROM http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/ {{
(require 'term)
(defun emc/visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
;; }}

(provide 'ysl-shell)