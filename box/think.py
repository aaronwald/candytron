import time

oready = False
while not oready:
    try:
        odrv0
    except: NameError:
        time.sleep(1)
    else:
        oready = True

odrv0.axis0.requested_state = AXIS_STATE_FULL_CALIBRATION_SEQUENCE

time.sleep(10)

odrv0.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
odrv0.axis0.controller.config.control_mode = CTRL_MODE_VELOCITY_CONTROL



from gpiozero import Button
from time import sleep
import serial

button = Button(2)
serScreen = serial.Serial('/dev/ttyACM1', 9600)

while True:
    if button.is_pressed:
        print("Pressed")
        serScreen.write(b'Candy')
        odrv0.axis0.controller.vel_setpoint= 5000; time.sleep(2) ; odrv0.axis0.controller.vel_setpoint= 0
    else:
        pass

    
