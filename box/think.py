#!/usr/bin/python3

from __future__ import print_function
from gpiozero import Button
import serial

import random
import odrive
from odrive.enums import *
import time

random.seed()
# setup button
button = Button(2)
serScreen = serial.Serial('/dev/ttyACM1', 9600)

# Find a connected ODrive (this will block until you connect one)
print("finding an odrive...")
my_drive = odrive.find_any()
my_drive.axis0.requested_state = AXIS_STATE_FULL_CALIBRATION_SEQUENCE

while my_drive.axis0.current_state != AXIS_STATE_IDLE:
    time.sleep(0.1)

my_drive.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
my_drive.axis0.controller.config.control_mode = CTRL_MODE_VELOCITY_CONTROL

# main
no_candy_count = 0
candy_count = 0
rockin = random.randrange(10,13,1)
while True:
    if button.is_pressed:
        print("Pressed")
        if candy_count % rockin:
            serScreen.write(b'`Smarties Smarties Smarties...')
            serScreen.flush()
        else:
            serScreen.write(b'Candy')
            serScreen.flush()
            
        my_drive.axis0.controller.vel_setpoint = 4000
        time.sleep(2)
        my_drive.axis0.controller.vel_setpoint = 0
        no_candy_count = 0
        candy_count += 1
    else:
        time.sleep(1)
        no_candy_count += 1

        if not no_candy_count % 60:
            serScreen.write(b'`Where is everybody?')
            
    

    
