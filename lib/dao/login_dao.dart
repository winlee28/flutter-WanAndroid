import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_wanandroid/http/API.dart';
import 'package:my_wanandroid/model/BaseModel.dart';

class LoginDao {
  static Future<BaseModel> fetch(String name, String password) async {
//    Map<String, Object> params = LinkedHashMap();
//    params.putIfAbsent("username", () => name);
//    params.putIfAbsent("password", () => password);
    var result = await http.post(API.LOGIN_URL, body: {'username': name, 'password': password});
    if (result.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var convert = json.decode(utf8decoder.convert(result.bodyBytes));
      var model = BaseModel.fromJson(convert);
      print("=====model=====$model");
      if (model.errorCode == 0) {
        return model;
      } else {
        throw Exception(model.errorMsg);
      }
    } else {
      throw Exception('网络异常');
    }
  }
}
