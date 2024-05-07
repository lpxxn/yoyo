import os
import time
import ujson
from umqtt.simple import MQTTClient

aws_endpoint = b'a244sdkbxgj2hu.ats.iot.cn-north-1.amazonaws.com.cn'
client_id = "31A8D901-E95F-43BD-9124-C6CD2B06C369"
private_key = "private.pem.key"
private_cert = "cert.pem.crt"
thing_name = "Thing_testDeviceType_" + client_id

# Read the files used to authenticate to AWS IoT Core
with open(private_key, 'r') as f:
    key = f.read()
    print("key", key)
with open(private_cert, 'r') as f:
    cert = f.read()
    print("cert", cert)

topic_pub = "$aws/things/" + thing_name + "/shadow/update"
topic_sub = "$aws/things/" + thing_name + "/shadow/update/delta"
ssl_params = {"key": key, "cert": cert, "server_side": False}


def mqtt_connect(client=client_id, endpoint=aws_endpoint, sslp=ssl_params):
    mqtt = MQTTClient(client_id=client, server=endpoint, port=8883, keepalive=1200, ssl=True, ssl_params=sslp)
    print("Connecting to AWS IoT...")
    mqtt.connect()
    print("Done")
    return mqtt


def mqtt_publish(client, topic=topic_pub, message=''):
    print("Publishing message...")
    client.publish(topic, message)
    print(message)


def mqtt_subscribe(topic, msg):
    print("Message received...")
    message = ujson.loads(msg)
    print(topic, message)
    print("Done")

# 应用程序希望
# {
#   "state": {
#     "desired": {
#       "color": "eeeaf","foo":"vvv"
#     }
#   }
# }
# 设备 report 完后
# {
#   "state": {
#     "reported": {
#       "command": "cccc","name":"bb","color":"eeeaf","foo":"vveev"
#     }
#   }
# }
# delta里只显示设备和desired不一样的值
# [Message]
# Topic: $aws/things/Thing_testDeviceType_012b23ad-ad20-45d4-bce3-6af82683fd92/shadow/update/accepted
# Payload:
# {"state":{"reported":{"command":"cccc","name":"bb","color":"eeeaf","foo":"vveev"}},"metadata":{"reported":{"command":{"timestamp":1715096264},"name":{"timestamp":1715096264},"color":{"timestamp":1715096264},"foo":{"timestamp":1715096264}}},"version":324,"timestamp":1715096264}
#
# [Message]
# Topic: $aws/things/Thing_testDeviceType_012b23ad-ad20-45d4-bce3-6af82683fd92/shadow/update/delta
# Payload:
# {"version":324,"timestamp":1715096264,"state":{"foo":"vvv"},"metadata":{"foo":{"timestamp":1715095641}}}
