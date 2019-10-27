odrv0.axis0.requested_state = AXIS_STATE_FULL_CALIBRATION_SEQUENCE

from gpiozero import Button
from time import sleep
import serial

button = Button(2)
serScreen = serial.Serial('/dev/ttyACM1', 9600)

while True:
    if button.is_pressed:
        print("Pressed")
        serScreen.write(b'Candy')
        sleep(1)
    else:
#        print("Released")
        pass

    
