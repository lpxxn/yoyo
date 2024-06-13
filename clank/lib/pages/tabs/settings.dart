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
  final TextEditingController _textPrivateKeyController =
      TextEditingController();
  final TextEditingController _textPublicKeyController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textPrivateKeyController.text = prefs.getString('privateKey') ?? "";
      _textPublicKeyController.text = prefs.getString('publicKey') ?? "";
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('privateKey', _textPrivateKeyController.text);
    prefs.setString('publicKey', _textPublicKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const SizedBox(height: 20),
      Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 29),
        child: TextField(
            controller: _textPrivateKeyController,
            maxLines: null,
            minLines: null,
            expands: true,
            decoration: InputDecoration(
                labelText: "privateKey",
                // contentPadding: const EdgeInsets.symmetric(vertical: 50.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
      ),
      const SizedBox(height: 10),
      Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 29),
          child: TextField(
              controller: _textPublicKeyController,
              maxLines: null,
              minLines: null,
              expands: true,
              decoration: InputDecoration(
                  labelText: "pubKey",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )))),
      // Text(name),
      const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () async => {_saveSettings()}, child: const Text("SAVE")),
      // ElevatedButton(onPressed: _loadSettings, child: const Text("getName"))
    ]));
  }
}
