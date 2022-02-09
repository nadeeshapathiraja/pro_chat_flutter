import 'package:flutter/material.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/screens/main/home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [Home(), Chat()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
    );
  }
}
