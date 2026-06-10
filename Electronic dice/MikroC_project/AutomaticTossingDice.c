//_________________________Electronic dice based on PIC12F675
//_________________________Author: Goirik Dhar
//_________________________Date: 2021-05-20
//_________________________mail me at : goirik.dhar@gmail.com   :)

//_________________________please letme know if you find any kind of mistake.
//_________________________improvement suggestions are welcome.

unsigned int ran;
 char i;
 char counter=0;
 unsigned char sl=10;     // modify this value to adj the idle time.
 
 void interrupt()
 {
  if(PIR1.F0)
  {
   counter++;   //inc after every 0.524 s
   PIR1.F0=0;
  }
  if(INTCON.F0)
  {
   INTCON.F0=0;
  }
 }
 
void main() 
{
  CMCON=0x07;      // initializing io ports
  ANSEL=0x00;      // initializing io ports

 TRISIO=0X08;      // initializing io ports
 GPIO|=0XFF;
 delay_ms(500);
 GPIO=0X00;        // initializing io ports
 PIE1|=0x01;       // enabling interrupts
 INTCON|=0xC0;     // enabling interrupts

  while(1)
  {
  
    for(i=6;i>0;i--)             // animated pattern
    {
    GPIO=0B00000101;
    delay_ms(60);
    GPIO=0B00000011;
    delay_ms(60);
    GPIO=0B00010001;
    delay_ms(60);
    GPIO=0B00100001;
    delay_ms(60);
     }
     GPIO=0X00;
     delay_ms(100);
  
  
  
  
    do
    {
     ran=rand();                 // generating random number using C_Stdlib
     ran=ran%10;                 // getting the unit's digit for quicker result
    }while(ran>6||ran<1);
    
    if(ran==1)
    {
     GPIO=0b00000001;            // turning on the ports for the LED disp.
    }
    if(ran==2)
    {
     GPIO=0b00000100;
    }
    if(ran==3)
    {
     GPIO=0b00000101;
    }
    if(ran==4)
    {
     GPIO=0b00010100;
    }
    if(ran==5)
    {
     GPIO=0b00010101;
    }
    if(ran==6)
    {
     GPIO=0b00110100;
    }

      delay_ms(100);

      TMR1H=0;            // clearing timer value to 0
      TMR1L=0;            // clearing timer value to 0
      T1CON=0x35;         // starting TMR1   and init
      while(~GPIO.F3)
      {
        if(counter>=sl)
        {
         counter=0;
         GPIO&=~0x37;    // turning off GPIO for power saving
         IOC=0x08;       // interrupt on pin change enable
         INTCON.F3=1;
         asm sleep;       // entering into sleep mode for saving power of battery
         IOC=0x00;        // interrupt on pin change disable
        }
      }
      counter=0;          // clearing counter if button is pressed
      T1CON.F0=0;         // turning timer off
      INTCON.F3=0;        // disable port change interrupt

  }
}