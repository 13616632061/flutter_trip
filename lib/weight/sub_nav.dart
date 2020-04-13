import 'package:flutter/material.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/weight/webview.dart';
import 'package:flutter_trip/model/home_model/common_model.dart';

class SubNav extends StatefulWidget {

  List<CommonModel> subNavList;

  SubNav(this.subNavList);

  @override
  _SubNavState createState() {
    return _SubNavState();
  }

}

class _SubNavState extends State<SubNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: SubNavWeight(context),),
    );
  }

  SubNavWeight(BuildContext context) {
    List<Widget> items = [];
    print(widget.subNavList);
    if (widget.subNavList == null) return null;
    widget.subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    int rowNum = (widget.subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, rowNum),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(rowNum, widget.subNavList.length),
          ),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Image.network(model.icon, height: 18, width: 18,),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(model.title, style: TextStyle(fontSize: 12),),
              )
            ],
          ),
          onTap: () {
            NavigatorUtil.push(context,
                WebView(url: model.url,
                  title: model.title,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,));
          },
        ));
  }
}