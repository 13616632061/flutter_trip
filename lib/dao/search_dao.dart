import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/search_model/search_model.dart';

class SearchDao{
  static Future<SearchModel> fetch(String url,String text) async{
    final respone=await http.get(url);
    if(respone.statusCode==200){
      Utf8Decoder utf8decoder=Utf8Decoder();
     var result= json.decode(utf8decoder.convert(respone.bodyBytes));
      SearchModel model=SearchModel.fromJson(result);
      model.keyword=text;
      return model;
    }else{
      throw Exception("Failed to load search_page.json");
    }
  }
}