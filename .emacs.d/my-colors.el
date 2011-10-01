;;; Color and highlight emacs settings

;; Use colors to highlight commands, etc.
(global-font-lock-mode t)

;; Current line highlighting
(global-hl-line-mode 1)
(if window-system
    (progn 
      (set-face-background 'hl-line "black")
      (set-face-attribute hl-line-face nil :underline "red"))
  (set-face-background 'hl-line "red")
)


;; Color-theme
;; http://alexpogosyan.com/color-theme-creator/
(require 'color-theme)
(setq color-theme-is-global t)

(defun faces_x ()
  (interactive)
  (color-theme-install
   '(faces_x
      ((background-color . "#101e2e")
      (background-mode . light)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#800006"))))
     (region ((t (:background "#0d4519"))))
     (font-lock-builtin-face ((t (:foreground "#729fcf"))))
     (font-lock-comment-face ((t (:foreground "#888a85" :italic t))))
     (font-lock-function-name-face ((t (:foreground "#edd400"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf" :bold t))))
     (font-lock-string-face ((t (:foreground "#ad7fa8"))))
     (font-lock-type-face ((t (:foreground"#8ae234" :bold t))))
     (font-lock-variable-name-face ((t (:foreground "#ff9224"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     ))
)



(if window-system 
	(faces_x)
	(color-theme-midnight))



;;ZROB KEYWORDS BOLD!!!

;;;; END
(provide 'my-colors)
