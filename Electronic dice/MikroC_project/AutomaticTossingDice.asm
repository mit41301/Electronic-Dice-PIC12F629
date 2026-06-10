
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;AutomaticTossingDice.c,14 :: 		void interrupt()
;AutomaticTossingDice.c,16 :: 		if(PIR1.F0)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;AutomaticTossingDice.c,18 :: 		counter++;   //inc after every 0.524 s
	INCF       _counter+0, 1
;AutomaticTossingDice.c,19 :: 		PIR1.F0=0;
	BCF        PIR1+0, 0
;AutomaticTossingDice.c,20 :: 		}
L_interrupt0:
;AutomaticTossingDice.c,21 :: 		if(INTCON.F0)
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt1
;AutomaticTossingDice.c,23 :: 		INTCON.F0=0;
	BCF        INTCON+0, 0
;AutomaticTossingDice.c,24 :: 		}
L_interrupt1:
;AutomaticTossingDice.c,25 :: 		}
L_end_interrupt:
L__interrupt30:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;AutomaticTossingDice.c,27 :: 		void main()
;AutomaticTossingDice.c,29 :: 		CMCON=0x07;      // initializing io ports
	MOVLW      7
	MOVWF      CMCON+0
;AutomaticTossingDice.c,30 :: 		ANSEL=0x00;      // initializing io ports
	CLRF       ANSEL+0
;AutomaticTossingDice.c,32 :: 		TRISIO=0X08;      // initializing io ports
	MOVLW      8
	MOVWF      TRISIO+0
;AutomaticTossingDice.c,33 :: 		GPIO|=0XFF;
	MOVLW      255
	IORWF      GPIO+0, 1
;AutomaticTossingDice.c,34 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;AutomaticTossingDice.c,35 :: 		GPIO=0X00;        // initializing io ports
	CLRF       GPIO+0
;AutomaticTossingDice.c,36 :: 		PIE1|=0x01;       // enabling interrupts
	BSF        PIE1+0, 0
;AutomaticTossingDice.c,37 :: 		INTCON|=0xC0;     // enabling interrupts
	MOVLW      192
	IORWF      INTCON+0, 1
;AutomaticTossingDice.c,39 :: 		while(1)
L_main3:
;AutomaticTossingDice.c,42 :: 		for(i=6;i>0;i--)             // animated pattern
	MOVLW      6
	MOVWF      _i+0
L_main5:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;AutomaticTossingDice.c,44 :: 		GPIO=0B00000101;
	MOVLW      5
	MOVWF      GPIO+0
;AutomaticTossingDice.c,45 :: 		delay_ms(60);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
;AutomaticTossingDice.c,46 :: 		GPIO=0B00000011;
	MOVLW      3
	MOVWF      GPIO+0
;AutomaticTossingDice.c,47 :: 		delay_ms(60);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
;AutomaticTossingDice.c,48 :: 		GPIO=0B00010001;
	MOVLW      17
	MOVWF      GPIO+0
;AutomaticTossingDice.c,49 :: 		delay_ms(60);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
;AutomaticTossingDice.c,50 :: 		GPIO=0B00100001;
	MOVLW      33
	MOVWF      GPIO+0
;AutomaticTossingDice.c,51 :: 		delay_ms(60);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
;AutomaticTossingDice.c,42 :: 		for(i=6;i>0;i--)             // animated pattern
	DECF       _i+0, 1
;AutomaticTossingDice.c,52 :: 		}
	GOTO       L_main5
L_main6:
;AutomaticTossingDice.c,53 :: 		GPIO=0X00;
	CLRF       GPIO+0
;AutomaticTossingDice.c,54 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
	NOP
;AutomaticTossingDice.c,59 :: 		do
L_main13:
;AutomaticTossingDice.c,61 :: 		ran=rand();                 // generating random number using C_Stdlib
	CALL       _rand+0
	MOVF       R0+0, 0
	MOVWF      _ran+0
	MOVF       R0+1, 0
	MOVWF      _ran+1
;AutomaticTossingDice.c,62 :: 		ran=ran%10;                 // getting the unit's digit for quicker result
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ran+0
	MOVF       R0+1, 0
	MOVWF      _ran+1
;AutomaticTossingDice.c,63 :: 		}while(ran>6||ran<1);
	MOVF       R0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       R0+0, 0
	SUBLW      6
L__main32:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
	MOVLW      0
	SUBWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      1
	SUBWF      _ran+0, 0
L__main33:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
L__main28:
;AutomaticTossingDice.c,65 :: 		if(ran==1)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      1
	XORWF      _ran+0, 0
L__main34:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;AutomaticTossingDice.c,67 :: 		GPIO=0b00000001;            // turning on the ports for the LED disp.
	MOVLW      1
	MOVWF      GPIO+0
;AutomaticTossingDice.c,68 :: 		}
L_main18:
;AutomaticTossingDice.c,69 :: 		if(ran==2)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      2
	XORWF      _ran+0, 0
L__main35:
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;AutomaticTossingDice.c,71 :: 		GPIO=0b00000100;
	MOVLW      4
	MOVWF      GPIO+0
;AutomaticTossingDice.c,72 :: 		}
L_main19:
;AutomaticTossingDice.c,73 :: 		if(ran==3)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVLW      3
	XORWF      _ran+0, 0
L__main36:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;AutomaticTossingDice.c,75 :: 		GPIO=0b00000101;
	MOVLW      5
	MOVWF      GPIO+0
;AutomaticTossingDice.c,76 :: 		}
L_main20:
;AutomaticTossingDice.c,77 :: 		if(ran==4)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVLW      4
	XORWF      _ran+0, 0
L__main37:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;AutomaticTossingDice.c,79 :: 		GPIO=0b00010100;
	MOVLW      20
	MOVWF      GPIO+0
;AutomaticTossingDice.c,80 :: 		}
L_main21:
;AutomaticTossingDice.c,81 :: 		if(ran==5)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main38
	MOVLW      5
	XORWF      _ran+0, 0
L__main38:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;AutomaticTossingDice.c,83 :: 		GPIO=0b00010101;
	MOVLW      21
	MOVWF      GPIO+0
;AutomaticTossingDice.c,84 :: 		}
L_main22:
;AutomaticTossingDice.c,85 :: 		if(ran==6)
	MOVLW      0
	XORWF      _ran+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVLW      6
	XORWF      _ran+0, 0
L__main39:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;AutomaticTossingDice.c,87 :: 		GPIO=0b00110100;
	MOVLW      52
	MOVWF      GPIO+0
;AutomaticTossingDice.c,88 :: 		}
L_main23:
;AutomaticTossingDice.c,90 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	NOP
	NOP
;AutomaticTossingDice.c,92 :: 		TMR1H=0;            // clearing timer value to 0
	CLRF       TMR1H+0
;AutomaticTossingDice.c,93 :: 		TMR1L=0;            // clearing timer value to 0
	CLRF       TMR1L+0
;AutomaticTossingDice.c,94 :: 		T1CON=0x35;         // starting TMR1   and init
	MOVLW      53
	MOVWF      T1CON+0
;AutomaticTossingDice.c,95 :: 		while(~GPIO.F3)
L_main25:
	BTFSC      GPIO+0, 3
	GOTO       L__main40
	BSF        3, 0
	GOTO       L__main41
L__main40:
	BCF        3, 0
L__main41:
	BTFSS      3, 0
	GOTO       L_main26
;AutomaticTossingDice.c,97 :: 		if(counter>=sl)
	MOVF       _sl+0, 0
	SUBWF      _counter+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main27
;AutomaticTossingDice.c,99 :: 		counter=0;
	CLRF       _counter+0
;AutomaticTossingDice.c,100 :: 		GPIO&=~0x37;    // turning off GPIO for power saving
	MOVLW      200
	ANDWF      GPIO+0, 1
;AutomaticTossingDice.c,101 :: 		IOC=0x08;       // interrupt on pin change enable
	MOVLW      8
	MOVWF      IOC+0
;AutomaticTossingDice.c,102 :: 		INTCON.F3=1;
	BSF        INTCON+0, 3
;AutomaticTossingDice.c,103 :: 		asm sleep;       // entering into sleep mode for saving power of battery
	SLEEP
;AutomaticTossingDice.c,104 :: 		IOC=0x00;        // interrupt on pin change disable
	CLRF       IOC+0
;AutomaticTossingDice.c,105 :: 		}
L_main27:
;AutomaticTossingDice.c,106 :: 		}
	GOTO       L_main25
L_main26:
;AutomaticTossingDice.c,107 :: 		counter=0;          // clearing counter if button is pressed
	CLRF       _counter+0
;AutomaticTossingDice.c,108 :: 		T1CON.F0=0;         // turning timer off
	BCF        T1CON+0, 0
;AutomaticTossingDice.c,109 :: 		INTCON.F3=0;        // disable port change interrupt
	BCF        INTCON+0, 3
;AutomaticTossingDice.c,111 :: 		}
	GOTO       L_main3
;AutomaticTossingDice.c,112 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
