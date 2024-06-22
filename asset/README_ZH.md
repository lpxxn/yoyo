# 远程唤醒你的macbook
一直以来，没有找到特别好的方案来远程唤醒我的macbook，并解锁屏幕。
查看苹果的官方文档，macbook支持局域网内`WOL`唤醒，还有这个项目[BLEUnlock](https://github.com/ts1/BLEUnlock)，正好我有一个`ESP32`设备，就有了一个想法，我可以用`IOT`和`ESP32`进行通信，让`ESP32`进行`WOL`唤醒，或者蓝牙广播，来唤醒我的`macbook`，再写一个服务，用于自动输入密码，来解锁屏幕。总体设计如下
![design](/asset/design.png)
