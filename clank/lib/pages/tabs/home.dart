import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ito.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _loadSettings() async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      sendMsg(
                          IotTopic.unlockScreenTopic, {"unlockScreen": "v"});
                    },
                    label: const Text("UnlockScreen"),
                    icon: const Icon(Icons.screen_lock_landscape),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize:
                            const Size(double.infinity, double.infinity),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      sendMsg(IotTopic.wolTopic, {"wol": "v"});
                    },
                    label: const Text("WOL"),
                    icon: const Icon(Icons.wifi_find),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize:
                            const Size(double.infinity, double.infinity),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      sendMsg(IotTopic.scanBleTopic, {"scanBle": "v"});
                    },
                    label: const Text("Iot-BLE"),
                    icon: const Icon(Icons.bluetooth_audio_outlined),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize:
                            const Size(double.infinity, double.infinity),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                )),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  // child: ElevatedButton.icon(
                  //   onPressed: () {},
                  //   label: Text("WOL"),
                  //   icon: Icon(Icons.wifi_find),
                  // ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
