import 'package:my_wanandroid/model/article_model.dart';

class NaviModel {
  List<NaviData> naviData;
  int errorCode;
  String errorMsg;

  NaviModel({this.naviData, this.errorCode, this.errorMsg});

  NaviModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      naviData = new List<NaviData>();
      json['data'].forEach((v) {
        naviData.add(new NaviData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.naviData != null) {
      data['data'] = this.naviData.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class NaviData {
  List<ArticleItem> articles;
  int cid;
  String name;

  NaviData({this.articles, this.cid, this.name});

  NaviData.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<ArticleItem>();
      json['articles'].forEach((v) {
        articles.add(new ArticleItem.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    data['cid'] = this.cid;
    data['name'] = this.name;
    return data;
  }
}
