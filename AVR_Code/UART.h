#ifndef UART_HEADER
#define UART_HEADER

#define F_CPU	16000000UL

void USART_init(long Baud_Rate);
void uart_transmit(unsigned char data);
void put_string(char* ptr);

void put_int(int num);
void USART_enable_intterupts(int RX_en, int TX_en);

#endif
