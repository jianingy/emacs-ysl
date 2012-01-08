;; shell-mode {{
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
(setq ansi-color-names-vector
      ["black" "red4" "green4" "yellow4"
       "DeepSkyBlue3" "magenta4" "cyan4" "white"])
(setq ansi-term-color-vector
      [unspecified "#000000" "#963F3C" "#5FFB65" "#FFFD65"
       "#0082FF" "#FF2180" "#57DCDB" "#FFFFFF"])
(setq ansi-color-for-comint-mode t)
(setq term-default-bg-color "#111")
(setq term-default-fg-color "grey80")
;; }}
;; COPIED FROM http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/ {{
(require 'term)

(defun ysl/open-terminal (term-buffer-name)
  (interactive)
  (let* ((is-term (string= "term-mode" major-mode))
         (full-buffer-name (concat "*" term-buffer-name "*"))
         (is-running (term-check-proc full-buffer-name)))
    (if (and is-term (string= full-buffer-name (buffer-name)))
        (switch-to-buffer (other-buffer))
      (if is-running
          (switch-to-buffer full-buffer-name)
        (ansi-term "/bin/bash" term-buffer-name)))))

(provide 'ysl-shell)
