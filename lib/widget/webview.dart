import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String title;

  const WebView({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child:Container(child:  Icon(Icons.close),padding: EdgeInsets.all(5),),
        ),
      ),
      url: widget.url,
      withZoom: true,
      hidden: true,
      initialChild: Center(child: CircularProgressIndicator()),
    );
  }
}
