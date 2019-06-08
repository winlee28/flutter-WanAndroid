import 'package:flutter/material.dart';

import 'navigationbar/navigation_bar_tab.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩安卓",
      theme: ThemeData(
        fontFamily: 'noto',
        primaryColor: Colors.blue
      ),
      home: NavigationBarTab(),
    );
  }
}
