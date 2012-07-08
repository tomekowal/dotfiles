(load-file "~/.emacs.d/3rd/cedet-1.1/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)            ; Enable template insertion menu
(global-set-key (kbd "C-c c") 'semantic-ia-complete-symbol-menu)

(provide 'my-cedet)
