;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin")
)

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
  "Return true if system is GNU/Linux-based"
  (string-equal system-type "gnu/linux")
)

(provide 'my-system)
