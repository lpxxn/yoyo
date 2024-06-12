import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> saveName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('name', 'John Doe');
// }

// Future<String?> getName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('name');
// }

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var name = "name";
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "haha";
      _textController.text = name;
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _textController.text);
    setState(() {
      name = _textController.text;
    });
  }

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
          controller: _textController,
          decoration: InputDecoration(
              labelText: "pubKey",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
      Text(name),
      ElevatedButton(
          onPressed: () async => {_saveSettings()},
          child: const Text("setName")),
      ElevatedButton(onPressed: _loadSettings, child: const Text("getName"))
    ]));
  }
}
