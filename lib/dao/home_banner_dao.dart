import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_wanandroid/http/API.dart';
import 'package:my_wanandroid/model/home_banner_model.dart';

class HomeBannerDao {
  static Future<HomeBannerModel> fetch() async {
    var homeModel = await http.get(API.HOME_BANNER_URL);
    if (homeModel?.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(homeModel.bodyBytes));
      var model = HomeBannerModel.fromJson(result);
      if (model.errorCode == 0) {
        return model;
      } else {
        throw new Exception("服务器异常");
      }
    } else {
      throw new Exception("网络错误");
    }
  }
}
