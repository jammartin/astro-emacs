# Astro Emacs
*An Astrophysicist's Emacs Configuration*

## Introduction
This repository includes my simple [GNU Emacs](https://www.gnu.org/software/emacs/) configuration. Emacs is my main editor I use for programming, writing and other stuff. The [Elfeed](https://github.com/skeeto/elfeed) configuration file (I use [elfeed-org](https://github.com/remyhonig/elfeed-org)) in this repository contains URLs for RSS feeds in the field of Astrophysics. 

## Installation
The required packages are available from [MELPA](https://melpa.org) and can be installed via `M-x package-install PACKAGE`. The required lines in your Emacs init file to set up MELPA are included in the example `init.el` in this repository.  

**Required Packages:** `use-package` `elfeed` `elfeed-org`  

To use modules from the Astro Emacs configuration just copy or symlink the folder `astro` to your Emacs directory typically `~/.emacs.d/`. In your initialization file you need the following lines to use the modules:

```lisp
;; load astro-emacs configuration
;; astro directory name can be changed if needed
(add-to-list 'load-path (expand-file-name "astro" user-emacs-directory)) 
(load "feed-reader.el") ;; loading elfeed for astro-ph papers
```

If you renamed the folder `astro`, which is fine, you should change it to the correct name in the first command above. 

## Additional Resources
- [Introduction](https://lucidmanager.org/productivity/read-rss-feeds-with-emacs-and-elfeed/) by [Emacs Writing Studio](https://github.com/pprevos/emacs-writing-studio)
- [Managing ArXiv RSS Feeds](https://cundy.me/post/elfeed/)




