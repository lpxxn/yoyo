from lib import storage
storage.init()
ssid_str = "SSID"
pwd_str = "PASSWORD"
ssid = storage.get(ssid_str)
print(ssid)

ssid = storage.get(ssid_str)
print(ssid)
pwd = storage.get(pwd_str)
print(pwd)