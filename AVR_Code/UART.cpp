#include "UART.h"
#include <avr/io.h>
#include <math.h>

void USART_init(long Baud_Rate){			//1 stop bit no parity bit
	int Baud_Prescaller = (((F_CPU/(Baud_Rate * 16UL))) - 1);
	UBRR0H = (uint8_t)(Baud_Prescaller >> 8);
	UBRR0L = (uint8_t)(Baud_Prescaller);
	UCSR0B |= (1 << RXEN0) | (1 << TXEN0);		//enable receive and transmit pins
	UCSR0C |= (1 << UCSZ01) | (1 << UCSZ01);	//8 bit character data
}

void uart_transmit(unsigned char data){
	while( !(UCSR0A & (1 << UDRE0)) );	//wait for empty transmit buffer
	UDR0 = data;						//put data into the buffer
}

void put_string(char* ptr){
	while(*ptr != 0x00){
		uart_transmit(*ptr);
		ptr++;
	}
}

void put_int(int num){
	int num_digits = 1;
	if(num > 0){
		num_digits = (int) log10(num) + 1;
		}else if(num < 0){
		num *= -1;
		uart_transmit('-');
	}
	
	char str_num[num_digits];
	for(int i=0; i < num_digits; i++){
		str_num[num_digits - (i + 1)] = (char)( (num % 10) + 48 );
		num /= 10;
	}
	
	put_string(str_num);
}

void USART_enable_intterupts(int RX_en, int TX_en){
	if(RX_en){
		UCSR0B |= (1<<RXCIE0);
	}else{
		UCSR0B &= ~(1<<RXCIE0);
	}
	
	if(TX_en){
		UCSR0B |= (1<<TXCIE0);
		}else{
		UCSR0B &= ~(1<<TXCIE0);
	}
}