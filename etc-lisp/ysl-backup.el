(setq
 backup-by-copying t                     ;; don't clobber symlinks
 backup-directory-alist
 `((".*" . ,temporary-file-directory))   ;; don't litter my fs tree
 auto-save-file-name-transforms
 `((".*" ,temporary-file-directory t))  ;; as above
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)                      ;; use versioned backups

(message (concat "ysl-backup: set backup/autosave directory to " temporary-file-directory))

(provide 'ysl-backup)
