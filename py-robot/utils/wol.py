import usocket
import struct

from tools import StringTool


class WOL():
    def __init__(self, IP, MAC_ADDRESS):
        self.IP = IP
        self.MAC_ADDRESS = MAC_ADDRESS
        self.SO_BROADCAST = 32

    def do(self):
        # 初始化 IP 和 MAC
        try:
            print('start send magic packet to ', self.MAC_ADDRESS)

            host_ip = self.IP
            print("host_ip: ", host_ip)

            host = (host_ip[: StringTool.rindex(host_ip, '.') + 1] + '255', 9)
            print("host: ", host)

            mac_address = self.MAC_ADDRESS
            mac_address_fmt = StringTool.replace(mac_address, ':', '')
            mac_address_fmt = StringTool.replace(mac_address_fmt, '-', '')
            print("mac_address_fmt: ", mac_address_fmt)
        except:
            print('WOL Init error, String except...')
        finally:
            print('WOL Init finally')
        # 编写 WOL 协议数据
        try:
            data = StringTool.join('', ['FFFFFFFFFFFF', mac_address_fmt * 16])
            send_data = b''
            for i in range(0, len(data), 2):
                send_data = StringTool.join(b'', [send_data, struct.pack('B', int(data[i: i + 2], 16))])
            print("send_data: ", send_data)
        except:
            print('WOL Code error, String except...')
        finally:
            print('WOL Code finally')
        # 发送 WOL 魔术包
        try:
            sock = usocket.socket(usocket.AF_INET, usocket.SOCK_DGRAM, 1)
            sock.setsockopt(usocket.SOL_SOCKET, self.SO_BROADCAST, 1)
            sock.sendto(send_data, host)
        except:
            print('WOL Socket error, About SO_BROADCAST except...')
        finally:
            sock.close()
            print('WOL Socket finally')
