;; Date - 18 Jan 2014
;; Draw grid on the Viewframe
;; view center coordinate in modle space; view width in modle space; height and width of view port can be enquire from the view frame
;; scale = viewport_width/model_width.
;; assoc 12 - view center in mspace
;; assoc 45 - view height in mspace
;; assoc 10 - view center in pspace
;; assoc 40 - view width in pspace
;; assoc 41 - view height in pspace

(defun c:LG()
  	(princ "..Select a view port..")
	(setq entl (entget (car (entsel))))

  	(defun lg_grid()
	  
	  (setq msCenterX (car(cdr(assoc 12 entl)))) 	; model center X	  	
	  (setq msCenterY (caddr(assoc 12 entl)))	; model center Y
	  (setq msHeight (cdr(assoc 45 entl))) 		; model height
	  (setq psCenterX (car(cdr(assoc 10 entl))))	; pspace view frame center X
	  (setq psCenterY (caddr(assoc 10 entl)))	; pspac view frame center Y
	  (setq psWidth  (cdr(assoc 40 entl))) 		; view width
	  (setq psHeight (cdr(assoc 41 entl))) 		; view frame height
	  (setq aspectRatio (/ psHeight psWidth))
	  (setq msWidth (/ msHeight aspectRatio)) 	; model width
	  (setq msLLX (- msCenterX (/ msWidth 2))) 	; Lower left corner X 
	  (setq msLLY (- msCenterY (/ msHeight 2))) 	; lower left corner Y
	  (setq msURX (+ msCenterX (/ msWidth 2))) 	; Upper right corner X
	  (setq msURY (+ msCenterY (/ msHeight 2))) 	; Upper right corner Y
	  (setq psLLX (- psCenterX (/ psWidth 2)))
	  (setq psLLY (- psCenterY (/ psHeight 2)))
	  (setq psURX (+ psCenterX (/ psWidth 2)))
	  (setq psURY (+ psCenterY (/ psHeight 2)))
	  (princ "View center in mspace coordinate ") (princ msCenterX) (princ ",") (princ msCenterY)
	  (princ "\nView height in mspace ") (princ msHeight)
	  (princ "\nView height in pspace ") (princ psHeight)
	  (princ "\nscale ")(princ (/ psHeight msHeight))
	  (princ "\nLower left corner in MSpace ") (princ msLLX)(princ ",") (princ msLLY)
	  (princ "\nUpper Right corner in MSpace ") (princ msURX)(princ ",") (princ msURY)
	  (princ "\n\nLower left corner in PSpace ") (princ psLLX)(princ ",") (princ psLLY)
	  (princ "\nUpper Right corner in PSpace ") (princ psURX)(princ ",") (princ psURY)
	  (princ); to remove the echo	  
	  
	) ;END of lg_grid()
  	(if (= (cdr(assoc 0 entl)) "VIEWPORT")
	  
	  (lg_grid)
	  (progn
		(princ "\n..It is not a view port!!")
		(princ); to remove the echo	
	  )

	);END if
		

) ;END of main function LG
;;;	(setq entl (entget (car (entsel)))) ; select and get the entity
;;;  	(setq ct 0)              ; Set ct (a counter) to 0.
;;;	(textpage)               ; Switch to the text screen.
;;;	(princ "\nentget of last entity:")
;;;	(repeat (length entl)    ; Repeat for number of members in list:
;;;		(print (nth ct entl))  ; Print a newline, then each list 
;;;		; member.
;;;		(setq ct (1+ ct))      ; Increments the counter by one.
;;;	)
;;;	(princ) 