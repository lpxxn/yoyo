import bluetooth        #导入BLE功能模块
ble = bluetooth.BLE()   #创建BLE设备
ble.active(True)         #打开BLE
name = "中国蓝牙".encode() # 编码成utf-8格式
adv_mode = bytearray(b'\x02\x01\x06')  # 正常蓝牙模式, ad struct 1
adv_name = bytearray((len(name) + 1, 0x09)) + name # 0x09是蓝牙名称,ad struct 2
adv_data = adv_mode + adv_name
ble.gap_advertise(100, adv_data = adv_data)
