#!/usr/bin/env python3

import RPi.GPIO as GPIO    # Import Raspberry Pi GPIO library
import sys, tty, termios

from time import sleep     # Import the sleep function from the time module
GPIO.setwarnings(False)    # Ignore warning for now
GPIO.setmode(GPIO.BOARD)   # Use physical pin numbering
GPIO.setup(8, GPIO.OUT,
           initial=GPIO.LOW)   # Set pin 8 to be an output pin and set initial value to low (off)

fd = sys.stdin.fileno()
old_settings = termios.tcgetattr(fd)
led_on = False
done = False
try:
    tty.setraw(sys.stdin.fileno())
    while not done:
        ch = sys.stdin.read(1)
        if 'k' == ch:
            if led_on:
                GPIO.output(8, GPIO.LOW)
            else:
                GPIO.output(8, GPIO.HIGH)
            led_on = not led_on
        elif 'q' == ch:
            done = True
finally:
    termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)



