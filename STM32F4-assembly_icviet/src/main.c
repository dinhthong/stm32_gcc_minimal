#include <stdint.h>

volatile const uint32_t constant = 0x33333333;
volatile uint32_t var_no_init;
volatile uint32_t var_init = 0xAABBCCDD;

uint32_t function(uint32_t var_in)
{
	volatile uint32_t stack_init = 0x11111111;
	volatile uint32_t stack_no_init;
	volatile static uint32_t stack_static = 0x22222222;
	stack_no_init = var_in + stack_init + stack_static++;
	return stack_no_init;
}
int main(void)
{
	var_no_init = function(0xFF);
	while(1)
	{

	}
	return 0;
}
