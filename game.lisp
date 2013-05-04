(load "pokerlib7.lisp")
(load "jose.lisp")

(defparameter *game-players* 
  (list *aggressive-caller-agent* *less-aggressive-caller-agent* *jose* *raiser-agent*))

(holdem-game-driver *game-players* :verbose t :pauser nil)
