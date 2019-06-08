import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_wanandroid/http/API.dart';
import 'package:my_wanandroid/model/article_model.dart';

class HomeArticleDao {
  static  Future<ArticleModel> fetch(int offset) async {
    var result = await http
        .get(API.HOME_ARTICLE_URL_BEFORE + offset.toString() + API.HOME_ARTICLE_URL_AFTER);
    if (result?.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var model = json.decode(utf8decoder.convert(result.bodyBytes));
      var finalModel = ArticleModel.fromJson(model);
      if (finalModel.errorCode == 0) {
        return finalModel;
      } else {
        throw Exception('服务器异常');
      }
    } else {
      throw Exception('网络错误');
    }
  }
}
