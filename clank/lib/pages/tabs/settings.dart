import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', 'John Doe');
}

Future<String?> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name');
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var name = "name";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      TextField(
          decoration: InputDecoration(
              labelText: "privateKey",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
      TextField(
          decoration: InputDecoration(
              labelText: "pubKey",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
      Text(name),
      ElevatedButton(
          onPressed: () async => {await saveName()},
          child: const Text("setName")),
      ElevatedButton(onPressed: changeName, child: Text("getName"))
    ]));
  }

  void changeName() async {
    var v = await getName();
    setState(() {
      print(v);
      name = v!;
    });
  }
}
