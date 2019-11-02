/*
 * ECE341_Accelerated_Project_MATLAB_Sensors.cpp
 *
 * Created: 9/25/2017 4:59:34 PM
 * Author : Mitchell
 */ 
#define F_CPU	16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "UART.h"
#include "adc_atmega328p.h"

unsigned int send_measurment = 0;
unsigned int timer0_counter = 0;
unsigned int data_points_per_sec = 0;
unsigned int time_interval = 0;

void timer0_init(){
	TCCR0B |= (1 << CS01) | (1 << CS00);	//set up timer 0 with clk/64 prescaling
	TIMSK0  |= (1 << OCIE0A);				//Timer 0 Output Compare Match A Interrupt Enable
	OCR0A = 0xF9;							//compare value to 249 (1 millisecond)
}

int main(void) {
	USART_init(19200);
	USART_enable_intterupts(1, 0);
	adc_init();
	timer0_init();
	sei();		// enable global interrupts
	
	// main loop
    while (1) {		
		if(send_measurment == 1 && data_points_per_sec != 0){
			adc_change_channel(1); // light sensor 
			put_int( adc_conversion() );
			put_string((char*)"\n");

			adc_change_channel(0); // thermistor
			put_int( adc_conversion() );
			put_string((char*)"\n");
			
			send_measurment = 0;
		}
		_delay_us(1);
    }
}

ISR(TIMER0_COMPA_vect){	//is called when timer0 match
	TCNT0 = 0;			//reset timer 0
	timer0_counter++;
	if(timer0_counter >= time_interval){
		timer0_counter = 0;
		send_measurment = 1;
	}
}

ISR(USART_RX_vect){
	data_points_per_sec = UDR0;
	time_interval = ceil(1000 / data_points_per_sec);
}