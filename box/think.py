#!/usr/bin/python3

from __future__ import print_function

import odrive
from odrive.enums import *
import time

# Find a connected ODrive (this will block until you connect one)
print("finding an odrive...")
my_drive = odrive.find_any()


my_drive.axis0.requested_state = AXIS_STATE_FULL_CALIBRATION_SEQUENCE

while my_drive.axis0.current_state != AXIS_STATE_IDLE:
    time.sleep(0.1)

my_drive.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
my_drive.axis0.controller.config.control_mode = CTRL_MODE_VELOCITY_CONTROL



from gpiozero import Button
import serial

button = Button(2)
serScreen = serial.Serial('/dev/ttyACM1', 9600)

while True:
    if button.is_pressed:
        print("Pressed")
        serScreen.write(b'Candy')
        my_drive.axis0.controller.vel_setpoint = 5000
	time.sleep(2)
        my_drive.axis0.controller.vel_setpoint = 0
    else:
        pass

    
