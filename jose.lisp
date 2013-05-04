(defun action(roundstate id)
  (print (my_cards roundstate))
  (let ((mybank (aref (holdemround-playerbanks roundstate) id)))
    (cond ((zerop (holdemround-bet roundstate))
           (cond ((and (< (number-of-raises roundstate) 3)
                       (> mybank (holdemround-blind roundstate)))
                  (LIST :raise (holdemround-blind roundstate)))
                 ((and (< (number-of-raises roundstate) 3)
                       (<= mybank (holdemround-blind roundstate)))
                  (LIST :allin))
                 ((and (= (number-of-raises roundstate) 3)
                       (> mybank (holdemround-bet roundstate)))
                  (LIST :call))
                 ((and (= (number-of-raises roundstate) 3)
                       (< mybank (holdemround-bet roundstate)))
                  (LIST :allin))
                 (t (LIST :fold))))
          ((> mybank (+ (holdemround-blind roundstate) 
                        (holdemround-bet roundstate)))
           (LIST :raise (holdemround-blind roundstate)))
          (t ;; can't cover the bet or the blind
           (LIST :allin)))))

(defun total_bank(state)
  (reduce #'+ (holdemround-playerbanks state)))

(defun my_cards(state)
  (only_non_nil (holdemround-playercards state)))

(defun only_non_nil(x)
  (LOOP for i below (array-dimension x 0) doing
        (if (eq (aref x i) nil) ()
          (setf cards (aref x i))))cards)


(defparameter *jose* 
  (make-holdemagent
    :namestring "José" ;; Hola me llamo José
    :ID 507 ;;
    :agentfunction #'action))

