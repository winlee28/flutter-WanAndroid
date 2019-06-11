import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_wanandroid/page/login_page.dart';
import 'package:my_wanandroid/utils/prefs_provider.dart';
import 'package:my_wanandroid/widget/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryData.fromWindow(window).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black12),
            accountName: Text(
              userName,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              '长风破浪会有时，直挂云帆济沧海。',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            otherAccountsPictures: <Widget>[
              userName.length == 0
                  ? Container(
                      padding: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : null
            ],
          ),
          ListTile(
            title: Text(
              '收藏',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.grade),
          ),
          ListTile(
            title: Text(
              '趣图',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.picture_in_picture),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebView(
                  title: '玩安卓',
                  url: 'https://www.wanandroid.com',
                );
              }));
            },
            child: ListTile(
              title: Text(
                '玩安卓',
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.android),
            ),
          ),
          userName.length != 0
              ? InkWell(
                  onTap: () {
                    showLogoutDialog();
                  },
                  child: ListTile(
                    title: Text(
                      '注销',
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Icon(Icons.power_settings_new),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(PrefsProvider.USER_NAME) ?? '';
    setState(() {});
  }

  void showLogoutDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("退出登录"),
                content: new Text("确认退出？"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("确定"),
                    onPressed: () {
                      logout();
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {
      userName = '';
    });
  }
}
