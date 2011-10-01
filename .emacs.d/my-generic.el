;;;; Generic emacs settings

;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; Remove trailing whitespace and tabs in buffer before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; splash screen off
(setq inhibit-splash-screen t)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; Emacs gurus don't need no stinking scroll bars
(toggle-scroll-bar -1)

;; Line-wrapping
(set-default 'fill-column 80)

;; Prevent the annoying beep on errors
(setq visible-bell t)

;; Date-time display
(setq display-time-24hr-format t)
(display-time)

;; Format the title-bar to always include the buffer name and if it's modified
(if (and (not window-system)
           (string-match "^xterm" (getenv "TERM")))
      (progn
        (require 'xterm-frobs)
        (defun my-xterm-title-hook ()
          (xterm-set-window-title
           (concat
            (buffer-name)
            (cond ((buffer-modified-p) " [*]"))
	    " - emacs"
            )))
        (add-hook 'post-command-hook  'my-xterm-title-hook))
      (setq frame-title-format
            '(""
              "%b" (:eval (cond ((buffer-modified-p) " [*]"))) " - emacs")))

;; Make the mouse wheel scroll Emacs
(mouse-wheel-mode t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Don't automatically add new lines when scrolling down at the bottom
;; of a buffer
(setq next-line-add-newlines nil)

;; Change default major mode to text from fundamental
(setq default-major-mode 'text-mode)

;; Rebind `C-x C-b' to invoke `buffer-menu' rether then `list-buffers'
(global-set-key "\C-x\C-b" 'buffer-menu)

;; Toolbar off
(tool-bar-mode -1)

;; Parentheses pairing
(show-paren-mode t)

;; Encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

;; Custom key bindings
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(shift insert)] 'clipboard-yank)
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [f11] 'shell)
(require 'smart-compile)
(global-set-key [f6] 'smart-compile)

;; IswitchB - better buffer choosing
(iswitchb-mode 1)

;; SwBuff - cycling buffers with C-tab
(require 'swbuff)
(setq
    swbuff-clear-delay 1
    swbuff-exclude-buffer-regexps '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*Pymacs" "^\*Help"))
(global-set-key [(control tab)]       'swbuff-switch-to-next-buffer)
(global-set-key [(control shift tab)] 'swbuff-switch-to-previous-buffer)


;; Scrollbar
(set-scroll-bar-mode 'right)

;; Cursor blinking
(blink-cursor-mode 0)

;; TrampMode
(setq tramp-default-method "ssh")

;; Zooming buffer in/out
(require 'zoom-frm)
(setq zoom-frame/buffer 'buffer)
(global-set-key (if (boundp 'mouse-wheel-down-event) ; Emacs 22+
		    (vector (list 'control mouse-wheel-down-event))
		  [C-mouse-wheel])    ; Emacs 20, 21
		'zoom-in)
(when (boundp 'mouse-wheel-up-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-up-event))
		  'zoom-out))

;; Emacs window startup size
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1366)
        (add-to-list 'default-frame-alist (cons 'width 120))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
                 (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)


;; Replace polish diacritic signs
(defun replace-polish-signs ()
  "Do some replacements"
  (interactive)
  (let ((replacements (list '("ę" . "e") '("ó" . "o") '("ą" . "a")
			    '("ś" . "s") '("ł" . "l") '("ż" . "z")
			    '("ź" . "z") '("ć" . "c") '("ń" . "n"))))
    (save-excursion ; So point isn't moved after this function
      (mapc (lambda (x) ; Go through the list, with this 'inline' function
                        ; being called with each element as the variable 'x'
              (goto-char (point-min)) ; Start at the beginning of the buffer
              (while (re-search-forward (car x) nil t) ; Search for the car of the replacement
                (replace-match (cdr x)))) ; And replace it with the cdr
            replacements)))) ; The list we're mapc'ing through


;; Custom date display format
(setq european-calendar-style 't)
 (setq calendar-week-start-day 1
       calendar-day-name-array
         ["Niedziela" "Poniedzialek" "Wtorek" "Sroda"
          "Czwartek" "Piatek" "Sobota"]
       calendar-month-name-array
         ["Styczen" "Luty" "Marzec" "Kwiecien" "Maj"
          "Czerwiec" "Lipiec" "Sierpien" "Wrzesien"
          "Pazdziernik" "Listopad" "Grudzien"])

;; buffer's with same name now forwarded with directory, not <2>, <3>, ...
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; django-html-mode
(autoload 'django-html-mode "django-html-mode")
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\'" . django-html-mode))

(require 'django-mode)

;;;; END
(provide 'my-generic)
