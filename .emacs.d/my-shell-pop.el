;;;; Shell-pop settings

(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 30)

(global-set-key [f10] 'shell-pop)

;;;; END
(provide 'my-shell-pop)