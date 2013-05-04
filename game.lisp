(load "pokerlib7.lisp")
(load "jose.lisp")

(defparameter *game-players* 
  (list *aggressive-caller-agent* *less-aggressive-caller-agent* *jose* *raiser-agent*))

(print (holdem-game-driver *game-players* :verbose nil :pauser nil))
