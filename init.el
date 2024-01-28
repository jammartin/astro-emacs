;; add MELPA package archive
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; load astro-emacs configuration
(add-to-list 'load-path (expand-file-name "astro" user-emacs-directory)) ;; folder astro contains modules below
(load "feed-reader.el") ;; loading elfeed for astro-ph papers
