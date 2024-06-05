import 'package:flutter/material.dart';
import './tabs/home.dart';
import './tabs/settings.dart';

class Tab extends StatefulWidget {
  const Tab({super.key});

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  int _currentIdx = 0;
  List<Widget> _pages = [HomePage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLANK"),
      ),
      body: _pages[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: (index) {
          setState(() {
            _currentIdx = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "MSG"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.cell_wifi_outlined), label: "WOL"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "SETTINGS")
        ],
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(6),
        margin: EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
          child: const Icon(Icons.adb),
          onPressed: () {
            print("WOL");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
