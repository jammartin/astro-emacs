;; Get current directory
(defconst astro-emacs-directory (file-name-directory load-file-name))

(require 'use-package)

(require 'wid-edit) ; widget-inactive face

;; Designed after https://lucidmanager.org/productivity/read-rss-feeds-with-emacs-and-elfeed/
;; Taken from https://github.com/pprevos/emacs-writing-studio/tree/master
;; Configure Elfeed
(use-package elfeed
  :custom
  (elfeed-db-directory
   (expand-file-name "elfeed" user-emacs-directory))
   ;;"~/Nextcloud/elfeed-database") ;; Replacing the line above by a path in your cloud of choice allows for the
                                  ;; use of the same database from different devices
   (elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-c w" . elfeed))

;; Configure Elfeed with org mode
(use-package elfeed-org
  :config
  (elfeed-org)
  :custom
  (rmh-elfeed-org-files (list (expand-file-name "elfeed.org" astro-emacs-directory))))

(defun concatenate-authors (authors-list)
  "Given AUTHORS-LIST, list of plists; return string of all authors
concatenated."
  (mapconcat
   (lambda (author) (plist-get author :name))
   authors-list ", "))

;; Taken from https://cundy.me/post/elfeed/
(defun authors-search-print-fn (entry)
  "Print ENTRY to the buffer."
  (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
	 (title (or (elfeed-meta entry :title)
		    (elfeed-entry-title entry) ""))
	 (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
	 (feed (elfeed-entry-feed entry))
	 (feed-title
	  (when feed
	    (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
	 (entry-authors (concatenate-authors
			 (elfeed-meta entry :authors)))
	 (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
	 (tags-str (mapconcat
		    (lambda (s) (propertize s 'face
					    'elfeed-search-tag-face))
		    tags ","))
	 (title-width (- (window-width) 10
	                 elfeed-search-trailing-width))
	 ;;(title-width 200)
	 (title-column (elfeed-format-column
			title (elfeed-clamp
			       elfeed-search-title-min-width
			       title-width
			       ;;elfeed-search-title-max-width)
			       110)
			:left))
	 (authors-width 50)
	 (authors-column (elfeed-format-column
			entry-authors (elfeed-clamp
			       elfeed-search-title-min-width
			       authors-width
			       80)
			:left)))

    (insert (propertize date 'face 'elfeed-search-date-face) " ")

    (insert (propertize title-column
			'face title-faces 'kbd-help title) " ")
    (when feed-title
      (insert (propertize feed-title 'face 'elfeed-search-feed-face) " "))

    ;;(when entry-authors
      (insert (propertize authors-column
			  'face 'elfeed-search-date-face
			  'kbd-help entry-authors) " ")
    ;;)

    ;;(when entry-authors
    ;;  (insert (propertize feed-title
    ;;			  'face 'elfeed-search-feed-face) " "))

    (when tags
      (insert "(" tags-str ")"))

    )
  )
(setq elfeed-search-print-entry-function #'authors-search-print-fn)

;; important tag's title is read
(defface important-elfeed-entry
  '((t :foreground "#f77"))
  "Marks an important Elfeed entry.")
(push '(important important-elfeed-entry)
      elfeed-search-face-alist)

;; taken from https://emacs.stackexchange.com/a/48769/43979
(set-face-attribute 'elfeed-search-unread-title-face
		    nil
		    :underline t
		    ;;:weight 'bold ;; somehow this does not work when overriding elfeed-search-print-entry-function, fallback to underline
		    
		    )

;; launch elfeed on startup
(elfeed)
