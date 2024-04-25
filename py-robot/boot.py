# boot.py -- run on boot-up
from lib import storage
from lib import wifi_op
from lib import wol_op

import urequests
import json
import utime

ssid_str = "SSID"
pwd_str = "PASSWORD"
mac_addr_str = "MAC"
ssid = storage.get(ssid_str)
print(ssid)
pwd = storage.get(pwd_str)
print(pwd)
mac_addr = storage.get(mac_addr_str)
print(mac_addr)
while True:
    wifi = wifi_op.WIFI
    wifi.SSID = ssid
    wifi.PASSWORD = pwd
    if wifi.WLAN == None:
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
    utime.sleep(5)

