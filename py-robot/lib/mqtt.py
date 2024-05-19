import os
import time
import ujson
from umqtt.simple import MQTTClient

aws_endpoint = b'a244sdkbxgj2hu.iot.cn-north-1.amazonaws.com.cn'
client_id = "012b23ad-ad20-45d4-bce3-6af82683fd92"
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

shadow_topic_pub = "$aws/things/" + thing_name + "/shadow/update"
shadow_topic_sub = "$aws/things/" + thing_name + "/shadow/update/delta"
ssl_params = {"key": key, "cert": cert}
print("topic_pub: ", shadow_topic_pub)
ble_topic_sub = f"testDeviceType/${client_id}/scanBle"

def mqtt_connect(client=client_id, endpoint=aws_endpoint, sslp=ssl_params):
    mqtt = MQTTClient(client_id=client, server=endpoint, port=8883, keepalive=1200, ssl=True, ssl_params=sslp)
    print("Connecting to AWS IoT...")
    mqtt.connect()
    print("Done")
    mqtt.set_callback(mqtt_subscribe)
    mqtt.subscribe(shadow_topic_sub)
    mqtt.subscribe(ble_topic_sub)
    # Publish a test MQTT message.
    # mqtt.publish(topic=topic_pub, msg='hello world', qos=0)
    mesg = ujson.dumps({
        "state": {
            "reported": {
            }
        }
    })

    # Using the message above, the device shadow is updated.
    mqtt_publish(client=mqtt, message=mesg)
    return mqtt


def mqtt_publish(client, topic=shadow_topic_pub, message=''):
    print("Publishing message...")
    print("topic:", shadow_topic_pub)
    client.publish(topic, message)
    print("msg: ", message)


def mqtt_subscribe(topic, msg):
    print("Message received...")
    message = ujson.loads(msg)
    print(topic, message)
    if 'state' not in message:
        print("no state")
        return
    state = message['state']
    if 'command' not in state:
        print("no command")
        return
    command = state['command']
    print(command)
    print("Subscribe Done")

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
