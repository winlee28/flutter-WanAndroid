import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/project_tab_dao.dart';
import 'package:my_wanandroid/model/project_tab_model.dart';
import 'package:my_wanandroid/widget/project_item_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  List<TabItems> tabItems = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadTabsData();
    _tabController = new TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return tabItems.length > 0
        ? Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                color: Colors.blue,
                child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: EdgeInsets.all(10),
                    indicatorColor: Colors.white,
                    indicatorPadding: EdgeInsets.all(5),
                    tabs: tabItems.map((items) {
                      return Text(
                        items.name,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    }).toList()),
              ),
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: tabItems.map((items) {
                        return ProjectItemPage(
                          cid: items.id,
                        );
                      }).toList()))
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void _loadTabsData() {
    ProjectTabDao.fetch().then((model) {
      setState(() {
        tabItems = model.tabItems;
        _tabController =
            new TabController(length: tabItems.length, vsync: this);
      });
    }).catchError((error) => print(error.toString()));
  }
}
