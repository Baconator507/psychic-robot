(defun action(roundstate id)
  (if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (blind roundstate id)))
    (3 (return-from action (blind roundstate id)))
    (4 (return-from action (blind roundstate id)))
    (5 (return-from action (blind roundstate id)))))


(defun informed(state id)
  ;;(cond
    ;;(scenario2 action2)
    ;;(scenario3 action3)
  ;;)
)

(defun blind(state id)
    (if (pairp (my_cards state id))
      (case (random 2)
        (1 (LIST :raise (floor (* .15 (total_bank state)))))
        (2 (LIST :call))))
    (case (random 3)
      (1 (LIST :raise (holdemround-blind state)))
      (2 (LIST :check))
      (3 (LIST :call))
      (t (LIST :fold))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

