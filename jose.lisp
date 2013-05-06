(defun action(roundstate id)
  (if (eq (car (car (holdemround-actions roundstate))) 0) (LIST :FOLD))
  (if (zerop (holdemround-bet roundstate)) (LIST :check) ) 
  ;;(if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players
  (if (> (aref (holdemround-playerbanks roundstate) id)(* .9 (total_bank roundstate))) (LIST :allin)) ;;try to finish off players

  ;;(if (zerop (holdemround-bet roundstate)) (LIST :check) ) 
  (format t  "abcdef")
  (case (list-length (holdemround-commoncards roundstate))
    (0 (return-from action (before-flop roundstate id)))
        ;;you can only see your two cards
    (3 (return-from action (after-flop roundstate id)))
        ;;you can see the three cards on the table and your two cards
    (4 (return-from action (after-turn roundstate id)))
        ;;you can see the four cards on the table and your two cards
    (5 (return-from action (after-river roundstate id)))))
        ;;you can see all five cards on the table and your two cards


(defun informed(state id)
  (let ((cards (append (my_cards state id) (holdemround-commoncards state)))
        (mybank (aref (holdemround-playerbanks state) id)))
  (if (or (flushp cards) (straightp cards) (tripsp cards) (straightflushp cards) (fullhousep cards) (fourkindp cards) ) ;; if I have something good
    (LIST :raise (+ (floor (* .35 mybank)) (holdemround-blind state))) 
    (if (and (or (pairp cards) (twopairp cards) (< 5 (list-length (holdemround-commoncards state)))) (< (holdemround-bet state) ( * 0.15 mybank)))  ;; not so good
      (case (random 3)
        (0 (LIST :raise (+ (floor (* .10 mybank)) (holdemround-blind state))))
        (t (LIST :call)))
      ;; my hand sucks
      (if (and (< (holdemround-bet state) (* .15 mybank)) (< 5 (list-length (holdemround-commoncards state)))) ;; if bet is under 15% of my bank
          (LIST :call)
        (LIST :check)))
    ) 
))

(defun blind(state id)
  (let ((mybank (aref (holdemround-playerbanks state) id)))
  (if (> (aref (holdemround-playerbanks state) id) (holdemround-blind state)) (LIST :allin))
    (if (pairp (my_cards state id))
      (case (random 2)
        (0 (LIST :raise (holdemround-blind state)))
        (1 (LIST :call))))
    (if (< (holdemround-bet state) (* 0.15 mybank))
      (LIST :call)
      (LIST :check))))


(defun after-flop(state id)
  (format t "after-flop was called")

    (cond
      ((zerop (holdemround-bet state));;what to do if there is no bet so far
          (format t " about to progn ")
          (progn 
              (format t "no bet so far")
              (LIST :check)
          )
      )
      ((> (holdemround-bet state) 0);;what to do if there has been a bet so far
          (format t " about to progn ")
          (progn
            (format t "there has been a bet so far")
            (LIST :call)
          )

      )
      (t
          (progn
              (format t "somehow neither of these conditions were met")
              (LIST :allin) 
          )
          
      )

    );;end conditional




)
;   (let ((cards (append (my_cards state id) (holdemround-commoncards state)))
;         (mybank (aref (holdemround-playerbanks state) id)))
;   (if (or (flushp cards) (straightp cards) (straightflushp cards) (fullhousep cards) (fourkindp cards) ) ;; if I have something good
;     (LIST :raise (+ (floor (* .45 mybank)) (holdemround-blind state))) 
;     (if (and (or (pairp cards) (tripsp cards) (twopairp cards) (< 5 (list-length (holdemround-commoncards state)))) (< (holdemround-bet state) ( * 0.15 mybank)))  ;; not so good
;       (case (random 3)
;         (0 (LIST :raise (+ (floor (* .10 mybank)) (holdemround-blind state))))
;         (t (LIST :call)))
;       ;; my hand sucks
;       (if (and (< (holdemround-bet state) (* .15 mybank)) (< 5 (list-length (holdemround-commoncards state)))) ;; if bet is under 15% of my bank
;           (LIST :call)
;         (LIST :check)))
;     ) 
; ))



(defun after-turn(state id)
  (format t "after-turn called")
    (cond
      ((zerop (holdemround-bet state));;what to do if there is no bet so far
          (format t " about to progn ")
          (progn 
              (format t "no bet so far")
              (LIST :check)
          )
      )
      ((> (holdemround-bet state) 0);;what to do if there has been a bet so far
          (format t " about to progn ")
          (progn
            (format t "there has been a bet so far")
            (LIST :call)
          )

      )
      (t
          (progn
              (format t "somehow neither of these conditions were met")
              (LIST :allin) 
          )
          
      )
    );;end conditional



)

(defun after-river(state id)
  (format t "after-river called")
    (cond
      ((zerop (holdemround-bet state));;what to do if there is no bet so far
          (format t " about to progn ")
          (progn 
              (format t "no bet so far")
              (LIST :check)
          )
      )
      ((> (holdemround-bet state) 0);;what to do if there has been a bet so far
          (format t " about to progn ")
          (progn
            (format t "there has been a bet so far")
            (LIST :call)
          )

      )
      (t
          (progn
              (format t "somehow neither of these conditions were met")
              (LIST :allin) 
          )
          
      )
    );;end conditional



)

(defun before-flop(state id);this function gets called before there are any common cards
  (format t "before flop was called")
    (cond
      ((zerop (holdemround-bet state));;what to do if there is no bet so far
          (format t " about to progn ")
          (progn 
              (format t "no bet so far")
              (LIST :check)
          )
      )
      ((> (holdemround-bet state) 0);;what to do if there has been a bet so far
          (format t " about to progn ")
          (progn
            (format t "there has been a bet so far")
            (LIST :call)
          )
      )
      (t
          (progn
              (format t "somehow neither of these conditions were met")
              (LIST :allin) 
          )
          
      )

    );;end conditional
    



    ; (if (pairp (my_cards state id));;if my two cards are a pair
          
    ;     (if (> mymoney (+ (holdemround-blind roundstate)(holdemround-bet roundstate)))
    ;         (LIST :raise holdemround-blind) 
    ;         (LIST :allin)
    ;     )
          

    ;);end if
)

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state id)
  (aref (holdemround-playercards state) id))

(defun betamount(roundstate)
    (cond 
      (> (aref (holdemround-playerbanks roundstate) id) (+ (holdemround-blind roundstate)(holdemround-bet roundstate)))
            (LIST :raise (holdemround-blind roundstate))
      (t) 
            (LIST :allin));;end of cond
);;end of bet

(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

