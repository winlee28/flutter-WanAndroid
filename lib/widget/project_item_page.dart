import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/project_item_dao.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/widget/article_card.dart';
import 'package:my_wanandroid/widget/project_card.dart';
import 'package:toast/toast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                  onRefresh: _onRefresh,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: new StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: itemList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          new Container(
                              child: ProjectCard(
                            articleItem: itemList[index],
                            index: index,
                          )),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                    ),
                  ),
                )))
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
      Toast.show(error.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    });
  }

  Future<Null> _onRefresh() async {
    offset = 0;
    _loadItemPage();
    return null;
  }
}
