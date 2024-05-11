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
def req_test():
    res = urequests.get("http://192.168.10.40:9087/ping", timeout=3)
    print(res)
    print(res.content)
    jsonresults = json.loads(res.content)
    print(jsonresults)
    # utime.sleep(5)

req_test()

info = os.uname()

# We use our helper function to connect to AWS IoT Core.
# The callback function mqtt_subscribe is what will be called if we
# get a new message on topic_sub.
try:
    mqtt_client = mqtt.mqtt_connect()
except:
    print("Unable to connect to MQTT.")

while True:
    req_test()
    # Check for messages.
    try:
        mqtt_client.check_msg()
    except:
        print("Unable to check for messages.")

    # mesg = ujson.dumps({
    #     "state": {
    #         "reported": {
    #             "device": {
    #                  "client": mqtt.client_id,
    #                 "hardware": info[0],
    #                 "firmware": info[2]
    #             }
    #         }
    #     }
    # })

    # Using the message above, the device shadow is updated.
    # mqtt.mqtt_publish(client=mqtt_client, message=mesg)
    # try:
    #     mqtt.mqtt_publish(client=mqtt_client, message=mesg)
    # except:
    #     print("Unable to publish message.")

    # Wait for 10 seconds before checking for messages and publishing a new update.
    print("Sleep for 10 seconds")
    utime.sleep(10)
