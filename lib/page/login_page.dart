import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/login_dao.dart';
import 'package:my_wanandroid/page/regist_page.dart';
import 'package:my_wanandroid/utils/images_provider.dart';
import 'package:my_wanandroid/utils/prefs_provider.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPhoneClose = false;
  bool showPasswordClose = false;
  String phone;
  String password;
  TextEditingController _onPhoneController = TextEditingController();
  TextEditingController _onPasswordController = TextEditingController();
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: Image.asset(
              ImagesProvider.getImagePath('logo'),
              width: 100,
              height: 100,
            ),
          ),
          createInput(_onPhoneChange, _onPhoneController, Icons.phone_android,
              showPhoneClose, true),
          createInput(_onPasswordChange, _onPasswordController,
              Icons.lock_outline, showPasswordClose, false),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
                    child: RaisedButton(
                      onPressed: _login,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        '登录',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue,
                      highlightColor: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('没有账号?'),
              InkWell(
                onTap: () {
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
//                    return RegisterPage();
//                  }),ModalRoute.withName('/HomePage'));
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/RegisterPage');
                },
                child: Text(
                  '去注册',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  createInput(ValueChanged<String> onChanged, TextEditingController controller,
      IconData icon, bool close, bool isPhone) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            obscureText: isPhone ? false : true,
            style: TextStyle(
              fontSize: 16,
            ),
//                  maxLength: 10,
            maxLines: 1,
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 5, 50, 5),
              border: InputBorder.none,
              icon: Icon(
                icon,
                color: Colors.blue,
              ),
              labelText: isPhone ? '请输入用户名' : '请输入密码',
            ),
          ),
          close
              ? Container(
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      controller.clear();
                      setState(() {
                        isPhone
                            ? showPhoneClose = false
                            : showPasswordClose = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void _onPhoneChange(String text) {
    phone = text;
    if (text.length > 0) {
      setState(() {
        showPhoneClose = true;
      });
    } else {
      setState(() {
        showPhoneClose = false;
      });
    }
  }

  void _onPasswordChange(String text) {
    password = text;
    if (text.length > 0) {
      setState(() {
        showPasswordClose = true;
      });
    } else {
      setState(() {
        showPasswordClose = false;
      });
    }
  }

  void _login() {
    LoginDao.fetch(phone, password).then((model) {
      Toast.show('登录成功', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      prefs.setString(PrefsProvider.USER_NAME, phone);
      Navigator.pop(context);
    }).catchError((error) {
      Toast.show(error.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    });
  }
}
