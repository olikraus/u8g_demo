#include <avr/io.h>
#include <util/delay.h>

#include "u8g.h"

static u8g_t u8g;

#define PIN_SCK		PN(1, 5)
#define PIN_MOSI	PN(1, 3)
#define PIN_A0		PN(1, 1)
#define PIN_SS		PN(1, 2)

int main(void)
{
	CLKPR = 0x80;
	CLKPR = 0x00;

	/* u8g_SetPinInput(PN(2,5)); */
	/* u8g_SetPinLevel(PN(2,5), 1); */
	/* u8g_SetPinOutput(PN(2,5)); */

	/* u8g_SetPinInput(PN(2,4)); */
	/* u8g_SetPinLevel(PN(2,4), 1); */
	/* u8g_SetPinOutput(PN(2,4)); */

	u8g_InitSPI(&u8g, &u8g_dev_ssd1322_nhd31oled_2x_bw_sw_spi, PIN_SCK, PIN_MOSI, PIN_SS, PIN_A0, U8G_PIN_NONE);

	u8g_FirstPage(&u8g);
	do
	{
		u8g_SetFont(&u8g, u8g_font_6x10);
		u8g_DrawStr(&u8g, 15, 15, "Hello, World!");
	} while (u8g_NextPage(&u8g));
}
