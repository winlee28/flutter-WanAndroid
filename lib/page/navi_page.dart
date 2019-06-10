import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/navi_dao.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/model/navi_model.dart';
import 'package:my_wanandroid/widget/webview.dart';
import 'package:toast/toast.dart';

class NaviPage extends StatefulWidget {
  @override
  _NaviPageState createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  List<NaviData> naviData = [];
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网站导航'),
        centerTitle: true,
      ),
      body: naviData.length > 0
          ? Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: naviData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = index;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                color: isSelected == index
                                    ? Color(0XFFFFFFFF)
                                    : Color(0XFFF0F0F0),
                              ),
                              child: Text(
                                naviData[index].name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        })),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: naviData[isSelected]
                            .articles
                            .map((ArticleItem item) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WebView(
                                  title: item.title,
                                  url: item.link,
                                );
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration:
                                  BoxDecoration(color: Color(0XFFF0F0F0)),
                              margin: EdgeInsets.all(5),
                              child: Text(item.title),
                              alignment: Alignment.center,
                            ),
                          );
                        }).toList(),
                      ),
                    ))
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _loadData() {
    NaviDao.fetch().then((model) {
      setState(() {
        naviData = model.naviData;
      });
    }).catchError((error) {
      Toast.show(error.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    });
  }
}
