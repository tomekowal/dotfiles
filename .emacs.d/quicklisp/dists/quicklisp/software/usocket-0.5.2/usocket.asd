;;;; -*- Mode: Lisp -*-
;;;; $Id: usocket.asd 633 2011-04-01 12:06:23Z ctian $
;;;; $URL: svn://common-lisp.net/project/usocket/svn/usocket/tags/0.5.2/usocket.asd $

;;;; See the LICENSE file for licensing information.

(in-package :cl-user)

(defpackage usocket-system
    (:use :cl :asdf))

(in-package :usocket-system)

(defsystem usocket
    :name "usocket"
    :author "Erik Enge & Erik Huelsmann"
    :maintainer "Chun Tian (binghe)"
    :version "0.5.1"
    :licence "MIT"
    :description "Universal socket library for Common Lisp"
    :depends-on (#+sbcl :sb-bsd-sockets)
    :components ((:file "package")
		 (:module "vendor" :depends-on ("package")
		  :components ((:file "split-sequence")
			       #+mcl (:file "kqueue")
			       #+openmcl (:file "ccl-send")
                               (:file "spawn-thread")))
                 (:file "usocket" :depends-on ("vendor"))
                 (:file "condition" :depends-on ("usocket"))
		 (:module "backend" :depends-on ("condition")
		  :components (#+abcl		(:file "abcl")
			       #+clisp		(:file "clisp")
			       #+cmu		(:file "cmucl")
			       #+scl		(:file "scl")
			       #+(or sbcl ecl)	(:file "sbcl")
			       #+lispworks	(:file "lispworks")
			       #+mcl		(:file "mcl")
			       #+openmcl	(:file "openmcl")
			       #+allegro	(:file "allegro")))
		 (:file "server" :depends-on ("backend"))))

(defmethod perform ((op test-op) (c (eql (find-system :usocket))))
  (oos 'load-op :usocket-test)
  (oos 'test-op :usocket-test))
