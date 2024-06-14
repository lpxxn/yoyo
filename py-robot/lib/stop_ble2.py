from machine import Timer
from time import sleep_ms
import ubluetooth

class BLE:
    def __init__(self):
        self.ble = ubluetooth.BLE()
        self.ble.active(True)
        self.timer = Timer(-1)

    def start_advertising(self):
        name = bytes('HELLOBLE', 'UTF-8')
        # 以指定的时间间隔（以微秒为单位）开始广播
        # 文档地址
        # https://docs.micropython.org/en/latest/library/bluetooth.html?highlight=irq#broadcaster-role-advertiser
        self.ble.gap_advertise(100, bytearray(b'\x02\x01\x02') + bytearray((len(name) + 1, 0x09)) + name)
        print("Advertising started")
        # Stop advertising after 30 seconds
        self.timer.init(period=30000, mode=Timer.ONE_SHOT, callback=self.stop_advertising)

    def stop_advertising(self, t):
        self.ble.gap_advertise(None)
        print("Advertising stopped")


if __name__ == "__main__":
    ble = BLE()
    ble.start_advertising()

    # Keep the script running to allow the timer to execute
    while True:
        sleep_ms(1000)
