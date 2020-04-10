import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 页面跳转
 */
class NavigatorUtil {

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}