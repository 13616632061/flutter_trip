import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/model/home_model/salex_box_model.dart';
import 'package:flutter_trip/weight/webview.dart';
import 'package:flutter_trip/model/home_model/common_model.dart';


class SalesBox extends StatelessWidget {

  SalesBoxModel salesBoxModel;

  SalesBox(this.salesBoxModel);

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if(salesBoxModel==null)return null;
    List<Widget> items = [];
    items.add(_doubleItems(
        context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
    items.add(_doubleItems(
        context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false,
        false));
    items.add(_doubleItems(
        context, salesBoxModel.smallCard3, salesBoxModel.smallCard3, false,
        true));

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
          ),
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: items,
//          )
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0,1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: items.sublist(1,2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: items.sublist(2,3),
        ),
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

  _doubleItems(BuildContext context, CommonModel leftmodel,
      CommonModel rightmodel, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftmodel, true, last, big),
        _item(context, rightmodel, false, last, big),
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool left, bool last,
      bool big) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context,
            WebView(
              url: model.url,
              title: model.title,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: left ? borderSide : BorderSide.none,
                bottom: last ? BorderSide.none : borderSide
            )
        ),
        child: Image.network(
          model.icon,
          width: MediaQuery
              .of(context)
              .size
              .width / 2 - 10,
          height: big ? 120 : 80,
          fit: BoxFit.fill,),
      ),
    );
  }
}