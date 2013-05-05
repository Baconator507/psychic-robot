(defun action(roundstate id)
  (if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (blind roundstate id)))
        ;;you can only see your two cards
    (3 (return-from action (informed roundstate id)))
        ;;you can see the three cards on the table and your two cards
    (4 (return-from action (informed roundstate id)))
        ;;you can see the four cards on the table and your two cards
    (5 (return-from action (informed roundstate id)))))
        ;;you can see all five cards on the table and your two cards


(defun informed(state id)
  (let ((cards (append (my_cards state id) (holdemround-commoncards state)))
        (mybank (aref (holdemround-playerbanks state) id)))
  (if (or (flushp cards) (straightp cards) (straightflushp cards) (fullhousep cards) (fourkindp cards) (twopairp cards) ) ;; if I have something good
    (LIST :raise (+ (floor (* .25 mybank)) (holdemround-blind state))) 
    (if (or (pairp cards) (tripsp cards)) ;; not so good
      (case (random 3)
        (0 (LIST :raise (+ (floor (* .10 mybank)) (holdemround-blind state))))
        (t (LIST :call)))
      ;; my hand sucks
      (if (or (< (holdemround-bet state) (* .15 mybank)) (< 5 (list-length (holdemround-commoncards state)))) ;; if bet is under 15% of my bank
        (case (random 10)
          (0 (LIST :raise (holdemround-blind state)))
          (t (LIST :call)))
        (LIST :check)))
    ) 
))

(defun blind(state id)
  (if (> (aref (holdemround-playerbanks state) id) (holdemround-blind state)) (LIST :allin))
    (if (pairp (my_cards state id))
      (case (random 2)
        (0 (LIST :raise  (holdemround-blind state)))
        (1 (LIST :call))))
    (case (random 5)
      (0 (LIST :raise  (holdemround-blind state)))
      (1 (LIST :check))
      (2 (LIST :call))
      (3 (LIST :raise  (holdemround-blind state)))
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

