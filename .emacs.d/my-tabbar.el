;;;; Tabbar settings

;(require 'tabbar-init)
(require 'tabbar)
(tabbar-mode t)

(setq tool-bar-border 0)

;; All tabs in 1 group
(setq tabbar-buffer-groups-function
           (lambda ()
	     (list "All")))

(tabbar-buffer-show-groups nil)

;; Not opening specified tabs on init
;; Side-function for matching string in list
(defun sch-string-list-match (list string)
  (loop for elem in list do
	(when (string= elem string) (return t))))

(defun tabbar-init-close-buff ()
  (let ((tabset (tabbar-get-tabset (tabbar-buffer-update-groups))) (temp-set (tabbar-make-tabset "temp-set")))
	(dolist (tab (tabbar-tabs tabset))
	  (let ((tab-name (buffer-name (tabbar-tab-value tab))))
	    (cond ((sch-string-list-match '("*Messages*" "*Pymacs*") tab-name)
		   (tabbar-delete-tab tab) (tabbar-add-tab temp-set tab)))))
	(tabbar-delete-tabset temp-set)
	(tabbar-buffer-update-groups)))

(add-hook 'tabbar-load-hook 'tabbar-init-close-buff)
(run-hooks 'tabbar-load-hook)

;; My custom settings
(set-face-attribute 'tabbar-default nil
		    :background "gray20"
		    :foreground "white"
		    :family "helvetica")

(set-face-attribute 'tabbar-selected nil
		    :background "black"
		    :foreground "red"
		    :box '(:line-width 1 :color "black" :style nil))

(set-face-attribute 'tabbar-unselected nil
		    :box '(:line-width 1 :color "gray20" :style nil))

(set-face-attribute 'tabbar-highlight nil
		    :underline nil
		    :background "goldenrod")

(set-face-attribute 'tabbar-button nil
		    :foreground "white"
		    :box '(:line-width 1 :color "gray50" :style nil))

;; redefine tab labels, adding leading and trailing spaces for clarity
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format " [%s] " (tabbar-tab-tabset tab))
                  (format " %s " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

;; Button view
(setq tabbar-home-button-enabled-image nil)

(setq tabbar-buffer-home-button
  (cons (cons "[+]" tabbar-home-button-enabled-image)
        (cons "[-]" tabbar-home-button-disabled-image)))

(setq tabbar-scroll-left-button-enabled-image nil)

(setq tabbar-scroll-left-button
  (cons (cons " <" tabbar-scroll-left-button-enabled-image)
        (cons " =" nil)))

(setq tabbar-scroll-right-button-enabled-image nil)

(setq tabbar-scroll-right-button
  (cons (cons " >" tabbar-scroll-right-button-enabled-image)
        (cons " =" nil)))


;; Redefine buffer display function to ignore some buffers
(defun clean-tabset (tabset)
  (dolist (tab (tabbar-tabs tabset))
	  (let ((tab-name (buffer-name (tabbar-tab-value tab))))
	    (cond ((sch-string-list-match '("*swbuff*") tab-name)
		   (tabbar-delete-tab tab)))))
  tabset)

(defun my-tabbar-buffer-tabs ()
  "Return the buffers to display on the tab bar, in a tab set."
  (let ((tabset (clean-tabset (tabbar-get-tabset (tabbar-buffer-update-groups)))))
    (tabbar-select-tab-value (current-buffer) tabset)
    (when tabbar--buffer-show-groups
      (setq tabset (tabbar-get-tabsets-tabset))
      (tabbar-select-tab-value (current-buffer) tabset))
    tabset))

(setq tabbar-current-tabset-function 'my-tabbar-buffer-tabs)

;; add a buffer modification state indicator in the tab label,
 (defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
   (setq ad-return-value
		(if (and (buffer-modified-p (tabbar-tab-value tab))
				 (buffer-file-name (tabbar-tab-value tab)))
			(concat "" (concat ad-return-value "[*]"))
			(concat "" (concat ad-return-value "")))))
 ;; called each time the modification state of the buffer changed
 (defun ztl-modification-state-change ()
   (tabbar-set-template tabbar-current-tabset nil)
   (tabbar-display-update))
 ;; first-change-hook is called BEFORE the change is made
 (defun ztl-on-buffer-modification ()
   (set-buffer-modified-p t)
   (ztl-modification-state-change))
 (add-hook 'after-save-hook 'ztl-modification-state-change)
 ;; this doesn't work for revert, I don't know
 ;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
 (add-hook 'first-change-hook 'ztl-on-buffer-modification)

;;;; END
(provide 'my-tabbar)
