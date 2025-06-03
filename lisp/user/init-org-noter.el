(require 'deferred)
(require 'zotxt)
(require 'org-zotxt)
(require 'org-noter)

(defconst user/org-zotxt-noter-save-path
  (concat (file-name-as-directory system/const-org-location) "zotxt-noter/")
  "The directory where Zotero notes will be saved.")




(defun user/jump-to-zotxt-note-by-search ()
  "Jump to Zotero note by searching item name. At the same time, create the note file if it does not exist, and set the associated properties."
  (interactive)
  (deferred:$
   ;; step1: search for Zotero items
   (zotxt-search-deferred)
   (deferred:nextc it
		   (lambda (items)
		     (when (null items)
		       (error "No Zotero items found."))
		     (car items)))

   ;; step2: get the full item details
   (deferred:nextc it
		   (lambda (item)
		     (zotxt-get-item-deferred item :full)))

   ;; step3: generate note file path and pass context
   (deferred:nextc it
		   (lambda (full-item)
		     (let* ((item-key (plist-get full-item :key))
			    (note-directory user/org-zotxt-noter-save-path)
			    (note-file (concat note-directory item-key ".org")))
		       (make-directory note-directory t)
		       (cons full-item note-file))))

   ;; step4: create or open the note file
   (deferred:nextc it
		   (lambda (full-item-note-file)
		     (let* (
			    (full-item (car full-item-note-file))
			    (note-file (cdr full-item-note-file))
			    (item-key (plist-get full-item :key))
			    (json-object-type 'hash-table)
			    (json-array-type 'list)
			    (json-key-type 'string)
			    (json-data (json-read-from-string (plist-get full-item :full)))
			    (item-data (if (listp json-data) (car json-data) json-data))
			    (item-title (gethash "title" item-data))
			    )
		       (make-directory user/org-zotxt-noter-save-path t)
		       (if (file-exists-p note-file)
			   (find-file note-file)
			 (with-temp-file note-file
			   (insert (format "#+TITLE: %s\n" item-title))
			   (insert (format "#+DATE: %s\n" (format-time-string "%Y-%m-%d %H:%M")))
			   (insert "* Meta Info\n")
			   ))
		       (find-file note-file)
		       full-item
		       )
		     ))

   ;; step5: get the properties and paths
   (deferred:nextc it
		   (lambda (item)
		     (zotxt-get-item-deferred item :paths)))
   (deferred:nextc it
		   (lambda (item)
		     (org-zotxt-get-item-link-text-deferred item)))
   (deferred:nextc it
		   (lambda (resp)
		     (let ((path (org-zotxt-choose-path (cdr (assq 'paths (plist-get resp :paths))))))
                       (goto-line 1)
                       (org-next-visible-heading 1)
                       (org-entry-put (point) org-zotxt-noter-zotero-link (org-zotxt-make-item-link resp))
                       (org-entry-put (point) org-noter-property-doc-file path)
                       (save-buffer)
                       )
		     ))


   ;; step6: error handling
   (deferred:error it
		   (lambda (err)
		     (message "Zotxt Failed for : %s" (error-message-string err))
		     (signal 'user-error (list "Canceled"))))
   ))




(provide 'init-org-noter)
