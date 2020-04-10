import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_trip/model/home_model/home_model.dart';

const url = "https://www.devio.org/io/flutter_app/json/home_page.json";
/**
 * 首页接口请求
 */
class HomeDao {

  static Future<HomeModel> fetch() async {
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(respone.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception("Failed to load home_page.json");
    }
  }
}
