;;; color-theme-dotshare.el --- A color theme for Emacs.

;; Copyright (C) 2011 Christian Brassat, Bozhidar Batsov

;; Author: Christian Brassat <crshd@mail.com>
;; URL:
;; Version: 0.1
;; Package-Requires: ((color-theme "6.6.1"))

;; Based on color-theme-zenburn.el:
;; Author: Bozhidar Batsov <bozhidar.batsov@gmail.com>
;; URL: http://github.com/bbatsov/zenburn-emacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Installation:
;;
;;   (require 'color-theme-dotshare)
;;   (color-theme-dotshare)
;;
;; Don't forget that the theme requires the presence of the
;; color-theme package in your Emacs load-path.
;;
;;; Bugs
;;
;; None that I'm aware of.
;;
;;; Credits
;;
;; Jani Nurminen created the original theme for vim on such this port
;; is based.
;;
;;; Code

;; requires
(require 'color-theme)

;; color definitions
;; colors with +x are lighter, colors with -x are darker
(defvar dotshare-fg "#d7d0c7")

(defvar dotshare-bg-1 "#101010")
(defvar dotshare-bg   "#151515")
(defvar dotshare-bg+1 "#202020")
(defvar dotshare-bg+2 "#5f5f5f")

(defvar dotshare-red+1 "#f55353")
(defvar dotshare-red   "#e84f4f")
(defvar dotshare-red-1 "#ce4646")
(defvar dotshare-red-2 "#a83939")
(defvar dotshare-red-3 "#682424")

(defvar dotshare-orange "#dfaf8f")

(defvar dotshare-yellow   "#e1aa5d")
(defvar dotshare-yellow-1 "#c79752")
(defvar dotshare-yellow-2 "#a17a43")

(defvar dotshare-green-1 "#a2bc7b")
(defvar dotshare-green   "#b8d68c")
(defvar dotshare-green+1 "#c3e394")
(defvar dotshare-green+2 "#9fc59f")
(defvar dotshare-green+3 "#ceef9d")
(defvar dotshare-green+4 "#d9fca5")

(defvar dotshare-cyan "#6d878d")

(defvar dotshare-blue+1 "#85cddc")
(defvar dotshare-blue   "#7dc1cf")
(defvar dotshare-blue-1 "#6ea9b5")
(defvar dotshare-blue-2 "#57868f")
(defvar dotshare-blue-3 "#38565c")
(defvar dotshare-blue-4 "#304a4f")
(defvar dotshare-blue-5 "#213236")

(defvar dotshare-magenta "#9b64fb")

(eval-after-load 'term
  '(setq ansi-term-color-vector
         (vector 'unspecified dotshare-bg
                 dotshare-red dotshare-green
                 dotshare-yellow dotshare-blue+1
                 dotshare-magenta dotshare-cyan
                 ;; dirty fix
                 "white")))

(defun color-theme-dotshare ()
  (interactive)
  (color-theme-install
   `(color-theme-dotshare
     ;;; color-theme mapping
     ((foreground-color . ,dotshare-fg)
      (background-color . ,dotshare-bg)
      (background-mode . dark)
      (cursor-color . ,dotshare-orange))

     ;;; define some reusable dotshare faces that we can inherit from afterwards
     (dotshare-strong-1-face ((t (:foreground ,dotshare-yellow :weight bold))))
     (dotshare-strong-2-face ((t (:foreground ,dotshare-orange :weight bold))))
     (dotshare-warning-face ((t (:foreground ,dotshare-yellow-1 :weight bold :underline t))))
     (dotshare-error-face ((t (:foreground ,dotshare-red-1 :weight bold :underline t))))

     ;;; custom faces
     (linum ((t (:foreground "#505050" :background ,dotshare-bg-1))))
     (fringe ((t (:foreground "#303030"))))

     ;;; basic coloring
     (default ((t (:foreground ,dotshare-fg))))
     (cursor
      ((t (:foreground ,dotshare-fg))))
     (escape-glyph-face ((t (:foreground ,dotshare-red))))
     (fringe ((t (:foreground ,dotshare-fg :background ,dotshare-bg))))
     (header-line ((t (:foreground ,dotshare-yellow :background ,dotshare-bg-1
                       :box (:line-width 5 :color ,dotshare-bg-1)))))
     (highlight ((t (:background ,dotshare-yellow-2 :foreground ,dotshare-fg))))

     ;; faces used by isearch
     (isearch ((t (:foreground ,dotshare-yellow :background ,dotshare-bg-1))))
     (isearch-fail ((t (:foreground ,dotshare-fg :background ,dotshare-red-3))))
     (lazy-highlight ((t (:foreground ,dotshare-yellow :background ,dotshare-bg+2))))

     (menu ((t (:foreground ,dotshare-fg :background ,dotshare-bg))))
     (minibuffer-prompt ((t (:foreground ,dotshare-yellow))))
     (mode-line
      ((t (:foreground ,dotshare-fg :background ,dotshare-bg+1
           :box (:line-width 5 :color ,dotshare-bg+1)))))
     (mode-line-inactive ((t (:inherit mode-line :background ,dotshare-bg-1
                              :box (:line-width 5 :color ,dotshare-bg-1)))))
     (mode-line-buffer-id ((t (:inherit dotshare-strong-1-face))))
     (mode-line-inactive
      ((t (:foreground ,dotshare-green-1  :background ,dotshare-bg-1))))
     (mode-line-buffer-name ((t (:foreground ,dotshare-green :weight bold))))
     (mode-line-mode-name ((t (:foreground ,dotshare-yellow))))
     (region ((t (:background ,dotshare-magenta))))
     (secondary-selection ((t (:background ,dotshare-bg+2))))
     (trailing-whitespace ((t (:background ,dotshare-red))))
     (vertical-border ((t (:foreground ,dotshare-fg))))

     ;;; font lock
     (font-lock-builtin-face ((t (:foreground ,dotshare-blue))))
     (font-lock-comment-face ((t (:foreground ,dotshare-green))))
     (font-lock-comment-delimiter-face ((t (:foreground ,dotshare-green))))
     (font-lock-constant-face ((t (:foreground ,dotshare-fg))))
     (font-lock-doc-face ((t (:foreground ,dotshare-green+1))))
     (font-lock-doc-string-face ((t (:foreground ,dotshare-blue+1))))
     (font-lock-function-name-face ((t (:foreground ,dotshare-blue))))
     (font-lock-keyword-face ((t (:inherit dotshare-strong-1-face))))
     (font-lock-negation-char-face ((t (:foreground ,dotshare-fg))))
     (font-lock-preprocessor-face ((t (:foreground ,dotshare-blue))))
     (font-lock-string-face ((t (:foreground ,dotshare-red))))
     (font-lock-type-face ((t (:foreground ,dotshare-yellow))))
     (font-lock-variable-name-face ((t (:foreground ,dotshare-yellow))))
     (font-lock-warning-face ((t (:inherit dotshare-warning-face))))

     ;;; external

     ;; diff
     (diff-added ((t (:foreground ,dotshare-green+4))))
     (diff-changed ((t (:foreground ,dotshare-yellow))))
     (diff-removed ((t (:foreground ,dotshare-red))))
     (diff-header ((t (:background ,dotshare-bg+1))))
     (diff-file-header
      ((t (:background ,dotshare-bg+2 :foreground ,dotshare-fg :bold t))))

     ;; eshell
     (eshell-prompt ((t (:inherit dotshare-strong-1-face))))
     (eshell-ls-archive ((t (:foreground ,dotshare-red-1 :weight bold))))
     (eshell-ls-backup ((t (:inherit font-lock-comment))))
     (eshell-ls-clutter ((t (:inherit font-lock-comment))))
     (eshell-ls-directory ((t (:foreground ,dotshare-blue+1 :weight bold))))
     (eshell-ls-executable ((t (:foreground ,dotshare-red+1 :weight bold))))
     (eshell-ls-unreadable ((t (:foreground ,dotshare-fg))))
     (eshell-ls-missing ((t (:inherit font-lock-warning))))
     (eshell-ls-product ((t (:inherit font-lock-doc))))
     (eshell-ls-special ((t (:inherit dotshare-strong-1-face))))
     (eshell-ls-symlink ((t (:foreground ,dotshare-cyan :weight bold))))

     ;; flymake
     (flymake-errline ((t (:inherit dotshare-error-face))))
     (flymake-warnline ((t (:inherit dotshare-warning-face))))

     ;; flyspell
     (flyspell-duplicate ((t (:inherit dotshare-warning-face))))
     (flyspell-incorrect ((t (:inherit dotshare-error-face))))

     ;; erc
     (erc-action-face ((t (:inherit erc-default-face))))
     (erc-bold-face ((t (:weight bold))))
     (erc-current-nick-face ((t (:inherit dotshare-strong-1-face))))
     (erc-dangerous-host-face ((t (:inherit font-lock-warning))))
     (erc-default-face ((t (:foreground ,dotshare-fg))))
     (erc-direct-msg-face ((t (:inherit erc-default))))
     (erc-error-face ((t (:inherit font-lock-warning))))
     (erc-fool-face ((t (:inherit erc-default))))
     (erc-highlight-face ((t (:inherit hover-highlight))))
     (erc-input-face ((t (:foreground ,dotshare-yellow))))
     (erc-keyword-face ((t (:inherit dotshare-strong-1-face))))
     (erc-nick-default-face ((t (:weigth bold))))
     (erc-nick-msg-face ((t (:inherit erc-default))))
     (erc-notice-face ((t (:foreground ,dotshare-green))))
     (erc-pal-face ((t (:foreground ,dotshare-orange :weight bold))))
     (erc-prompt-face ((t (:inherit dotshare-strong-2-face))))
     (erc-timestamp-face ((t (:foreground ,dotshare-green+1))))
     (erc-underline-face ((t (:underline t))))

     ;; gnus
     (gnus-group-mail-1-face ((t (:bold t :inherit gnus-group-mail-1-empty))))
     (gnus-group-mail-1-empty-face ((t (:inherit gnus-group-news-1-empty))))
     (gnus-group-mail-2-face ((t (:bold t :inherit gnus-group-mail-2-empty))))
     (gnus-group-mail-2-empty-face ((t (:inherit gnus-group-news-2-empty))))
     (gnus-group-mail-3-face ((t (:bold t :inherit gnus-group-mail-3-empty))))
     (gnus-group-mail-3-empty-face ((t (:inherit gnus-group-news-3-empty))))
     (gnus-group-mail-4-face ((t (:bold t :inherit gnus-group-mail-4-empty))))
     (gnus-group-mail-4-empty-face ((t (:inherit gnus-group-news-4-empty))))
     (gnus-group-mail-5-face ((t (:bold t :inherit gnus-group-mail-5-empty))))
     (gnus-group-mail-5-empty-face ((t (:inherit gnus-group-news-5-empty))))
     (gnus-group-mail-6-face ((t (:bold t :inherit gnus-group-mail-6-empty))))
     (gnus-group-mail-6-empty-face ((t (:inherit gnus-group-news-6-empty))))
     (gnus-group-mail-low-face ((t (:bold t :inherit gnus-group-mail-low-empty))))
     (gnus-group-mail-low-empty-face ((t (:inherit gnus-group-news-low-empty))))
     (gnus-group-news-1-face ((t (:bold t :inherit gnus-group-news-1-empty))))
     (gnus-group-news-2-face ((t (:bold t :inherit gnus-group-news-2-empty))))
     (gnus-group-news-3-face ((t (:bold t :inherit gnus-group-news-3-empty))))
     (gnus-group-news-4-face ((t (:bold t :inherit gnus-group-news-4-empty))))
     (gnus-group-news-5-face ((t (:bold t :inherit gnus-group-news-5-empty))))
     (gnus-group-news-6-face ((t (:bold t :inherit gnus-group-news-6-empty))))
     (gnus-group-news-low-face ((t (:bold t :inherit gnus-group-news-low-empty))))
     (gnus-header-content-face ((t (:inherit message-header-other))))
     (gnus-header-from-face ((t (:inherit message-header-from))))
     (gnus-header-name-face ((t (:inherit message-header-name))))
     (gnus-header-newsgroups-face ((t (:inherit message-header-other))))
     (gnus-header-subject-face ((t (:inherit message-header-subject))))
     (gnus-summary-cancelled-face ((t (:foreground ,dotshare-orange))))
     (gnus-summary-high-ancient-face ((t (:foreground ,dotshare-blue))))
     (gnus-summary-high-read-face ((t (:foreground ,dotshare-green :weight bold))))
     (gnus-summary-high-ticked-face ((t (:inherit dotshare-strong-2-face))))
     (gnus-summary-high-unread-face ((t (:foreground ,dotshare-fg :weight bold))))
     (gnus-summary-low-ancient-face ((t (:foreground ,dotshare-blue))))
     (gnus-summary-low-read-face ((t (:foreground ,dotshare-green))))
     (gnus-summary-low-ticked-face ((t (:inherit dotshare-strong-2-face))))
     (gnus-summary-low-unread-face ((t (:foreground ,dotshare-fg))))
     (gnus-summary-normal-ancient-face ((t (:foreground ,dotshare-blue))))
     (gnus-summary-normal-read-face ((t (:foreground ,dotshare-green))))
     (gnus-summary-normal-ticked-face ((t (:inherit dotshare-strong-2-face))))
     (gnus-summary-normal-unread-face ((t (:foreground ,dotshare-fg))))
     (gnus-summary-selected-face ((t (:inherit dotshare-strong-1-face))))
     (gnus-cite-1-face ((t (:foreground ,dotshare-blue))))
     (gnus-cite-10-face ((t (:foreground ,dotshare-yellow-1))))
     (gnus-cite-11-face ((t (:foreground ,dotshare-yellow))))
     (gnus-cite-2-face ((t (:foreground ,dotshare-blue-1))))
     (gnus-cite-3-face ((t (:foreground ,dotshare-blue-2))))
     (gnus-cite-4-face ((t (:foreground ,dotshare-green+2))))
     (gnus-cite-5-face ((t (:foreground ,dotshare-green+1))))
     (gnus-cite-6-face ((t (:foreground ,dotshare-green))))
     (gnus-cite-7-face ((t (:foreground ,dotshare-red))))
     (gnus-cite-8-face ((t (:foreground ,dotshare-red-1))))
     (gnus-cite-9-face ((t (:foreground ,dotshare-red-2))))
     (gnus-group-news-1-empty-face ((t (:foreground ,dotshare-yellow))))
     (gnus-group-news-2-empty-face ((t (:foreground ,dotshare-green+3))))
     (gnus-group-news-3-empty-face ((t (:foreground ,dotshare-green+1))))
     (gnus-group-news-4-empty-face ((t (:foreground ,dotshare-blue-2))))
     (gnus-group-news-5-empty-face ((t (:foreground ,dotshare-blue-3))))
     (gnus-group-news-6-empty-face ((t (:foreground ,dotshare-bg+2))))
     (gnus-group-news-low-empty-face ((t (:foreground ,dotshare-bg+2))))
     (gnus-signature-face ((t (:foreground ,dotshare-yellow))))
     (gnus-x-face ((t (:background ,dotshare-fg :foreground ,dotshare-bg))))

     ;; hl-line-mode
     (hl-line-face ((t (:background ,dotshare-bg-1))))

     ;; ido-mode
     (ido-first-match ((t (:inherit dotshare-strong-1-face))))
     (ido-only-match ((t (:inherit dotshare-strong-2-face))))
     (ido-subdir ((t (:foreground ,dotshare-yellow))))

     ;; magit
     (magit-section-title ((t (:inherit dotshare-strong-1-face))))
     (magit-branch ((t (:inherit dotshare-strong-2-face))))

     ;; message-mode
     (message-cited-text-face ((t (:inherit font-lock-comment))))
     (message-header-name-face ((t (:foreground ,dotshare-green+1))))
     (message-header-other-face ((t (:foreground ,dotshare-green))))
     (message-header-to-face ((t (:inherit dotshare-strong-1-face))))
     (message-header-from-face ((t (:inherit dotshare-strong-1-face))))
     (message-header-cc-face ((t (:inherit dotshare-strong-1-face))))
     (message-header-newsgroups-face ((t (:inherit dotshare-strong-1-face))))
     (message-header-subject-face ((t (:inherit dotshare-strong-2-face))))
     (message-header-xheader-face ((t (:foreground ,dotshare-green))))
     (message-mml-face ((t (:inherit dotshare-strong-1-face))))
     (message-separator-face ((t (:inherit font-lock-comment))))

     ;; mew
     (mew-face-header-subject ((t (:foreground ,dotshare-orange))))
     (mew-face-header-from ((t (:foreground ,dotshare-yellow))))
     (mew-face-header-date ((t (:foreground ,dotshare-green))))
     (mew-face-header-to ((t (:foreground ,dotshare-red))))
     (mew-face-header-key ((t (:foreground ,dotshare-green))))
     (mew-face-header-private ((t (:foreground ,dotshare-green))))
     (mew-face-header-important ((t (:foreground ,dotshare-blue))))
     (mew-face-header-marginal ((t (:foreground ,dotshare-fg :weight bold))))
     (mew-face-header-warning ((t (:foreground ,dotshare-red))))
     (mew-face-header-xmew ((t (:foreground ,dotshare-green))))
     (mew-face-header-xmew-bad ((t (:foreground ,dotshare-red))))
     (mew-face-body-url ((t (:foreground ,dotshare-orange))))
     (mew-face-body-comment ((t (:foreground ,dotshare-fg :slant italic))))
     (mew-face-body-cite1 ((t (:foreground ,dotshare-green))))
     (mew-face-body-cite2 ((t (:foreground ,dotshare-blue))))
     (mew-face-body-cite3 ((t (:foreground ,dotshare-orange))))
     (mew-face-body-cite4 ((t (:foreground ,dotshare-yellow))))
     (mew-face-body-cite5 ((t (:foreground ,dotshare-red))))
     (mew-face-mark-review ((t (:foreground ,dotshare-blue))))
     (mew-face-mark-escape ((t (:foreground ,dotshare-green))))
     (mew-face-mark-delete ((t (:foreground ,dotshare-red))))
     (mew-face-mark-unlink ((t (:foreground ,dotshare-yellow))))
     (mew-face-mark-refile ((t (:foreground ,dotshare-green))))
     (mew-face-mark-unread ((t (:foreground ,dotshare-red-2))))
     (mew-face-eof-message ((t (:foreground ,dotshare-green))))
     (mew-face-eof-part ((t (:foreground ,dotshare-yellow))))

     ;; nav
     (nav-face-heading ((t (:foreground ,dotshare-yellow))))
     (nav-face-button-num ((t (:foreground ,dotshare-cyan))))
     (nav-face-dir ((t (:foreground ,dotshare-green))))
     (nav-face-hdir ((t (:foreground ,dotshare-red))))
     (nav-face-file ((t (:foreground ,dotshare-fg))))
     (nav-face-hfile ((t (:foreground ,dotshare-red-3))))

     ;; org-mode
     (org-agenda-date-today
      ((t (:foreground "white" :slant italic :weight bold))) t)
     (org-agenda-structure
      ((t (:inherit font-lock-comment-face))))
     (org-archived ((t (:foreground ,dotshare-fg :weight bold))))
     (org-checkbox ((t (:background ,dotshare-bg+2 :foreground "white"
                                    :box (:line-width 1 :style released-button)))))
     (org-date ((t (:foreground ,dotshare-blue :underline t))))
     (org-deadline-announce ((t (:foreground ,dotshare-red-1))))
     (org-done ((t (:bold t :weight bold :foreground ,dotshare-green+3))))
     (org-formula ((t (:foreground ,dotshare-yellow-2))))
     (org-headline-done ((t (:foreground ,dotshare-green+3))))
     (org-hide ((t (:foreground ,dotshare-bg-1))))
     (org-level-1 ((t (:foreground ,dotshare-orange))))
     (org-level-2 ((t (:foreground ,dotshare-green+1))))
     (org-level-3 ((t (:foreground ,dotshare-blue-1))))
     (org-level-4 ((t (:foreground ,dotshare-yellow-2))))
     (org-level-5 ((t (:foreground ,dotshare-cyan))))
     (org-level-6 ((t (:foreground ,dotshare-green-1))))
     (org-level-7 ((t (:foreground ,dotshare-red-3))))
     (org-level-8 ((t (:foreground ,dotshare-blue-4))))
     (org-link ((t (:foreground ,dotshare-yellow-2 :underline t))))
     (org-scheduled ((t (:foreground ,dotshare-green+4))))
     (org-scheduled-previously ((t (:foreground ,dotshare-red-3))))
     (org-scheduled-today ((t (:foreground ,dotshare-blue+1))))
     (org-special-keyword ((t (:foreground ,dotshare-yellow-1))))
     (org-table ((t (:foreground ,dotshare-green+2))))
     (org-tag ((t (:bold t :weight bold))))
     (org-time-grid ((t (:foreground ,dotshare-orange))))
     (org-todo ((t (:bold t :foreground ,dotshare-red :weight bold))))
     (org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
     (org-warning ((t (:bold t :foreground ,dotshare-red :weight bold))))

     ;; outline
     (outline-8 ((t (:inherit default))))
     (outline-7 ((t (:inherit outline-8 :height 1.0))))
     (outline-6 ((t (:inherit outline-7 :height 1.0))))
     (outline-5 ((t (:inherit outline-6 :height 1.0))))
     (outline-4 ((t (:inherit outline-5 :height 1.0))))
     (outline-3 ((t (:inherit outline-4 :height 1.0))))
     (outline-2 ((t (:inherit outline-3 :height 1.0))))
     (outline-1 ((t (:inherit outline-2 :height 1.0))))

     ;; rainbow-delimiters
     (rainbow-delimiters-depth-1-face ((t (:foreground ,dotshare-cyan))))
     (rainbow-delimiters-depth-2-face ((t (:foreground ,dotshare-yellow))))
     (rainbow-delimiters-depth-3-face ((t (:foreground ,dotshare-blue+1))))
     (rainbow-delimiters-depth-4-face ((t (:foreground ,dotshare-red+1))))
     (rainbow-delimiters-depth-5-face ((t (:foreground ,dotshare-orange))))
     (rainbow-delimiters-depth-6-face ((t (:foreground ,dotshare-blue-1))))
     (rainbow-delimiters-depth-7-face ((t (:foreground ,dotshare-green+4))))
     (rainbow-delimiters-depth-8-face ((t (:foreground ,dotshare-red-3))))
     (rainbow-delimiters-depth-9-face ((t (:foreground ,dotshare-yellow-2))))
     (rainbow-delimiters-depth-10-face ((t (:foreground ,dotshare-green+2))))
     (rainbow-delimiters-depth-11-face ((t (:foreground ,dotshare-blue+1))))
     (rainbow-delimiters-depth-12-face ((t (:foreground ,dotshare-red-3))))

     ;; rpm-mode
     (rpm-spec-dir-face ((t (:foreground ,dotshare-green))))
     (rpm-spec-doc-face ((t (:foreground ,dotshare-green))))
     (rpm-spec-ghost-face ((t (:foreground ,dotshare-red))))
     (rpm-spec-macro-face ((t (:foreground ,dotshare-yellow))))
     (rpm-spec-obsolete-tag-face ((t (:foreground ,dotshare-red))))
     (rpm-spec-package-face ((t (:foreground ,dotshare-red))))
     (rpm-spec-section-face ((t (:foreground ,dotshare-yellow))))
     (rpm-spec-tag-face ((t (:foreground ,dotshare-blue))))
     (rpm-spec-var-face ((t (:foreground ,dotshare-red))))

     ;; show-paren
     (show-paren-mismatch ((t (:foreground ,dotshare-red-3 :weight bold))))
     (show-paren-match ((t (:foreground ,dotshare-blue-1 :weight bold))))

     ;; wanderlust
     (wl-highlight-folder-few-face ((t (:foreground ,dotshare-red-2))))
     (wl-highlight-folder-many-face ((t (:foreground ,dotshare-red-1))))
     (wl-highlight-folder-path-face ((t (:foreground ,dotshare-orange))))
     (wl-highlight-folder-unread-face ((t (:foreground ,dotshare-blue))))
     (wl-highlight-folder-zero-face ((t (:foreground ,dotshare-fg))))
     (wl-highlight-folder-unknown-face ((t (:foreground ,dotshare-blue))))
     (wl-highlight-message-citation-header ((t (:foreground ,dotshare-red-1))))
     (wl-highlight-message-cited-text-1 ((t (:foreground ,dotshare-red))))
     (wl-highlight-message-cited-text-2 ((t (:foreground ,dotshare-green+2))))
     (wl-highlight-message-cited-text-3 ((t (:foreground ,dotshare-blue))))
     (wl-highlight-message-cited-text-4 ((t (:foreground ,dotshare-blue+1))))
     (wl-highlight-message-header-contents-face ((t (:foreground ,dotshare-green))))
     (wl-highlight-message-headers-face ((t (:foreground ,dotshare-red+1))))
     (wl-highlight-message-important-header-contents ((t (:foreground ,dotshare-green+2))))
     (wl-highlight-message-header-contents ((t (:foreground ,dotshare-green+1))))
     (wl-highlight-message-important-header-contents2 ((t (:foreground ,dotshare-green+2))))
     (wl-highlight-message-signature ((t (:foreground ,dotshare-green))))
     (wl-highlight-message-unimportant-header-contents ((t (:foreground ,dotshare-fg))))
     (wl-highlight-summary-answered-face ((t (:foreground ,dotshare-blue))))
     (wl-highlight-summary-disposed-face ((t (:foreground ,dotshare-fg
                                                          :slant italic))))
     (wl-highlight-summary-new-face ((t (:foreground ,dotshare-blue))))
     (wl-highlight-summary-normal-face ((t (:foreground ,dotshare-fg))))
     (wl-highlight-summary-thread-top-face ((t (:foreground ,dotshare-yellow))))
     (wl-highlight-thread-indent-face ((t (:foreground ,dotshare-magenta))))
     (wl-highlight-summary-refiled-face ((t (:foreground ,dotshare-fg))))
     (wl-highlight-summary-displaying-face ((t (:underline t :weight bold)))))))

(add-to-list 'color-themes '(color-theme-dotshare
                             "dotshare"
                             "Christian Brassat <crshd@mail.com>"))

(provide 'color-theme-dotshare)

;;; color-theme-dotshare.el ends here.
