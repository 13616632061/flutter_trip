import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model/common_model.dart';

class GridNavWeight extends StatelessWidget {

  GridNavModel gridNav;

  GridNavWeight(this.gridNav);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel(
      color: Colors.transparent,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.hotel != null) {
      items.add(_gridNavitem(context, gridNav.hotel, true));
    }
    if (gridNav.flight != null) {
      items.add(_gridNavitem(context, gridNav.flight, false));
    }
    if (gridNav.travel != null) {
      items.add(_gridNavitem(context, gridNav.travel, false));
    }
    return items;
  }

  _gridNavitem(BuildContext context, GridNavItem item, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(item.mainItem));
    items.add(_doubleItem(item.item1, item.item2));
    items.add(_doubleItem(item.item3, item.item4));

    List<Widget> expendItems = [];
    items.forEach((item) {
      expendItems.add(Expanded(child: item, flex: 1,));
    });
    Color startColor = Color(int.parse("0xff" + item.startColor));
    Color endColor = Color(int.parse("0xff" + item.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(children: expendItems,),
    );
  }


  _mainItem(CommonModel model) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image.network(model.icon, height: 88, width: 121, fit: BoxFit.contain,
          alignment: AlignmentDirectional.bottomEnd,),
        Container(
          margin: EdgeInsets.only(top: 11),
          child: Text(
            model.title, style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,),
        )
      ],
    );
  }

  _item(CommonModel model, bool first) {
    BorderSide borderSide = BorderSide(color: Colors.white, width: 0.8);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: first ? borderSide : BorderSide.none
            ),
          ),
          child:
          Center(
            child: Text(model.title,
                style: TextStyle(color: Colors.white, fontSize: 14)),
          )
      ),
    );
  }

  _doubleItem(CommonModel modelTop, CommonModel modelBottom) {
    return Column(
      children: <Widget>[
        Expanded(child: _item(modelTop, true),),
        Expanded(child: _item(modelTop, false),)
      ],
    );
  }

}