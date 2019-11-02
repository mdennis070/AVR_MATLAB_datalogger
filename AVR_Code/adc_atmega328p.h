#ifndef _ADC_ATMEGA328P_
#define _ADC_ATMEGA328P_

void adc_init();
int adc_conversion();
void adc_change_channel(int channel);

#endif