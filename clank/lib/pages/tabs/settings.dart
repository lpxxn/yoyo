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

const screenServerAPIURL = 'screenApiURL';
const awsAPIURL = 'awsApiURL';
const certificateKeyName = "certificate";
const certChainKeyName = 'certChainKey';
const privateKeyName = 'privateKey';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _textScreenApiURLController =
      TextEditingController();
  final TextEditingController _textIOTApiURLController =
      TextEditingController();
  final TextEditingController _textCertificateKeyController =
      TextEditingController();
  final TextEditingController _textCertChainController =
      TextEditingController();
  final TextEditingController _textPrivateKeyController =
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
      _textScreenApiURLController.text =
          prefs.getString(screenServerAPIURL) ?? '';
      _textIOTApiURLController.text = prefs.getString(awsAPIURL) ?? "";
      _textCertificateKeyController.text =
          prefs.getString(certificateKeyName) ?? "";
      _textCertChainController.text = prefs.getString(certChainKeyName) ?? "";
      _textPrivateKeyController.text = prefs.getString(privateKeyName) ?? "";
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(screenServerAPIURL, _textScreenApiURLController.text);
    prefs.setString(awsAPIURL, _textIOTApiURLController.text);
    prefs.setString(certificateKeyName, _textCertificateKeyController.text);
    prefs.setString(certChainKeyName, _textCertChainController.text);
    prefs.setString(privateKeyName, _textPrivateKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, bottom: 50),
        child: Column(children: [
          // const SizedBox(height: 10),
          // Container(
          //   height: 55,
          //   margin: const EdgeInsets.symmetric(horizontal: 29),
          //   child: TextField(
          //       controller: _textIOTApiURLController,
          //       maxLines: null,
          //       minLines: null,
          //       expands: true,
          //       decoration: InputDecoration(
          //           labelText: "IOT Endpoint",
          //           // contentPadding: const EdgeInsets.symmetric(vertical: 50.0),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ))),
          // ),
          const SizedBox(height: 10),
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 29),
            child: TextField(
                controller: _textIOTApiURLController,
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                    labelText: "IOT Endpoint",
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
                controller: _textCertificateKeyController,
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                    labelText: "certification",
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
                controller: _textCertChainController,
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                    labelText: "certificationChain",
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
