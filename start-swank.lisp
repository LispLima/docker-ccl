(unless (member :quicklisp *features*)
  (load "~/quicklisp/setup.lisp"))

(ql:quickload "swank")
(setf swank::*LOOPBACK-INTERFACE* "0.0.0.0")
(swank:create-server :port 4005
                     :dont-close t)
