import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> saveName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('name', 'John Doe');
// }

Future<String?> getName(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

const awsApiURL = 'awsApiURL';
const privateKeyName = 'privateKey';
const publicKeyName = 'publicKey';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _textApiURLController = TextEditingController();
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
      _textApiURLController.text = prefs.getString(awsApiURL) ?? "";
      _textPrivateKeyController.text = prefs.getString(privateKeyName) ?? "";
      _textPublicKeyController.text = prefs.getString(publicKeyName) ?? "";
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(awsApiURL, _textApiURLController.text);
    prefs.setString(privateKeyName, _textPrivateKeyController.text);
    prefs.setString(publicKeyName, _textPublicKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 29),
            child: TextField(
                controller: _textApiURLController,
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                    labelText: "API URL",
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
              onPressed: () async => {_saveSettings()},
              child: const Text("SAVE")),
          // ElevatedButton(onPressed: _loadSettings, child: const Text("getName"))
        ]));
  }
}
