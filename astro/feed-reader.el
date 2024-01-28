;; Get current directory
(defconst astro-emacs-directory (file-name-directory load-file-name))

(require 'use-package)

;; Designed after https://lucidmanager.org/productivity/read-rss-feeds-with-emacs-and-elfeed/
;; Taken from https://github.com/pprevos/emacs-writing-studio/tree/master
;; Configure Elfeed
(use-package elfeed
  :custom
  (elfeed-db-directory
   (expand-file-name "elfeed" user-emacs-directory))
   (elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-c w" . elfeed))

;; Configure Elfeed with org mode
(use-package elfeed-org
  :config
  (elfeed-org)
  :custom
  (rmh-elfeed-org-files (list (expand-file-name "elfeed.org" astro-emacs-directory))))

;; set to start page
(elfeed)
(setq initial-buffer-choice #'elfeed-search-buffer)
