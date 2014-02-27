;; Date - 18 Jan 2014
;; Draw grid on the Viewframe
;; view center coordinate in modle space; view width in modle space; height and width of view port can be enquire from the view frame
;; scale = viewport_width/model_width.
;; assoc 12 - view center in mspace
;; assoc 45 - view height in mspace
;; assoc 40 - view width in pspace
;; assoc 41 - view height in pspace
;; lg_grid1.lsp 
;;  - add simple grid
;; how to draw gird
;; find first position of vertical grid and horizontal grid
;; find the leght from the corner_ gHLenght & gVLength
;; calculate firs postion of vertical grid and horizontal grid on layout frame
;; fstVFX = psLLX + (gHLength * scale)
;; fstVFY = psLLY + (gVLength * scale)
;; 
;; calulate the number of grid line required for Vertical and Horizontal grid
;; from these postions the rest number of grids will be draw with offset distance (grid spacing x scale) untill number of grids require
;; Future version
;; to use Reactor to make the grid change once the view inside the view port is changed automatically.

(defun getViewFrameParameters()
  	(princ "..Select a view frame..")
	(setq entl (entget (car (entsel))))

  	(defun getViewProperties()	  
	  (setq msCenterX (car(cdr(assoc 12 entl)))) 	; model center X	  	
	  (setq msCenterY (caddr(assoc 12 entl)))		; model center Y
	  (setq msHeight (cdr(assoc 45 entl))) 			; model height
	  (setq psCenterX (car(cdr(assoc 10 entl))))	; pspace view frame center X
	  (setq psCenterY (caddr(assoc 10 entl)))		; pspac view frame center Y
	  (setq psWidth  (cdr(assoc 40 entl))) 			; view width
	  (setq psHeight (cdr(assoc 41 entl))) 			; view frame height
	  (setq aspectRatio (/ psHeight psWidth))
	  (setq scale (/ psHeight msHeight))
	  (setq msWidth (/ msHeight aspectRatio)) 		; model width
	  (setq msLLX (- msCenterX (/ msWidth 2))) 		; Lower left corner X 
	  (setq msLLY (- msCenterY (/ msHeight 2))) 	; lower left corner Y
	  (setq msURX (+ msCenterX (/ msWidth 2))) 		; Upper right corner X
	  (setq msURY (+ msCenterY (/ msHeight 2))) 	; Upper right corner Y
	  (setq psLLX (- psCenterX (/ psWidth 2)))		; view frame lower left X
	  (setq psLLY (- psCenterY (/ psHeight 2)))		; view frame lower left Y
	  (setq psURX (+ psCenterX (/ psWidth 2)))		; view frame upper right X
	  (setq psURY (+ psCenterY (/ psHeight 2)))		; view frame upper right Y
	  (setq pt1 (list psLLX psLLY)) ; bottom left corner point of view frame
	  (setq pt2 (list psURX psURY)) ; top right corner point of view frame  
	  (princ "View center in mspace coordinate ") (princ msCenterX) (princ ",") (princ msCenterY)
	  (princ "\nView height in mspace ") (princ msHeight)
	  (princ "\nView height in pspace ") (princ psHeight)
	  (princ "\nscale ") (princ scale)
	  (princ "\nLower left corner in MSpace ") (princ msLLX)(princ ",") (princ msLLY)
	  (princ "\nUpper Right corner in MSpace ") (princ msURX)(princ ",") (princ msURY)
	  (princ "\n\nLower left corner in PSpace ") (princ psLLX)(princ ",") (princ psLLY)
	  (princ "\nUpper Right corner in PSpace ") (princ psURX)(princ ",") (princ psURY)
	  (princ); to remove the echo	  
	
	) ;END of getViewProperties()
	
  	(if (= (cdr(assoc 0 entl)) "VIEWPORT")
	  (getViewProperties)
	  (progn
		(princ "\n..It is not a view frame!!")
		(princ); to remove the echo	
		(exit)
	  )
	);END if
) ;END of getViewFrameParameters()
; (defun req ()
	; (setq  pt1 (list psLLX psLLY))
	; (setq pt2 (list psURX psURY))
; )	

(defun lg_dialog ()
	(setq gridSpacing 10)
	(setq txtSize 0.25)
	(setq txtIndent 0.25)
	
	(if (= "1" (get_tile "txtout"))
		   (mode_tile "annogrd" 0)
		   (mode_tile "annogrd" 1)
	)	

	(if (/= 0 annogrd) (setq annogrd 0))
	(set_tile "annogrd" (itoa annogrd))

	(if (/= 0 txtout) (setq txtout 0))
	(set_tile "txtout" (itoa txtout))

	(if (/= 0 minorgd) (setq minorgd 0))
    	(set_tile "minorgd" (itoa minorgd))

	(setq dcl_id (load_dialog "ddgrid.dcl"))
	(if(not(new_dialog "gd_box1" dcl_id))(exit))
	(set_tile "gd_spc" "10")
	(set_tile "gd_txt" "0.25")
	(set_tile "gd_txsp" "0.2")
	
	(action_tile "annogrd"		"(setq annogrd (atoi $value))")
	(action_tile "txtout" 		"(setq txtout (atoi $value))")
	(action_tile "minorgd" 		"(setq minorgd (atoi $value))")

	(setq txtj1 "BL") 
	(setq txtj2 "BR")
	
	(action_tile "accept"
		(strcat "(progn(setq gridSpacing(atoi (get_tile \"gd_spc\")))
			       (setq txtSize(atof (get_tile \"gd_txt\")))
			       (setq txtIndent(atof (get_tile \"gd_txsp\")))"
					"(done_dialog))"
		)
	)
	(action_tile "cancel" "(done_dialog) (setq gperr \"\")(exit)")
	(start_dialog)
	(unload_dialog dcl_id)
) ; END of lg_dialog ()

(defun lg_err (msg)
	(setq *error* olderr)
	(if (not lgerr)
	    (princ (strcat "\nLayout Grid Maker error: " msg))
	    (princ lgerr)
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;first major coordinate points
(defun firstPts ()
	(setq index1 1)
	(setq w "w") 
	(while w
	        (setq x1(* gridSpacing index1))
	        (setq index1 (+ 1 index1))
			(if (> x1 msLLX)  (setq w nil))			
	)
	
	(setq msHdist1(- x1 msLLX)) ; distance of first X from the LL corner
	(setq psHdist1(* msHdist1 scale))
	(setq xLabel x1) ;first label text for x coordinate
	(setq x1 (+ psLLX psHdist1)) ; x1 is now paper space x
	
	(setq index2 1)
	(setq w "w") 
	(while w
            (setq y1(* gridSpacing index2))	
			(setq index2 (+ 1 index2))
			(if (> y1 msLLY)  (setq w nil))
	)
	
	(setq msVdist1(- y1 msLLY)) ; distance of first Y from the LL corner
	(setq psVdist1(* msVdist1 scale))
	(setq yLabel y1) ;first label text for y coordinate
	(setq y1 (+ psLLY psVdist1)) ;y1 is now paperspace y
	(setq vPt1 (list x1 psLLY)) ; start point of vertical line
	(setq vPt2 (list x1 psURY)) ; end point of vertical line
	(setq hPt1 (list psLLX y1)) ; start point of horizontal line
	(setq hPt2 (list psURX y1)) ; end point of horisontal line
	
)
;/////////////////////////////////////////////////////////////////////////////////////////////////////

(defun drawMinorGrids ()
	(setq msVPt1 (list (+ (/ gridSpacing 2) x1) msLLY)) 
	(setq msVPt2 (list (+ (/ gridSpacing 2) x1) msURY)) 
	(setq msHPt1 (list msLLX (+ (/ gridSpacing 2) y1)))  
	(setq msHPt2 (list msURX (+ (/ gridSpacing 2) y1)))  
	(setq w "w")
	(setq color (getvar "CECOLOR"))
	(setq osmode (getvar "OSMODE"))
	(setvar "OSMODE" 0)
	(setvar "CECOLOR" "8")
	(if (>  (- x1 (/ gridSpacing 2)) msLLX)
		(progn
			(setq msVPt1 (list ( - x1 (/ gridSpacing 2)) msLLY))
			(setq msVPt2 (list ( - x1 (/ gridSpacing 2)) msURY))
		)
	)
	(if (>  (- y1 (/ gridSpacing 2)) msURY)
		(progn
		 	(setq msHPt1 (list msLLX (- y1 (/ gridSpacing 2))))
		 	(setq msHPt2 (list msURX (- y1 (/ gridSpacing 2))))
		)
	)
	(setq newMsVPt1 msVPt1)
	(setq newMsVPt2 msVPt2)
	(setq newMsHPt1 msHPt1)
	(setq newMsHPt2 msHPt2)
	(while w
		(command "line" newMsVPt1 newMsVPt2 "")
		;(setq newMsVPt1(list (+(car newMsVPt1) gridSpacing)(cadr pt1)))
		(setq newMsVPt1(list (+(car newMsVPt1) gridSpacing) psLLY))
		;(setq newMsVPt2(list (+(car newMsVPt2) gridSpacing) (cadr pt2)))
		(setq newMsVPt2(list (+(car newMsVPt2) gridSpacing) psURY))
		;(if (> (car newMsVPt1) (car pt2))(setq w nil))
		(if (> (car newMsVPt1) psURX)(setq w nil))
	)
	(setq w "w")
	(while w
		(command "line" newMsHPt1 newMsHPt2 "")
		;(setq newMsHPt1(list (car pt1)(+(cadr newMsHPt1) gridSpacing)))
		(setq newMsHPt1(list psLLX (+(cadr newMsHPt1) gridSpacing)))
		;(setq newMsHPt2(list (car pt2)(+(cadr newMsHPt2) gridSpacing)))
		(setq newMsHPt2(list psURX (+(cadr newMsHPt2) gridSpacing)))
		;(if (> (cadr newMsHPt1) (cadr pt2))(setq w nil))
		(if (> (cadr newMsHPt1) psURY)(setq w nil))
		
	)
	(setvar "CECOLOR" color)
	(setvar "OSMODE" osmode)

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Draw Major Grid
(defun drawMajorGrids ()
	(firstPts)
	(setq osmode (getvar "OSMODE"))
	(setvar "OSMODE" 0)
	(setq newVPt1 vPt1)
	(setq newVPt2 vPt2)
	(setq newHPt1 hPt1)
	(setq newHPt2 hPt2)
	(setq w "w")
	(while w
		(command "line" newVPt1 newVPt2 "")
		(setq newVPt1(list (+(car newVPt1) (* gridSpacing scale))psLLY))
		(setq newVPt2(list (+(car newVPt2) (* gridSpacing scale))psURY))
		(if (> (car newVPt1) psURX)(setq w nil))		
	)
	(setq w "w")
	(while w
		(command "line" newHPt1 newHPt2 "")
		(setq newHPt1(list psLLX (+(cadr newHPt1) (* gridSpacing scale))))
		(setq newHPt2(list psURX (+(cadr newHPt2) (* gridSpacing scale))))
		(if (> (cadr newHPt2) psURY)(setq w nil))
	)
	(setvar "OSMODE" osmode)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add label to the grids
(defun addLabelTexts()
	(setq osmode (getvar "OSMODE"))
	(setvar "OSMODE" 0)
	(setq newVPt1 vPt1)
	(setq newVPt2 vPt2)
	(setq newHPt1 hPt1)
	(setq newHPt2 hPt2)
	(setq w "w")
	
	(while w
		(command "text" "j" txtj1 (list(car newVPt1)(+(cadr newVPt1)txtIndent)) txtSize "90" (rtos xLabel))
		(command "text" "j" txtj1 (list(car newVPt2)(-(cadr newVPt2)txtIndent)) txtSize "270" (rtos xLabel))
		(setq newVPt1(list (+(car newVPt1) (* gridSpacing scale))psLLY))
		(setq newVPt2(list (+(car newVPt2) (* gridSpacing scale))psURY))
		(setq xLabel (+ xLabel gridSpacing)) ;prepare next label text
		(if (> (car newVPt1) psURX)(setq w nil))
	)
	(setq w "w")
	(while w
		(command "text" "j" txtj1 (list(+(car newHPt1)txtIndent)(cadr newHPt1)) txtSize "0" (rtos yLabel))
		(command "text" "j" txtj2 (list(-(car newHPt2)txtIndent)(cadr newHPt2)) txtSize "0" (rtos yLabel))
		(setq newHPt1(list psLLX (+(cadr newHPt1) (* gridSpacing scale))))
		(setq newHPt2(list psURX (+(cadr newHPt2) (* gridSpacing scale))))
		(setq yLabel (+ yLabel gridSpacing)) ;prepare next label text
		(if (> (cadr newHPt2) psURY)(setq w nil))
	)
	(setvar "OSMODE" osmode)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Main command
(defun c:LG1 ()
	(setq olderr *error*
		*error* lg_err
		lgerr nil
	)
	(setvar "cmdecho"0)
	(getViewFrameParameters)
	
	(lg_dialog)
	;(req)
	(drawMajorGrids)
	
	(if (= txtout 1)
	    (progn (setq txtj1 "MR")
		   (setq txtj2 "ML")
 		   (setq txtIndent (* txtIndent -1))
		   (setq annogrd 1)	
	    )	
	)
	(if (= annogrd 1)
	    (addLabelTexts)
	)
	(if (= minorgd 1)
	    (drawMinorGrids)
	)
	(princ)
)
(princ "\nLG_GRID1.lsp loaded. Type LG1 to use.")
(princ)