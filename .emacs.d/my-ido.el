;;;; IDO

(require 'ido)
(ido-mode t)
;; Standard mode
(setq
    ido-enable-flex-matching t	; enable fuzzy-matching
    ido-ignore-buffers 		; ignore this buffers
	'("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*Pymacs")
    ido-case-fold  t 		; case insensitive
    ido-max-prospects 6
)

;; M-x mode - smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Search for method definitions
(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a 
   symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
   
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
   
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
   
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

;;(global-set-key (kbd "C-f") 'ido-goto-symbol)

;;;; END
(provide 'my-ido)
