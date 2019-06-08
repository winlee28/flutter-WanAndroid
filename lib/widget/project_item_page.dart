import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/project_item_dao.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/widget/article_card.dart';

class ProjectItemPage extends StatefulWidget {
  final int cid;

  const ProjectItemPage({Key key, this.cid}) : super(key: key);

  @override
  _ProjectItemPageState createState() => _ProjectItemPageState();
}

class _ProjectItemPageState extends State<ProjectItemPage> {
  List<ArticleItem> itemList = [];
  int offset = 0;

  @override
  void initState() {
    super.initState();
    _loadItemPage();
  }

  @override
  Widget build(BuildContext context) {
    return itemList.length > 0
        ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
                onNotification: (onNotification) {
                  if (onNotification is ScrollUpdateNotification) {
                    if (onNotification.metrics.pixels ==
                        onNotification.metrics.maxScrollExtent) {
                      offset++;
                      _loadItemPage();
                    }
                  }
                },
                child: RefreshIndicator(
                    child: ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            articleItem: itemList[index],
                          );
                        }),
                    onRefresh: _onRefresh)))
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void _loadItemPage() {
    ProjectItemDao.fetch(offset, widget.cid).then((model) {
      setState(() {
        if (offset == 0) {
          itemList = model.data.itemList;
        } else {
          itemList.addAll(model.data.itemList);
        }
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<Null> _onRefresh() async {
    offset = 0;
    _loadItemPage();
    return null;
  }
}
