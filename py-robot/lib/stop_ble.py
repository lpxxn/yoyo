import time
from machine import Timer
from ubluetooth import BLE, UUID, FLAG_READ, ADV_TYPE_NONCONN_IND, ADV_INCLUDE_NAME

# Define advertisement data
adv_data = {
    ADV_TYPE_NONCONN_IND: [  # Non-connectable, non-scannable advertising
        (FLAG_READ, bytes([0x06])),  # General Discoverable
        (ADV_INCLUDE_NAME, b'MyDevice')  # Include device name in advertisement
    ]
}

# Initialize Bluetooth
ble = BLE()

# Define advertising interval (in milliseconds)
adv_interval = 1000  # 1 second

# Function to stop advertising
def stop_advertising(timer):
    ble.stop_advertising()
    timer.deinit()

# Start advertising
ble.gap_advertise(adv_interval, adv_data)

# Define timer to stop advertising after 30 seconds
stop_timer = Timer(-1)
stop_timer.init(period=30000, mode=Timer.ONE_SHOT, callback=lambda t: stop_advertising(stop_timer))

# Main loop
while True:
    # Do other tasks if needed
    time.sleep(1)
