## 远程唤醒你的macbook
一直以来，没有找到特别好的方案来远程唤醒我的macbook，并解锁屏幕。    
查看苹果的官方文档，macbook支持局域网内`WOL`唤醒，还发一个有趣的项目[BLEUnlock](https://github.com/ts1/BLEUnlock)，他可以用蓝牙来唤醒mac，正好我有一个`ESP32`设备，就有了一个想法，我可以用`IOT MQTT`和`ESP32`进行通信，让`ESP32`进行`WOL`唤醒，或者蓝牙广播，来唤醒我的`macbook`，再写一个服务,运行在`mac`上，用于自动自动输入密码，来解锁屏幕。总体设计如下
![design](/asset/design.png)


## `mac`端服务`robot-srv`
`robot-srv`一个很小的服务，跑在`mac`上，用于在锁屏状态下，输入密码,暴露出两个接口
* `/screen/pwd`用于保存密码，会把原密码进行加密后保存，所以不用担心安全问题
* `/unlock`是用于在锁屏状态下，输入密码进行登录的接口
![design](/asset/robot-srv.png)


## `ESP32`
需要把`py-robot`烧录到`ESP32`内，`py-robot`要和`mac`在同一个局域网内,配置好`wifi`信息后，就可以监听`AWS IOT`消息，当有消息发送过来时，进行相应的操作`WOL`、`bluetooth`advertiser或者是解锁屏幕
![design](/asset/esp32.png)


## `Clank`客户端
`Clank`是用`flutter`写的一个客户端，可以跑的`android`,`mac`,`ios`等平台上，用于发送`IOT MQTT`消息，先设置好`AWS ITO`需要的证书和密钥
![design](/asset/settings.png)


主页可以进行消息的发送，`WOL`用于发送`Wake-on-LAN`或者解锁屏幕消息

![design](/asset/home.png)