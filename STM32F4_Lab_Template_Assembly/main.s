;******************** (C) Yifeng ZHU *******;****************************************
; @file    main.s
; @author  Yifeng Zhu
; @version V1.0.0
; @date    May-17-2015
; @note    
; @brief   Assembly code for STM32F4 Discovery Kit
; @note
;          This code is for the book "Embedded Systems with ARM Cortex-M3 
;          Microcontrollers in Assembly Language and C, Yifeng Zhu, 
;          ISBN-10: 0982692625.
; @attension
;          This code is provided for education purpose. The author shall not be 
;          held liable for any direct, indirect or consequential damages, for any 
;          reason whatever. More information can be found from book website: 
;          http://www.eece.maine.edu/~zhu/book
;************************************************************************************

				
;************************************************************************************
; Discovery kit for STM32F407/417 lines
; LEDs:
;  LD3 ORANGE <---> PD.13 
;  LD4 GREEN  <---> PD.12
;  LD5 RED    <---> PD.14
;  LD6 BLUE   <---> PD.15
;  LD7 GREEN LED indicates when VBUS is present on CN5 (pin PA.9)
;  LD8 RED LED indicates an overcurrent from VBUS of CN5 (pin PD.5)
; 
; Pushbutton
;  B1 <---> PA.0
;  B2 <---> Reset
;************************************************************************************


;**********************************************************************************************************
;  Demo code of lighting up the Orange LED
;**********************************************************************************************************

	
				INCLUDE core_cm4_constants.s		; Load Constant Definitions
				INCLUDE stm32f401xc_constants.s     ; 

				AREA    main, CODE, READONLY
				EXPORT	__main						; make __main visible to linker
				ENTRY			
				
__main			PROC
	
				; Enable Clock of GPIO Port D
				LDR r7, =RCC_BASE
				LDR r1, [r7, #RCC_AHB1ENR] 
				ORR r1, r1,  #RCC_AHB1ENR_GPIODEN	 
				STR r1, [r7, #RCC_AHB1ENR] 			
				
				
				LDR r7, =GPIOD_BASE					; Load GPIO Port D base address
				
				; Set Pin 13 I/O direction as Digital Output
				LDR r1, [r7, #GPIO_MODER]           ; r1 = GPIOD->MODER
				BIC r1, r1, #(3 << 13*2)			; Clear mode
				ORR r1, r1, #(1 << 13*2)		    ; Input(00, reset), Output(01), Alternate Func(10), Analog(11)
				STR r1, [r7, #GPIO_MODER] 			; 		

				; Set Pin 13 the push-pull mode for the output type
				LDR r1, [r7, #GPIO_OTYPER]          ; OTYPER  (32-bit)
				BIC r1, r1, #(1<<13)                ; Output Push-Pull(0, reset), Output Open-Drain(1)
				STR r1, [r7, #GPIO_OTYPER]       
				
				; Set I/O output speed value as high speed
				LDR r1, [r7, #GPIO_OSPEEDR]
				ORR r1, r1, #(1<<13*2)		        ; Low speed (00), Medium speed (01), Fast speed(01), High speed (11)
				STR r1, [r7, #GPIO_OSPEEDR]
		
			    ; Set I/O as no pull-up pull-down  
				LDR r1, [r7, #GPIO_PUPDR]			; PUPDR (32-bit): configure I/O pull-up or pull-down
				BIC r1, r1, #(3<<13*2)              ; No PUPD(00, reset), Pull up(01), Pull down (10), Reserved (11)
				STR r1, [r7, #GPIO_PUPDR]
				
				; Output 1
				LDR r1, [r7, #GPIO_ODR]
				ORR r1, r1,  #GPIO_ODR_ODR_13
				STR r1, [r7, #GPIO_ODR]
				

stop 			B 		stop     					; dead loop & program hangs here

				ENDP
					
				ALIGN			

				AREA    myData, DATA, READWRITE
				ALIGN
array			DCD   1, 2, 3, 4
				END
