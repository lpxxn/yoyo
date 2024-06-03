import 'package:flutter/material.dart';

class Tab extends StatefulWidget {
  const Tab({super.key});

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  int _currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLANK"),
      ),
      body: const Text("my clank"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: (index) {
          setState(() {
            _currentIdx = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "MSG"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "SETTINGS")
        ],
      ),
    );
  }
}
