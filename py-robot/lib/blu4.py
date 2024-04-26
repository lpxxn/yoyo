# 引入依赖
import ubluetooth
# 实例化蓝牙
class BLE():
    def __init__(self, name):
        # 蓝牙名称
        self.name = name
        # 创建蓝牙实例
        self.ble = ubluetooth.BLE()
        # 开启蓝牙
        self.ble.active(True)
        # 蓝牙事件回调
        # 参考文档
        # https://docs.micropython.org/en/latest/library/bluetooth.html?highlight=irq
        self.ble.irq(self.ble_irq)
        # 配置蓝牙UUID
        self.register()
        # 特征和描述符的默认最大大小为 20 个字节，修改允许为100个字节（蓝牙数据的发送和接收字节大小限制）
        self.ble.gatts_write(self.rx, bytes(100))
        # 蓝牙广播
        self.advertiser()
        print("已开启蓝牙广播")

    # 蓝牙连接成功后回调
    def connected(self):
        print("connected")
    # 蓝牙断开连接后回调
    def disconnected(self):
        print("disconnected")

    # 蓝牙事件回调函数
    def ble_irq(self, event, data):
        #蓝牙已连接
        if event == 1:
            print("蓝牙已连接")
            # 连接后的执行函数
            self.connected()
        #蓝牙已断开连接
        elif event == 2:
            print("蓝牙已断开连接")
            # 断开连接后的执行函数
            self.advertiser()
            self.disconnected()
        #蓝牙已发送数据
        elif event == 3 :
            print("蓝牙已接收到数据")
            # 读取二进制数据
            buffer = self.ble.gatts_read(self.rx)
            # 使用UTF-8格式把二进制数据转为字符串
            message = buffer.decode('UTF-8').strip()
            # 打印收到的字符数据
            print("message",message)
            # 对指定的数据做处理并蓝牙返回数据
            if message == 'test':
                print('test')
                ble.send('test')
            if message == 'str':
                print('str')
                ble.send('str')
    # 注册蓝牙UUID
    def register(self):
        # 自定义UUID
        # 蓝牙服务UUID service_uuid(后续蓝牙建议连接会用到)
        NUS_UUID = 'AE25A5C1-4601-143C-12BB-8BC45A18749C'
        # 蓝牙接收特征UUId receive_uuid
        RX_UUID = 'AE25A5C2-4601-143C-12BB-8BC45A18749C'
        # 蓝牙发送特征UUId transmit_uuid
        TX_UUID = 'AE25A5C3-4601-143C-12BB-8BC45A18749C'
        # UUID组合（一个包含UUID和特征列表的二元元组）
        BLE_NUS = ubluetooth.UUID(NUS_UUID)
        BLE_RX = (ubluetooth.UUID(RX_UUID), ubluetooth.FLAG_WRITE)
        BLE_TX = (ubluetooth.UUID(TX_UUID), ubluetooth.FLAG_NOTIFY)
        BLE_UART = (BLE_NUS, (BLE_TX, BLE_RX,))
        SERVICES = (BLE_UART, )
        # 使用指定的服务配置外围设备
        # 文档地址：
        # https://docs.micropython.org/en/latest/library/bluetooth.html?highlight=irq#peripheral-role
        ((self.tx, self.rx,), ) = self.ble.gatts_register_services(SERVICES)
    # 发送数据
    def send(self, data):
        # 向连接的客户端发送通知请求
        # 文档地址：
        # https://docs.micropython.org/en/latest/library/bluetooth.html?highlight=irq#gatt-client
        self.ble.gatts_notify(0, self.tx, data + '\n')
    # 蓝牙广播配置
    def advertiser(self):
        name = bytes(self.name, 'UTF-8')
        # 以指定的时间间隔（以微秒为单位）开始广播
        # 文档地址
        # https://docs.micropython.org/en/latest/library/bluetooth.html?highlight=irq#broadcaster-role-advertiser
        self.ble.gap_advertise(100, bytearray(b'\x02\x01\x02') + bytearray((len(name) + 1, 0x09)) + name)

# 创建一个名为ESP32的蓝牙广播
ble = BLE("LPDEVICE".encode())