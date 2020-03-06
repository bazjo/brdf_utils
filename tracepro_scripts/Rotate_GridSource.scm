;--------------------------------------------------------------------------------------------------------------------
;                    Th Koeln Campus Deutz
;--------------------------------------------------------------------------------------------------------------------
;  Author:           Philipp Weber
;  Date:             05.12.2019
;  Version:          0.0
;  Comment:          Initial draft
;
;(file:new)
(define GridSourceMove
  (lambda ()
    ;
	; ######################## Begin User Interface #######################################
	;
	; Clear the current content in the Message/Macro output window
	(macro:clear-output)
	
	; Path and file determination
	(define path "C:/Studium/Aktuell/CSO/Projekt/Test/")	; Path can be revised by user, "Test/" is folder name
	(define file "_deg")
	
	; Name of probe
	(define probe "Probe")		; User can change "Probe" to his own name if needed 
	
	; Variables for rotation loop
	(define rotAngStart 0)		; starting Value
	(define rotAngInc -5)		; increment Value
	(define rotAngEnd -85)		; End Value
	
	; Variables for "dynamic" naming of the individual files (x degrees) 
	(define fileName )
	(define fileNameStr)
	
	; Display irradiance map, polar iso-candela plot and rectangular iso-candela plot for the current model
	(analysis:irradiance)		 				
    (analysis:candela-polar-iso) 			
    (analysis:candela-rectangular-distribution)  
	
	; Include grid source in the raytrace
	(raytrace:set-grid-source-flag #t)			

   ; Loop from 0 to 85
	(do ( (angVal rotAngStart (+ angVal rotAngInc ) ) )
		( (< angVal rotAngEnd) angVal)
		; Set file name to current angle, due to negative angles multiply with "-1" 
		(set! fileName (* -1 angVal))					
		; Convert fileName (integer) to string -> fileNameStr
		(set! fileNameStr (number->string fileName)) 	

		; Trace rays
		(raytrace:all-sources)
		; Select the surface of the entity called "probe" need surface 2 for irradiance
		(edit:select (tools:face-in-body 1 (entity:get-by-name probe)))
		
		; Display Table
		(analysis:irradiance)
		; Save the output to a file
		(analysis:irradiance-save (string-append path  fileNameStr file ".txt"))
		; Save the output to a bitmap file
		(analysis:irradiance-save (string-append path  fileNameStr file ".bmp"))
		
		; Check if angVal is > rotAngEnd, cause we first trace rays and then rotate source
		(if (> angVal rotAngEnd)
			; Rotate source "Grid Source few rays" 
			; Numbers: xcenter real | ycenter real | zcenter real | xdir real | ydir real | zdir real | angle real | copy boolean | Origin of Object WCS boolean
			(edit:rotate-grid-source "Grid Source few rays" 0 0 0 1 0 0 rotAngInc #f #f)	
		)
	)
	(print (string->symbol  (string-append "macro executed." ) )) 

)
)
; execute macro
(GridSourceMove)
