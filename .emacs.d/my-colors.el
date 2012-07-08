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

(require 'color-theme-monokai)
(setq color-theme-is-global t)
(color-theme-monokai)

;;;; END
(provide 'my-colors)
