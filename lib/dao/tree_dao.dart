import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_wanandroid/http/API.dart';
import 'package:my_wanandroid/model/project_tab_model.dart';
import 'package:my_wanandroid/model/tree_model.dart';

class TreeDao {
  static Future<TreeModel> fetch() async {
    var result = await http.get(API.TREE_URL);
    if (result?.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var model = json.decode(utf8decoder.convert(result.bodyBytes));
      var finalModel = TreeModel.fromJson(model);
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
