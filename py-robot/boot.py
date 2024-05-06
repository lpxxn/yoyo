# boot.py -- run on boot-up
from lib import storage
from lib import wifi_op
from lib import wol_op
from lib import mqtt

import os
import urequests
import json
import utime
import ujson

ssid_str = "SSID"
pwd_str = "PASSWORD"
mac_addr_str = "MAC"
ssid = storage.get(ssid_str)
print(ssid)
pwd = storage.get(pwd_str)
print(pwd)
mac_addr = storage.get(mac_addr_str)
print(mac_addr)
wifi = wifi_op.WIFI
wifi.SSID = ssid
wifi.PASSWORD = pwd

while wifi.WLAN == None:
    print("No wifi found")
    wifi_op.connectWiFi()
    if wifi.WLAN.isconnected() == True:
        print("WLAN is connected")
        wol = wol_op.WOL(wifi.IP, mac_addr)
        wol.do()
    else:
        print("WLAN is not connected")

res = urequests.get("http://192.168.10.39:9087/ping", timeout=3)
print(res)
print(res.content)
jsonresults = json.loads(res.content)
print(jsonresults)
# utime.sleep(5)

info = os.uname()

# We use our helper function to connect to AWS IoT Core.
# The callback function mqtt_subscribe is what will be called if we
# get a new message on topic_sub.
try:
    mqtt = mqtt.mqtt_connect()
    mqtt.set_callback(mqtt.mqtt_subscribe)
    mqtt.subscribe(mqtt.topic_sub)
except:
    print("Unable to connect to MQTT.")

while True:
    # Check for messages.
    try:
        mqtt.check_msg()
    except:
        print("Unable to check for messages.")

    mesg = ujson.dumps({
        "state": {
            "reported": {
                "device": {
                    "client": mqtt.client_id,
                    "uptime": time.ticks_ms(),
                    "hardware": info[0],
                    "firmware": info[2]
                }
            }
        }
    })

    # Using the message above, the device shadow is updated.
    try:
        mqtt.mqtt_publish(client=mqtt, message=mesg)
    except:
        print("Unable to publish message.")

    # Wait for 10 seconds before checking for messages and publishing a new update.
    print("Sleep for 10 seconds")
    time.sleep(10)
