import 'dart:ui';

import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
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
              '浪里个浪',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              '浪里个浪@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            otherAccountsPictures: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors.black),
                ),
              )
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
          ListTile(
            title: Text(
              '玩安卓',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.android),
          ),
          ListTile(
            title: Text(
              '注销',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
