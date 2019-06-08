import 'package:flutter/material.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/widget/webview.dart';
import 'package:toast/toast.dart';

class ArticleCard extends StatefulWidget {
  final ArticleItem articleItem;

  const ArticleCard({Key key, this.articleItem}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebView(
                url: widget.articleItem.link,
                title: widget.articleItem.title,
              ))),
      child: Card(
          elevation: 5,
          margin: EdgeInsets.only(left: 10, right: 10, top: 8),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    widget.articleItem.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    widget.articleItem.desc == ""
                        ? widget.articleItem.title * 2
                        : widget.articleItem.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
                Row(
                  children: <Widget>[
                    _itemTags(widget.articleItem.superChapterName,
                        widget.articleItem.projectLink),
                    _itemTags(widget.articleItem.chapterName,
                        widget.articleItem.projectLink)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '作者：${widget.articleItem.author}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      widget.articleItem.niceDate,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  _itemTags(String name, String projectLink) {
    return GestureDetector(
      onTap: () => projectLink != ""
          ? Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WebView(
                    url: projectLink,
                    title: name,
                  )))
          : Toast.show("暂无项目地址", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER),
      child: Container(
        height: 22,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10, right: 10),
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          name,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
