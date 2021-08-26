# 8051
It's a little project using assembly for 8051 microcontroller.
The fuctions is as follows:

We receive a byte through serial communication interface using interruptions and then, answer according to the input.

We are going to receive a number from 0 to 7, according to the number we are going to turn one of the 8 leds and answer back
LED_X (where X is 0 to 7). If it's a wrong number we answer So 0 to 7. In order to the corresponding led turn up, the correspondig
switch must be turned on, if it's not we answer SW off.
