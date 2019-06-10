import 'package:flutter/material.dart';
import 'package:my_wanandroid/page/home_page.dart';
import 'package:my_wanandroid/page/login_page.dart';
import 'package:my_wanandroid/page/regist_page.dart';

import 'navigationbar/navigation_bar_tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩安卓",
      theme: ThemeData(fontFamily: 'noto', primaryColor: Colors.blue),
      home: NavigationBarTab(),
      routes: {'/HomePage': (context) => HomePage(),
      '/LoginPage':(context) => LoginPage(),
      '/RegisterPage':(context) => RegisterPage()},
    );
  }
}
