import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
    ]));
  }
}
