(defun action(roundstate id)
  (if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (blind roundstate id)))
    (3 (return-from action (informed roundstate id)))
    (4 (return-from action (informed roundstate id)))
    (5 (return-from action (informed roundstate id)))))


(defun informed(state id)
  (if (> (hand-strength (append (my_cards state id) (holdemround-commoncards state))) 50000)
    (LIST :raise (floor (* .25 (aref (holdemround-playerbanks state) id)))) 
    ;;else
    (LIST :check))
  ;;(cond
    ;;(scenario2 action2)
    ;;(scenario3 action3)
  ;;)
  ;;
)

(defun blind(state id)
    (if (pairp (my_cards state id))
      (case (random 2)
        (1 (LIST :raise (floor (* .15 (aref (holdemround-playerbanks state) id)))))
        (2 (LIST :call))))
    (case (random 4)
      (1 (LIST :raise (floor (* .05 (aref (holdemround-playerbanks state) id)))))
      (2 (LIST :check))
      (3 (LIST :fold))
      (4 (LIST :raise (floor (* .05 (aref (holdemround-playerbanks state) id)))))
      (t (LIST :call))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

