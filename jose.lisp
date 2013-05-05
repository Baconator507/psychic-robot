(defun action(roundstate id)
  (if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (blind roundstate id)))
        ;;you can only see your two cards
    (3 (return-from action (blind roundstate id)))
        ;;you can see the three cards on the table and your two cards
    (4 (return-from action (blind roundstate id)))
        ;;you can see the four cards on the table and your two cards
    (5 (return-from action (blind roundstate id)))))
        ;;you can see all five cards on the table and your two cards


(defun informed(state id)
  (setf cards (append (my_cards state id) (holdemround-commoncards state)))
  (setf strenght (hand-strength cards))
  (print strenght)
  (LIST :raise (+ (floor (* .25 (aref (holdemround-playerbanks state) id))) (holdemround-blind state))) 
  ;;(cond
    ;;(scenario2 action2)
    ;;(scenario3 action3)
  ;;)
  ;;
)

(defun blind(state id)
    (if (pairp (my_cards state id))
      (case (random 2)
        (0 (LIST :raise (floor (* .15 (aref (holdemround-playerbanks state) id)))))
        (1 (LIST :call))))
    (case (random 5)
      (0 (LIST :raise (floor (* .05 (aref (holdemround-playerbanks state) id)))))
      (1 (LIST :check))
      (2 (LIST :fold))
      (3 (LIST :raise (floor (* .05 (aref (holdemround-playerbanks state) id)))))
      (4 (LIST :call))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

