import utime
from machine import Pin

pin2 = Pin(2, Pin.OUT)
while True:
    pin2.value(not pin2.value())
    utime.sleep(1)