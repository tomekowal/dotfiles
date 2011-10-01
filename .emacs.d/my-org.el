;;;; Org-mode settings

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
(setq org-completion-use-ido t)
(add-hook 'org-load-hook
  (lambda ()
    (define-key org-mode-map [(control tab)] 'swbuff-switch-to-next-buffer)
))

;; Line wrapping
(setq org-startup-truncated nil)

;; Select with shift
;(setq org-support-shift-select t)

;; Chromium as link-opener
(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program "chromium")

;;;; END
(provide 'my-org)
