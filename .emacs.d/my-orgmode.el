;;path to org-mode
(add-to-list 'load-path "~/emacs.d/3rd/org-7.7/lisp")
;;autoload when org-mode starts
(require 'org-install)

;;associate .org files with org-mode
(add-to-list 'auto-mode-alist '("\\.org\\$" . org-mode))
;;set global key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)

(setq org-agenda-files (list "~/Dropbox/Org/test.org"
                             "~/Dropbox/Org/work.org"))

(setq org-directory "~/Dropbox/Org")
(setq org-mobile-directory "~/Dropbox/MobileOrg/")
(setq org-agenda-files (quote ("~/Dropbox/Org/agenda.org")))
(setq org-mobile-inbox-for-pull "~/Dropbox/Org/inbox.org")

(provide 'my-orgmode)
