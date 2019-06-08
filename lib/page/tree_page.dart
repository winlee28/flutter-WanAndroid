import 'package:flutter/material.dart';
import 'package:my_wanandroid/dao/tree_dao.dart';
import 'package:my_wanandroid/model/tree_model.dart';
import 'package:my_wanandroid/widget/tree_item_page.dart';

class TreePage extends StatefulWidget {
  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  List<TreeItems> _itemList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('体系'),
        centerTitle: true,
      ),
      body: _itemList.length > 0
          ? ListView.builder(
              itemCount: _itemList.length,
              itemBuilder: (context, index) {
                return _items(_itemList[index], _itemList[index].detailItem);
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _items(TreeItems item, List<TreeItemsDetail> detailItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 18),
          child: Text(item.name,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        Wrap(
          children: detailItem.map((items) {
            return Padding(
              padding: EdgeInsets.only(left: 15),
              child: Chip(
                backgroundColor: _getColor(items.name),
                label: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return TreeItemPage(
                        cid: items.id,
                        title: items.name,
                      );
                    }));
                  },
                  child: Text(
                    items.name,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Divider(
          color: Colors.grey,
          height: 10,
          indent: 15,
        )
      ],
    );
  }

  void _loadData() {
    TreeDao.fetch().then((model) {
      setState(() {
        _itemList = model.data;
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  _getColor(String name) {
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 11)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}
