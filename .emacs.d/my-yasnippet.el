(add-to-list 'load-path
                  "~/emacs.d/3rd")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/emacs.d/snippets")

(provide 'my-yasnippet)
