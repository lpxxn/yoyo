import network

class WIFI:
    WLAN = None
    IP = None
    SSID = b"[SSID]"
    PASSWORD = b"[PASSWORD]"

def connectWiFi():
    WIFI.WLAN = None
    WIFI.WLAN = network.WLAN(network.STA_IF)
    try:
        if not WIFI.WLAN.isconnected():
            WIFI.WLAN.active(True)
            WIFI.WLAN.connect(WIFI.SSID, WIFI.PASSWORD)
        if WIFI.WLAN.isconnected():
            print('network config:', WIFI.WLAN.ifconfig())
            WIFI.IP = WIFI.WLAN.ifconfig()[0]
    except:
        print('WIFI.WLAN network except')
        WIFI.WLAN.IP = None
    finally:
        print('WIFI.WLAN connectWiFi finish')