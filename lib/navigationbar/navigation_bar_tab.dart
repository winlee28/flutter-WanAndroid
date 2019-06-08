import 'package:flutter/material.dart';
import 'package:my_wanandroid/page/home_page.dart';
import 'package:my_wanandroid/page/navi_page.dart';
import 'package:my_wanandroid/page/project_page.dart';
import 'package:my_wanandroid/page/tree_page.dart';

class NavigationBarTab extends StatefulWidget {
  @override
  _NavigationBarTabState createState() => _NavigationBarTabState();
}

class _NavigationBarTabState extends State<NavigationBarTab> {
  var _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _createBottomNavigationBarItem(
                Icons.home, Colors.grey, Colors.blue, 0, '首页'),
            _createBottomNavigationBarItem(
                Icons.school, Colors.grey, Colors.blue, 1, '项目'),
            _createBottomNavigationBarItem(Icons.format_indent_decrease,
                Colors.grey, Colors.blue, 2, '体系'),
            _createBottomNavigationBarItem(
                Icons.picture_in_picture_alt, Colors.grey, Colors.blue, 3, '导航'),
          ]),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: _onPageChange,
        children: <Widget>[HomePage(), ProjectPage(), TreePage(), NaviPage()],
      ),
    );
  }

  _createBottomNavigationBarItem(IconData icon, Color unSelectColor,
      Color selectColor, int index, String tabName) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: unSelectColor,
        ),
        title: Text(
          tabName,
          style: TextStyle(
              color: _currentIndex == index ? Colors.blue : Colors.grey),
        ),
        activeIcon: Icon(
          icon,
          color: selectColor,
        ));
  }

  void _onTap(int index) {
    setState(() {
      _controller.jumpToPage(index);
      _currentIndex = index;
    });
  }

  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
