from machine import Timer
from time import sleep_ms
import ubluetooth

class BLE:
    def __init__(self):
        self.ble = ubluetooth.BLE()
        self.ble.active(True)
        self.timer = Timer(-1)

    def start_advertising(self):
        self.ble.gap_advertise(100)
        print("Advertising started")
        # Stop advertising after 30 seconds
        self.timer.init(period=30000, mode=Timer.ONE_SHOT, callback=self.stop_advertising)

    def stop_advertising(self, t):
        self.ble.gap_advertise(None)
        print("Advertising stopped")

ble = BLE()
ble.start_advertising()

# Keep the script running to allow the timer to execute
while True:
    sleep_ms(1000)
