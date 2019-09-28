#!/usr/bin/env odrivetool
import time

odrv0.axis0.requested_state = AXIS_STATE_FULL_CALIBRATION_SEQUENCE
odrv0.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
odrv0.axis0.controller.config.control_mode = CTRL_MODE_VELOCITY_CONTROL

for x  in range (0,10000):
    time.sleep(.001)
    odrv0.axis0.controller.vel_setpoint = x
    
