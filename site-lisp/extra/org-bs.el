;; filename   : org-bs.el
;; created at : 2013-08-30 10:24:11
;; author     : Jianing Yang <jianingy@unitedstack.com>

(defvar nby/hot-projects '())
(defvar nby/hot-build-program (concat conf-root-dir "/tools/hot-build"))
(defvar nby/hot-site-name "my pages")
(defvar nby/hot-site-root "http://localhost/~jianingy")
(defvar nby/hot-template (concat conf-root-dir "/templates/org-export.html"))
(defvar nby/hot-publish-directory (concat user-home-dir "/Sites/"))

(defvar nby/org-base-directory (concat user-home-dir "/notes/portfolio"))
(defvar nby/org-publish-directory (concat user-home-dir "/tmp/org-bs"))


;; {{{ custom html styles according to bootstrap
(defadvice org-html--todo (after org-html--todo-bs activate)
  (let* ((todo (ad-get-arg 0))
         (label-type
          (if (member todo org-done-keywords) "label-success" "label-danger")))
    (if ad-return-value
        (setq ad-return-value  (format "<span class=\"label %s\">%s</span>"
                                       label-type ad-return-value)))))

(defadvice org-html--tags (after org-html--tags-bs activate)
  (if ad-return-value
      (setq ad-return-value
            (format "<span class=\"label label-info pull-right\">%s</span>"
                    ad-return-value))))

(defadvice org-html-inner-template (after org-html-inner-template-bs activate)
  (let* ((info (ad-get-arg 1))
         (depth (plist-get info :with-toc))
         (title (plist-get info :title))
         (toc (org-html-toc depth info t))
         (header (format (concat "<div class=\"page-header\">"
                                 "<h1 class=\"title\">%s</h1>"
                                 "</div>\n")
                         (org-export-data (or title "") info))))

    (if ad-return-value
        (setq ad-return-value (concat ""
                                      "<div class=\"row\">"
                                      "<div class=\"col-md-9\" role=\"main\">"
                                      header
                                      ad-return-value
                                      "</div>"
                                      (when (plist-get info :with-toc) toc)
                                      "</div>"
                                      )))))


(defadvice org-html--toc-text (after org-html--toc-text-bs activate)
  (if ad-return-value
      (setq ad-return-value
            (replace-regexp-in-string "<uL>"
                                      "<ul class=\"nav\">"
                                      ad-return-value))))

(defun org-html-toc (depth info &optional is-jianing-calling)
  (let ((toc-entries
	 (mapcar (lambda (headline)
		   (cons (org-html--format-toc-headline headline info)
			 (org-export-get-relative-level headline info)))
		 (org-export-collect-headlines info depth)))
	(outer-tag (if (and (org-html-html5-p info)
			    (plist-get info :html-html5-fancy))
		       "nav"
		     "div")))
    (when is-jianing-calling
      (when toc-entries
        (concat (format "<%s id=\"table-of-contents\" class=\"col-md-3\">\n" outer-tag)
                "<div id=\"text-table-of-contents\" class=\"bs-sidebar hidden-print affix\" role=\"complementary\">"
                "<div class=\"bs-sidenav\">"
                (org-html--toc-text toc-entries)
                "</div>\n"
                "</div>\n"
                (format "</%s>\n" outer-tag))))))


;; }}}

(defadvice org-publish-current-project (around org-publish-hot activate)
  (let* ((hot-command (concat nby/hot-build-program
                              " --template " nby/hot-template
                              " --base " nby/org-publish-directory
                              " --dest " nby/hot-publish-directory
                              " --projects " (mapconcat (lambda (x) x) nby/hot-projects ",")
                              " --site_name \"" nby/hot-site-name "\""
                              " --site_root \"" nby/hot-site-root "\"")))
    ad-do-it
    (message hot-command)
    (compilation-start hot-command)))


(defun ysl/add-org-project (name)
  (let ((source-directory (concat nby/org-base-directory "/" name "/"))
        (publish-directory (concat nby/org-publish-directory "/" name "/")))
    (message (concat "add org project: " name))
    (add-to-list 'nby/hot-projects name)
    (add-to-list 'org-publish-project-alist
                 `(,(concat name "-source")
                   :base-directory ,source-directory
                   :recursive t
                   :html-extension "html"
                   :base-extension "org"
                   :publishing-directory ,publish-directory
                   :publishing-function org-html-publish-to-html
                   :site-root "{{ site_root }}"
                   :htmlized-source t
                   :section-numbers nil
                   :headline-levels 3
                   :body-only t
                   :with-toc nil
                   :auto-index nil
                   :auto-preamble nil
                   :auto-postamble nil))

    (add-to-list 'org-publish-project-alist
                 `(,(concat name "-static")
                   :base-directory ,source-directory
                   :recursive t
                   :base-extension "jpg\\|gif\\|png\\|jpeg"
                   :publishing-directory ,publish-directory
                   :publishing-function org-publish-attachment))

    (add-to-list 'org-publish-project-alist
                 `(,name :components (,(concat name "-source")
                                      ,(concat name "-static"))))))

(provide 'org-bs)
