(defun action(roundstate id)
  (declare (ignore roundstate id)) (LIST :fold))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

