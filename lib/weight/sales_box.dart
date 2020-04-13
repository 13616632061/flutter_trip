import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/model/home_model/salex_box_model.dart';
import 'package:flutter_trip/weight/webview.dart';


class SalesBox extends StatelessWidget {

  SalesBoxModel salesBoxModel;

  SalesBox(this.salesBoxModel);

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return _items(context);
  }

  _items(BuildContext context) {
    List<Widget> items = [];

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xfff2f2f2), width: 1)
                )
            ),
            child: _itemTitle(context),
          )
        ],
      ),
    );
  }

  Widget _itemTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.network(salesBoxModel.icon, height: 15, fit: BoxFit.fill,),
        Container(
          padding: EdgeInsets.fromLTRB(10, 1, 8, 2),
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                  begin: Alignment.centerLeft, end: Alignment.centerRight)
          ),
          child: GestureDetector(
            child: Text(
              "查看更多福利 >", style: TextStyle(color: Colors.white, fontSize: 12),),
            onTap: () {
              NavigatorUtil.push(
                  context, WebView(url: salesBoxModel.moreUrl, title: "更多活动",));
            },
          ),
        )
      ],
    );
  }
}