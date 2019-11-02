/*
 * ADClib.cpp
 *
 * Created: 5/20/2017 10:24:54 PM
 * Author : Mitchell
 */ 
#include "adc_atmega328p.h"
#include <avr/io.h>

void adc_init() {
	ADMUX |= (1<<REFS0);		//Vcc as reference source
	ADCSRA |= (1<<ADEN);		//enable ADC
	ADCSRA |= ( (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0) ); //clk prescaler 128
	ADCSRA |= (1<<ADSC);		//do a conversion
}

int adc_conversion() {
	ADCSRA |= (1<<ADSC);				//do ADC conversion
	while( ADCSRA & (1<<ADSC) ) ;		//wait for conversion to finish
	return ADCL | (ADCH<<8);;
}

void adc_change_channel(int channel) {
	ADMUX &= 0xF0;
	ADMUX |= channel;
}