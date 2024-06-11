import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:io';
import 'pages/tab.dart' as tabs;
import 'package:get_storage/get_storage.dart';

void main() async {
  // Load and obtain the shared preferences for this app.
  final prefs = await SharedPreferences.getInstance();

// Save the counter value to persistent storage under the 'counter' key.
  // await prefs.setInt('counter', 111);
  // await prefs.setString('name', 'John Doe');
  // print(prefs.get("counter"));
  print(prefs.getString('name'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clank',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const tabs.Tab(),
    );
  }
}
