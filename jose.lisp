(defun action(roundstate id)

  (cond
    ((> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin))
    ;;(scenario2 action2)
    ;;(scenario3 action3)
    (t (case (random 4)
        (1 (LIST :raise (holdemround-blind roundstate)))
        
        (2 (LIST :fold))
        (3 (LIST :check))
        (4 (LIST :call))))
  )
)





(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))


(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

