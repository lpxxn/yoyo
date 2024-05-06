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
with open(private_cert, 'r') as f:
    cert = f.read()

topic_pub = "$aws/things/" + thing_name + "/shadow/update"
topic_sub = "$aws/things/" + thing_name + "/shadow/update/delta"
ssl_params = {"key": key, "cert": cert, "server_side": False}

info = os.uname()


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


# We use our helper function to connect to AWS IoT Core.
# The callback function mqtt_subscribe is what will be called if we
# get a new message on topic_sub.
try:
    mqtt = mqtt_connect()
    mqtt.set_callback(mqtt_subscribe)
    mqtt.subscribe(topic_sub)
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
                    "client": client_id,
                    "uptime": time.ticks_ms(),
                    "hardware": info[0],
                    "firmware": info[2]
                },
                "sensors": {
                    "light": light_sensor.read()
                },
                "led": {
                    "onboard": led.value()
                }
            }
        }
    })

    # Using the message above, the device shadow is updated.
    try:
        mqtt_publish(client=mqtt, message=mesg)
    except:
        print("Unable to publish message.")

    # Wait for 10 seconds before checking for messages and publishing a new update.
    print("Sleep for 10 seconds")
    time.sleep(10)
