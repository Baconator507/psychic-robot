(defun action(roundstate id)
  (if (string= (symbol-name (car (cdr (car (holdemround-actions roundstate))))) "CLEANUP")  (return-from action (LIST :FOLD)))
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (blind roundstate id)))
        ;;you can only see your two cards
    (t (return-from action (informed roundstate id)))))

(defun informed(state id)
  (let ((cards (best-texas-holdem-hand (holdemround-commoncards state) (my_cards state id)))
        (mybank (aref (holdemround-playerbanks state) id))(public_cards (list-length (holdemround-commoncards state))))
  (if (or (flushp cards) (straightp cards) (straightflushp cards)(fullhousep cards) (fourkindp cards) ) ;; if I have something good
    (return-from informed (betamount state id 0.55))
    (if (and (or (pairp cards) (twopairp cards)(< public_cards 4)(tripsp cards)))
      (case (random 3)
        (0 (return-from informed (betamount state id 0.15)))
        (t (LIST :call)))
      ;; my hand sucks
      (if (< (holdemround-bet state) (* .97 mybank)) 
          (LIST :call)
         (LIST :check)))
    ) 
))

(defun blind(state id)
  (let ((mybank (aref (holdemround-playerbanks state) id)))
  (if (> (aref (holdemround-playerbanks state) id) (holdemround-blind state)) (LIST :allin))
    (if (pairp (my_cards state id))
      (case (random 2)
        (0 (return-from blind (betamount state id 0.10)))
        (1 (LIST :call))))
    (if (< (holdemround-bet state) (* 0.95 mybank))
      (LIST :call)
      (LIST :check))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defun betamount(state id amount)
  ;(format t "made bet")
  (let ((mybank (aref (holdemround-playerbanks state) id))(minbet (+ (holdemround-blind state)(holdemround-bet state))))
    (cond 
      ((> mybank minbet)
        (LIST :raise (+ (floor (* amount mybank )) minbet)))
      (t 
        (LIST :allin)));;end of cond
));;end of bet

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

