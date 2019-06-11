import 'package:flutter/material.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/widget/webview.dart';
import 'package:toast/toast.dart';

class ProjectCard extends StatefulWidget {
  final ArticleItem articleItem;
  final int index;

  const ProjectCard({Key key, this.articleItem, this.index}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebView(
                url: widget.articleItem.link,
                title: widget.articleItem.title,
              ))),
      child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: widget.index % 2 == 0 ? 140 : 80,
                  width: 200,
                  child: Image.network(
                    widget.articleItem.envelopePic,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    widget.articleItem.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: LimitedBox(
                        maxWidth: 50,
                        child: Text(
                          '${widget.articleItem.author}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
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
}
