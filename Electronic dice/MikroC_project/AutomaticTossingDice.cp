#line 1 "C:/Users/goiri/Documents/MikroC projects/AutomaticTossingDice.c"








unsigned int ran;
 char i;
 char counter=0;
 unsigned char sl=10;

 void interrupt()
 {
 if(PIR1.F0)
 {
 counter++;
 PIR1.F0=0;
 }
 if(INTCON.F0)
 {
 INTCON.F0=0;
 }
 }

void main()
{
 CMCON=0x07;
 ANSEL=0x00;

 TRISIO=0X08;
 GPIO|=0XFF;
 delay_ms(500);
 GPIO=0X00;
 PIE1|=0x01;
 INTCON|=0xC0;

 while(1)
 {

 for(i=6;i>0;i--)
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
 ran=rand();
 ran=ran%10;
 }while(ran>6||ran<1);

 if(ran==1)
 {
 GPIO=0b00000001;
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

 TMR1H=0;
 TMR1L=0;
 T1CON=0x35;
 while(~GPIO.F3)
 {
 if(counter>=sl)
 {
 counter=0;
 GPIO&=~0x37;
 IOC=0x08;
 INTCON.F3=1;
 asm sleep;
 IOC=0x00;
 }
 }
 counter=0;
 T1CON.F0=0;
 INTCON.F3=0;

 }
}
