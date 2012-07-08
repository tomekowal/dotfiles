;; emacs initialization, for keeping .emacs clean
;; Enable a backtrace when problems occur
;(setq debug-on-error t)

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/3rd"))

;; Personal customizations
(require 'my-system)
(require 'my-generic)
(require 'my-backup)
(require 'my-ido)
(require 'my-colors)
(require 'my-recent)
(require 'my-term)
(require 'my-shell-pop)
(require 'my-tabbar)
;;(require 'my-org)
(require 'my-orgmode)
(require 'my-yasnippet)
;;(require 'my-slime)
(require 'my-erlang)
(require 'my-cedet)
(require 'my-distel)
(require 'my-haskell)
(require 'linum)

