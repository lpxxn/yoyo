from machine import Pin
import time
import network
 
p5=Pin(5,Pin.OUT)
 
w=network.WLAN(network.STA_IF)
w.active(True)
#w.connect("mabc","asdf12345")
connected = False 
while connected is False:
    if w.isconnected():
        print('connected')
        p5.off()
        connected = True
    else:
        print('disconnected')
        p5.on()
    time.sleep(1)
print('exist wifi')