;;;; my configs for slime

;; Load paths

;; SLIME setup:
(add-to-list 'load-path "~/emacs.d/3rd/slime")
(add-to-list 'load-path "~/emacs.d/3rd/slime/contrib")
(setq slime-backend "~/emacs.d/3rd/slime/swank-loader.lisp")
(load "slime-autoloads")
(require 'slime)
(require 'slime-autoloads)
(eval-after-load "slime"
`(progn
(slime-setup '(slime-repl))
(custom-set-variables
'(inhibit-splash-screen t)
'(slime-complete-symbol*-fancy t)
'(slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
'(slime-net-coding-system 'utf-8-unix)
'(slime-startup-animation nil)
'(slime-lisp-implementations '((sbcl ("/opt/local/bin/sbcl")))))))
;; Stop SLIME’s REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
(define-key slime-repl-mode-map
(read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
;;;; END

(provide 'my-slime)
