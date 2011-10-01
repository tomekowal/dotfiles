;; my configurations for erlang-mode

;; paths to erlang on arch
;; disable closing emacs in Mac OS X
(if (system-type-is-gnu)
    (progn
      (setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.6.1/emacs"
                             load-path))
      (setq erlang-root-dir "/usr/local/lib/erlang")
      (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
      (require 'erlang-start)))

(if (system-type-is-gnu)
    (progn
      (setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.6.1/emacs"
                             load-path))
      (setq erlang-root-dir "/usr/local/lib/erlang")
      (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
      (require 'erlang-start)))

(provide 'my-erlang)
