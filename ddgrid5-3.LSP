;;This is Program was written by Kyaw Naing Win ex-Survey-GIS Specialist, WADP HQ, Mong Pawk.
;;I am currently working as IMO in UNITED NATIONS OCHA PAKISTAN
;;email: kyawnaingwinknw@gmail.com
;;---------------------------------------------------------------------------------------
;;You must maitain my information intact.
;;I grant you to use this program without any charges 
;;I do not grant that it will be error free and therefore
;;use it at your own risk.
;;----------------------------------------------------------------------------------------
; (defun c:delgrid (); delete grids just created but not other objects 
  ; (command "erase" "all" "remove" "p" "")
  ; (command "purge" "layer" "grid" "y" "") ; to erase grid layer
; )  ; this part of program may accdentally erase existing objects if there is no grids.

(defun c:DDGRID	()
					;to save old system variables
  (setq oldCecolor (getvar "cecolor"))
  (setq oldOsmode (getvar "osmode"))
  (setq oldCmdecho (getvar "cmdecho"))
  (setq oldLuprec (getvar "luprec"))
  (setq oldTextsize (getvar "textsize"))
  (setq oldClayer (getvar "clayer"))
  (setq oldAngbase (getvar "ANGBASE"))
  (setq oldAngdir (getvar "ANGDIR"))
					;to off osmode and command line echo
  (setvar "osmode" 0)
  (setvar "cmdecho" 0)
  ;(ssget "all");to be sure to save previously drawn objects from in case of erasing grids
  
  (defun RESTORE_VAR_SETTINGS ()
    (setvar "CECOLOR" oldCecolor)
    (setvar "OSMODE" oldOsmode)
    (setvar "LUPREC" oldLuprec)
    (setvar "CMDECHO" oldCmdecho)
    (setvar "TEXTSIZE" oldTextsize)
    (setvar "clayer" oldClayer)
	(setvar "ANGBASE" oldAngbase)
	(setvar "ANGDIR" oldAngdir)
  )
 (defun MAKE_GRID_LAYER ()
    (command "-layer" "n" "Grid" "s" "Grid" "")
 )
 
  (defun ONOFF () ; contorlling which one to turn on and off when check boxes aer clicked on the interface
    (if	(= "1" (get_tile "minorgd"))
      (progn (mode_tile "mngd_color" 0)
	     (mode_tile "mngdcolor_text" 0)
	     (mode_tile "mngdcolor_image" 0)
					;(mode_tile "mngd_spc" 0)
	     (mode_tile "mngd_Vno" 0)	; new syntax
	     (mode_tile "mngd_Hno" 0)	; new syntax
      )
      (progn (mode_tile "mngd_color" 1)
	     (mode_tile "mngdcolor_text" 1)
	     (mode_tile "mngdcolor_image" 1)
					;(mode_tile "mngd_spc" 1)
	     (mode_tile "mngd_Vno" 1)	; new syntax
	     (mode_tile "mngd_Hno" 1)	; new syntax
      )
    )
    (if	(= "1" (get_tile "annogrd"))
      (progn (mode_tile "mjgdtext_color" 0)
	     (mode_tile "txtout" 0)
	     (mode_tile "gd_txt" 0)
	     (mode_tile "gd_txind" 0)
	     (mode_tile "mjgdtext_colortext" 0)
	     (mode_tile "textcolor_image" 0)
	     (mode_tile "h_scale" 0)
	     (mode_tile "v_scale" 0)
	     (mode_tile "l_uprec" 0)
	     (mode_tile "below_left" 0)
	     (mode_tile "prefix_n" 0)
	     (mode_tile "prefix_e" 0)
	     (mode_tile "suffix_n" 0)
	     (mode_tile "suffix_e" 0)
	     	     
      )
      (progn (mode_tile "mjgdtext_color" 1)
	     (mode_tile "txtout" 1)
	     (mode_tile "gd_txt" 1)
	     (mode_tile "gd_txind" 1)
	     (mode_tile "mjgdtext_colortext" 1)
	     (mode_tile "textcolor_image" 1)
	     (mode_tile "h_scale" 1)
	     (mode_tile "v_scale" 1)
	     (mode_tile "l_uprec" 1)
	     (mode_tile "below_left" 1)
	     (mode_tile "prefix_n" 1)
	     (mode_tile "prefix_e" 1)
	     (mode_tile "suffix_n" 1)
	     (mode_tile "suffix_e" 1)
      )
    )
  )

  ;;
  ;;set major grid colors from color dialogue.
  ;;
  (defun SET_MAJOR_GRID_COLOR ()
    (if	(setq temp_color (acad_colordlg majorGridColor 256))
      (progn
		(setq majorGridColor temp_color)
		(set_tile "mjgdcolor_text" (GRID_COLOR majorGridColor "mjgd"))
		(start_image "mjgdcolor_image")
		(fill_image
		  0
		  0
		  x_swatch
		  y_swatch
		  (IMAGE_COLOR majorGridColor "mjgd")
		)
		(end_image)
		  )
    )
  )
  ;;set grid text colors from color dialogue.
  ;;
  (defun SET_MAJOR_GRID_TEXT_COLOR ()
    (if	(setq temp_color (acad_colordlg 7 7))
      (progn
		(setq majorGridTextColor temp_color)
		(set_tile "mjgdtext_colortext"
			  (GRID_COLOR majorGridTextColor "mjgdtext")
		)
		(start_image "textcolor_image")
		(fill_image
		  0
		  0
		  x_swatch
		  y_swatch
		  (IMAGE_COLOR majorGridTextColor "mjgdtext")
		)
		(end_image)
      )
    )
  )
  ;;
  ;;select minor grid color	
  (defun SET_MINOR_GRID_COLOR ()
    (if	(setq temp_color (acad_colordlg 8 8))
      (progn
		(setq minorGridColor temp_color)
		(set_tile "mngdcolor_text" (GRID_COLOR minorGridColor "mngd"))
		(start_image "mngdcolor_image")
		(fill_image
		  0
		  0
		  x_swatch
		  y_swatch
		  (IMAGE_COLOR minorGridColor "mngd")
		)
		(end_image)
      )
    )
  )
  ;;
  ;;if the color is zero pass correct color number
  (defun IMAGE_COLOR (colorint whichgrid)
    (cond
      ((and (= 0 colorint) (= whichgrid "mjgd")) 7)
      ((and (= 0 colorint) (= whichgrid "mjgdtext")) 7)
      ((and (= 0 colorint) (= whichgrid "mngd")) 8)
      (t colorint)
    )
  )
  ;;
  ;;pass an integer and recieve a string stating the color name
  (defun GRID_COLOR (colorint whichgrid)
    (cond
      ((and (= 0 colorint) (= whichgrid "mjgd")) "7 - White")
      ((and (= 0 colorint) (= whichgrid "mjgdtext")) "7 - White")
      ((and (= 0 colorint) (= whichgrid "mngd")) "8 - Grey")
      ((= 1 colorint) "1 - Red")
      ((= 2 colorint) "2 - Yellow")
      ((= 3 colorint) "3 - Green")
      ((= 4 colorint) "4 - Cyan")
      ((= 5 colorint) "5 - Blue")
      ((= 6 colorint) "6 - Meganta")
      ((= 7 colorint) "7 - White")
      ((= 8 colorint) "8 - Grey")
      (t (itoa colorint))
    )
  )
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;getting information form the interface;;;;
  (defun GET_USER_INPUTS ()
    (setq spcH (atoi (get_tile "gd_spcH"))); horizontal spacing
    (setq spcV (atoi (get_tile "gd_spcV"))); vertical spacing
    (setq mngdHno (atoi (get_tile "mngd_Hno"))) ; number of minor grids in between of two horizontal grids
    (setq mngdVno (atoi (get_tile "mngd_Vno"))) ; number of minor grids in between of two vertical grids
    (setq scaleH (atof (get_tile "h_scale"))) ; horizontal scale
    (setq scaleV (atof (get_tile "v_scale"))) ; vertical scale
    (setq txtSize (atof (get_tile "gd_txt")))
    (setq txtIndent (atof (get_tile "gd_txind")))
    (setq annogrd (get_tile "annogrd")) ; check labeling requirement
    (setq minorgd (get_tile "minorgd")) ; check minor grid requirement
    (setq gridLayer (get_tile "grid_layer")) ;check grid layer requirement
    (setq luprec (atoi (get_tile "l_uprec"))) ; decimal precision
    (setq BelowLeft (get_tile "below_left"))
    (setq txtout (get_tile "txtout")) ; labeling option inside/outside
    (setq prefixN (get_tile "prefix_n"))
    (setq prefixE (get_tile "prefix_e"))
    (setq suffixN (get_tile "suffix_n"))
    (setq suffixE (get_tile "suffix_e"))
    (done_dialog)
  )					;end  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;;Put up dialogue
  (defun DDGRID_MAIN ()
    (if	(not (new_dialog "gd_box1" dcl_id))
      (exit)
    )
    (setq cecolor	(getvar "cecolor")
	  majorGridColor	(atoi cecolor)
	  minorGridColor	8
	  majorGridTextColor	7
    )

    (set_tile "gd_spcH" "100")
    (set_tile "gd_spcV" "100")
    (set_tile "annogrd" "1")
    (set_tile "txtout" "1")
    (set_tile "gd_txt"   (rtos oldTextsize 2 1))
    (set_tile "gd_txind" (rtos oldTextsize 2 1))
    (set_tile "mngd_Hno" "1")		
    (set_tile "mngd_Vno" "1")			 
    (set_tile "h_scale" "1")	
    (set_tile "v_scale" "1")
    (set_tile "l_uprec" "0")		;(itoa oldLuprec)
    (set_tile "prefix_n" "N ")
    (set_tile "prefix_e" "E ")
    (set_tile "suffix_n" "")
    (set_tile "suffix_e" "")

    (setq x_swatch (dimx_tile "mjgdcolor_image"))
    (setq y_swatch (dimy_tile "mjgdcolor_image"))

    ;; to display current color
    (start_image "mjgdcolor_image")
    (fill_image
      0
      0
      x_swatch
      y_swatch
      (IMAGE_COLOR majorGridColor "mjgd")
    )
    (end_image)

    (start_image "textcolor_image")
    (fill_image
      0
      0
      x_swatch
      y_swatch
      (IMAGE_COLOR 7 "mjgdtext")
    )
    (end_image)

    (start_image "mngdcolor_image")
    (fill_image
      0
      0
      x_swatch
      y_swatch
      (IMAGE_COLOR 8 "mngd")
    )
    (end_image)
					;(label)
    (onoff)
    (action_tile "annogrd" "(ONOFF)")
    (action_tile "minorgd" "(ONOFF)")
    (action_tile "mjgd_color" "(SET_MAJOR_GRID_COLOR)")
    (action_tile "mjgdtext_color" "(SET_MAJOR_GRID_TEXT_COLOR)")
    (action_tile "mngd_color" "(SET_MINOR_GRID_COLOR)")
    (action_tile "accept" "(GET_USER_INPUTS)")
    (action_tile
      "cancel"
      "(done_dialog) (princ \";User Cancel....\")(exit)"
    )
    (start_dialog)
    (unload_dialog dcl_id)
  )
;;;
;;;
  (defun GET_GRID_FRAME ()
					; ask user to draw a rectangle on the screen
    (setq p1 (getpoint "::First Corner Point"))
    (terpri)
    (setq p2 (getcorner p1 "::Second Corner Point"))
    (terpri)
    (setq p1x (car p1))
    (setq tmpX1 p1x)
    (setq p1y (cadr p1))
    (setq tmpY1 p1y)
    (setq p2x (car p2))
    (setq tmpX2 p2x)
    (setq p2y (cadr p2))
    (setq tmpY2 p2y)
					;whatever corner points are selected it should be standarized as lower left and upper right corner

					; compact code for setting proper point1 (LLC) and point2 (URC)
    (if	(> p1x p2x)
      (progn (setq tmpX1 p2x) (setq tmpX2 p1x))
    )
    (if	(> p1y p2y)
      (progn (setq tmpY1 p2y) (setq tmpY2 p1y))
    )
    (setq p1 (list tmpX1 tmpY1))
    (setq p2 (list tmpX2 tmpY2))
    
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 			;first coordinate point to be marked   revamped codes                         ;;
  ;;this function was improved to run in negative quadrants                              ;;
  ;;; revamped codes - 26 Feb 2014
  (defun GET_FIRST_POINTS()
    	(setq x1 (car p1))
    	(setq y1 (cadr p1))
	(setq index1 (fix (/ x1 spcH)))
	(setq index2 (fix (/ y1 spcV)))
	(setq x1 (* index1 spcH))
	(setq y1 (* index2 spcV))
	(if (< x1 (car p1)) (progn (setq index1 (+ index1 1)) (setq x1 (+ x1 spcH) ))) ; to make sure star x is after the left margin line
	(if (< y1 (cadr p1)) (progn (setq index2 (+ index2 1)) (setq y1 (+ y1 spcV) ))) ; to make sure start y is about the bottom line
	(setq vp1 (list x1 (cadr p1)))	; start point of first vertical line major
	(setq vp2 (list x1 (cadr p2)))	; end point of vertical line
	(setq hp1 (list (car p1) y1))	; start point of first horizontal line major
	(setq hp2 (list (car p2) y1))	; end point of first horizontal line

    	; indexes for labelling
    	(setq lbindex1 index1)	
    	(setq lbindex2 index2)
	
  ) ;END of GET_FIRST_POINTS()
  
  
  

					;/////////////////////////////////////////////////////////////////////////////////////////////////////
  ;;Drawing minor grids
  (defun DRAW_MINOR_GRID_H ()
    (setvar "CMDECHO" 0)
    (setvar "OSMODE" 0)
    (setvar "CECOLOR" (itoa minorGridColor))
    (setq count mngdHno)
    (setq mngdspc (/ spcH (+ mngdHno 1)))	;convert from number of minor grid to minorgrid spacing
    (setq mngdspcH mngdspc)
    (setq vpm1 (list (+ mngdspc x1) (cadr p1)))
					
    (setq vpm2 (list (+ mngdspc x1) (cadr p2)))
    (setq countdownV 0)
    (setq k1 "k")
    (while k1				; to be sure to draw first minor grid
      (if (> (- x1 mngdspcH) (car p1))
		(progn
		  (setq countdownV (+ 1 countdownV))
		  (setq vpm1 (list (- x1 mngdspcH) (cadr p1)))
		  (setq vpm2 (list (- x1 mngdspcH) (cadr p2)))
		  (setq mngdspcH (+ mngdspcH mngdspc))
		)
		(setq k1 nil)
      )

    )
					;if there is no minor grid before first major grid,
                                        ;countdown_ 0 cannot remind to ommit
    
					;drawing minor grid over major one
					;therefore following syntax is added.
    (if	(= countdownV 0)
      (setq countdownV count)
    )
;;;; draw minor grid vertical;;;;;
    (setq nvpm1 vpm1)
    (setq nvpm2 vpm2)
    (setq w "w")
    (while w
      (command "line" nvpm1 nvpm2 "")
      (setq countdownV (- countdownV 1))
      (if (= countdownV 0) ; when it is right on top of major grid it skip two step forward
		(progn
		  (setq countdownV count)
		  (setq nvpm1 (list (+ (car nvpm1) (* 2 mngdspc)) (cadr p1)))
		  (setq nvpm2 (list (+ (car nvpm2) (* 2 mngdspc)) (cadr p2)))
		)
		(progn (setq nvpm1 (list (+ (car nvpm1) mngdspc) (cadr p1)))
			   (setq nvpm2 (list (+ (car nvpm2) mngdspc) (cadr p2)))
		)
      )
      (if (> (car nvpm1) (car p2))
		(setq w nil)
      )
     )
  )					; END of DRAW_MINOR_GRID_H ()

  (defun DRAW_MINOR_GRID_V ()
    (setvar "CECOLOR" (itoa minorGridColor))
    (setq count mngdVno )
    (setq mngdspc (/ spcV (+ mngdVno 1)))	;convert from number of minor grid to minorgrid spacing
    (setq mngdspcV mngdspc)
    (setq hpm1 (list (car p1) (+ mngdspc y1)))
    (setq hpm2 (list (car p2) (+ mngdspc y1)))
    (setq countdownH 0)
    (setq k2 "k")
    (while k2				;to be sure to draw first minor grid after boundary
      (if (> (- y1 mngdspcV) (cadr p1))
		(progn
		  (setq countdownH (+ 1 countdownH))
		  (setq hpm1 (list (car p1) (- y1 mngdspcV)))
		  (setq hpm2 (list (car p2) (- y1 mngdspcV)))
		  (setq mngdspcV (+ mngdspcV mngdspc))
		)
		(setq k2 nil)
      )
    )
					;if there is no minor grid before first major grid, countdown_ 0 cannot remind to ommit
					;drawing minor grid over major one
					;therefore following syntax is added.
    (if	(= countdownH 0)
      (setq countdownH count)
    )
					;draw minor grids 			
    (setq nhpm1 hpm1)
    (setq nhpm2 hpm2)
    (setq w "w")
    (while w
      (command "line" nhpm1 nhpm2 "")
      (setq countdownH (- countdownH 1))
      (if (= countdownH 0)
		(progn
		  (setq countdownH count)
		  (setq nhpm1 (list (car p1) (+ (cadr nhpm1) (* 2 mngdspc))))
		  (setq nhpm2 (list (car p2) (+ (cadr nhpm2) (* 2 mngdspc))))
		)
		(progn (setq nhpm1 (list (car p1) (+ (cadr nhpm1) mngdspc)))
			   (setq nhpm2 (list (car p2) (+ (cadr nhpm2) mngdspc)))
		)
      )
      (if (> (cadr nhpm1) (cadr p2))
		(setq w nil)
      )
    )   
				
  ); END of DRAW_MINOR_GRID_V
;////////////////////////////////////; end of draw minor grid;/////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Draw Major Grid;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun DRAW_MAJOR_GRID ()
    (setvar "CMDECHO" 0)
    (if	(= gridLayer "1")
      (MAKE_GRID_LAYER)
    )
    (command "rectang" p1 p2)
    (GET_FIRST_POINTS)
    (setvar "OSMODE" 0)
    (setvar "CECOLOR" (itoa majorGridColor))
    (setq nvp1 vp1)
    (setq nvp2 vp2)
    (setq nhp1 hp1)
    (setq nhp2 hp2)
    (setq w "w")
    (while w
      (command "line" nvp1 nvp2 "")	; draw VERTICAL line i.e Y is cosntant 

      (setq index1 (+ 1 index1))
      (if (> (* index1 1 spcH) (car p2)) ;(> (* (- index1 1) spcH) (car p2))
	(setq w nil)
      )
      (setq nvp1 (list (* index1 spcH) (cadr p1)))
      (setq nvp2 (list (* index1 spcH) (cadr p2)))
    )
    (setq w "w")
    (while w
      (command "line" nhp1 nhp2 "")	; draw HORIZONTAL line

      (setq index2 (+ 1 index2))
      (if (> (* index2 spcV) (cadr p2)); (> (* (- index2 1) spcV) (cadr p2))
	(setq w nil)
      )
      (setq nhp1 (list (car p1) (* index2 spcV)))
      (setq nhp2 (list (car p2) (* index2 spcV)))
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun ADD_GRID_LABEL ()
    (setvar "CMDECHO" 0)
	(setvar "ANGBASE" 0)
	(setvar "ANGDIR" 0)
    (if	(= txtout "1")
      (progn (setq txtj1 "MR")
	     (setq txtj2 "ML")
	     (setq txtIndent (* txtIndent -1))
      )
      (progn (setq txtj1 "BL")
	     (setq txtj2 "BR")
      )
    )
   
    (setvar "OSMODE" 0)
    (setvar "CECOLOR" (itoa majorGridTextColor))
    (setq nvp1 vp1)
    (setq nvp2 vp2)
    (setq nhp1 hp1)
    (setq nhp2 hp2)
    
    (defun Add_Label_To_Four_Sides	()
      (setq w "w")
      (while w
		(command "text"			; lable on TOP
			 "j"
			 txtj1
			 (list (car nvp1) (+ (cadr nvp1) txtIndent))
			 txtSize
			 "90"
			 (strcat prefixE (rtos (* (car nvp1) scaleH) 2 luprec) suffixE)
		)							


		(command "text"			; label Below
			 "j"
			 txtj1
			 (list (car nvp2) (- (cadr nvp2) txtIndent))
			 txtSize
			 "270"
			 (strcat prefixE (rtos (* (car nvp2) scaleH) 2 luprec) suffixE)
		)
		(setq nvp1 (list (* lbindex1 spcH) (cadr p1)))
		(setq nvp2 (list (* lbindex1 spcH) (cadr p2)))
		(setq lbindex1 (+ 1 lbindex1))
		(if (> (* (- lbindex1 1) spcH) (car p2))
		  (setq w nil)
		)
      )
      (setq w "w")
      (while w
		(command "text"			; label at Right 
			 "j"
			 txtj1
			 (list (+ (car nhp1) txtIndent) (cadr nhp1))
			 txtSize
			 "0"
			 (strcat prefixN (rtos (* (cadr nhp1) scaleV)2 luprec) suffixN)
		)

		(command "text"			; label at Left
			 "j"
			 txtj2
			 (list (- (car nhp2) txtIndent) (cadr nhp2))
			 txtSize
			 "0"
			 (strcat prefixN (rtos (* (cadr nhp2) scaleV)2 luprec) suffixN)
		)
		(setq nhp1 (list (car p1) (* lbindex2 spcV)))
		(setq nhp2 (list (car p2) (* lbindex2 spcV)))
		(setq lbindex2 (+ 1 lbindex2))
		(if (> (* (- lbindex2 1) spcV) (cadr p2))
		  (setq w nil)
		)
      )
    )

   (defun Add_Label_To_BelowLeft ()
      (setq w "w")
      (while w
		(command "text"			; lable Below
			 "j"
			 txtj1
			 (list (car nvp1) (+ (cadr nvp1) txtIndent))
			 txtSize
			 "90"
			 (strcat prefixE (rtos (* (car nvp1) scaleH)2 luprec) suffixE)
		)
		(setq nvp1 (list (* lbindex1 spcH) (cadr p1)))
		(setq lbindex1 (+ 1 lbindex1))
		(if (> (* (- lbindex1 1) spcH) (car p2))
		  (setq w nil)
		)
      )

      (setq w "w")
      (while w
		(command "text"			; label at Left 
			 "j"
			 txtj1
			 (list (+ (car nhp1) txtIndent) (cadr nhp1))
			 txtSize
			 "0"
			 (strcat prefixN (rtos (* (cadr nhp1) scaleV)2 luprec) suffixN)
		)
		(setq nhp1 (list (car p1) (* lbindex2 spcV)))
		(setq lbindex2 (+ 1 lbindex2))
		(if (> (* (- lbindex2 1) spcV) (cadr p2))
		  (setq w nil)
		)
      )
    )
    (if	(= BelowLeft "1")
      (Add_Label_To_BelowLeft)
      (Add_Label_To_Four_Sides)
    )
    
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;Main command
  (setq	olderr	*error*
	*error*	gmerr
	gmerr	nil
  )
  (setq oldCmdecho (getvar "cmdecho"))
  (setq oldCecolor (getvar "cecolor"))
  (setvar "cmdecho" 0)
  (setq oldOsmode (getvar "osmode"))

  
  (alert
    "\n Mark Lower Left corner and
          \n Upper Right Corner"
  )
  (GET_GRID_FRAME)
  (if (= -1 (setq dcl_id (load_dialog "ddgrid5-3.dcl")))
 	(progn
 	;; If there's a problem - display a message and set the
 	;; dialogLoaded flag to nil
 		(princ "\nCannot load ddgrid5-2.dcl")
 		(setq dialogLoaded nil)
 	) ;_ end of progn
  ) ;_ end of if

  (DDGRID_MAIN)
  
  (DRAW_MAJOR_GRID)

  (if (= annogrd "1")
    (ADD_GRID_LABEL)
  )
  (if (and (= minorgd "1") (>= mngdHno 1))
					;to avoid zero number of minor grid
    (DRAW_MINOR_GRID_H)
  )
  (if (and (= minorgd "1") (>= mngdVno 1))
					;to avoid zero number of minor grid
    (DRAW_MINOR_GRID_V)
  )
  (princ)
  
  (RESTORE_VAR_SETTINGS)
  
  (princ)
)

(princ "\nYou have loaded DDGRID5.3.lsp Github repository written by Kyaw Naing Win. Type DDGRID to draw grids.")
(princ)

(alert
  "\n 			Type DDGRID to use
   \n-----------------------------------------------------------------------------
   \n* Making grids and lable in AutoCAD.
   \n
   \n* Do not grant that it will be error free.
   \n-----------------------------------------------------------------------------
   \n Note ***
   \n Make sure to add the path to this lisp file in 
   \n Tool>option>support file search path.
   \n Otherwise the program   \n will not work.
   \n
   \n-----------------------------------------------------------------------------
   \n Written by Kyaw Naing Win
   \n email - kyawnaingwinknw@gmail.com")
