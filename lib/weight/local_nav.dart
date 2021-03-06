import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model/common_model.dart';
import 'package:flutter_trip/weight/webview.dart';
import 'package:flutter_trip/util/navigator_util.dart';

class LocalNavWidget extends StatelessWidget {

  List<CommonModel> localNavList;

  LocalNavWidget(this.localNavList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  /**
   * 所有的item
   */
  Widget _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context,model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  /**
   * item
   */
  Widget _item(BuildContext context,CommonModel model) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,),
          Text(model.title, style: TextStyle(fontSize: 12),)
        ],
      ),
      onTap: () {
            NavigatorUtil.push(context,WebView(url: model.url,statusBarColor: model.statusBarColor,title: model.title,hideAppBar: model.hideAppBar,));
      },
    );
  }
}
