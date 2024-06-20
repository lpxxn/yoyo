import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    onPressed: () {},
                    label: Text("UnlockScreen"),
                    icon: Icon(Icons.screen_lock_landscape),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize: Size(double.infinity, double.infinity),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("WOL"),
                    icon: Icon(Icons.wifi_find),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize: Size(double.infinity, double.infinity),
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
                    onPressed: () {},
                    label: Text("Iot-BLE"),
                    icon: Icon(Icons.bluetooth_audio_outlined),
                    style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(10),
                        minimumSize: Size(double.infinity, double.infinity),
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
