(defun action(roundstate id)
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (conservative roundstate id)))
    (3 (return-from action (conservative roundstate id)))
    (4 (return-from action (conservative roundstate id)))
    (5 (return-from action (aggresive roundstate id)))))


(defun aggresive(state id)
  (if (> (aref (holdemround-playerbanks state) id)(* .9 (total_bank state))) (LIST :allin)) ;;try to finish off players
  ;;(cond
    ;;(scenario2 action2)
    ;;(scenario3 action3)
  ;;)
)

(defun conservative(state id)
    (if (> (aref (holdemround-playerbanks state) id)(* .9 (total_bank state))) (LIST :allin)) ;;try to finish off players
    (case (random 2)
      (1 (LIST :raise (holdemround-blind state)))
      (2 (LIST :check))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))


(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

