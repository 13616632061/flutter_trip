import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';


class TabNavigation extends StatefulWidget {
  @override
  _TabNaviagtionState createState() {
    // TODO: implement createState
    return _TabNaviagtionState();
  }

}

class _TabNaviagtionState extends State<TabNavigation> {

  PageController _controller = new PageController();
  Color defautColor = Colors.grey;
  Color activiteColor = Colors.blue;
  var curIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: curIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            curIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: defautColor),
              activeIcon: Icon(Icons.home, color: activiteColor),
              title: Text("首页", style: TextStyle(
                  color: curIndex == 0 ? activiteColor : defautColor),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: defautColor),
              activeIcon: Icon(Icons.search, color: activiteColor),
              title: Text("搜索", style: TextStyle(
                  color: curIndex == 1 ? activiteColor : defautColor),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt, color: defautColor),
              activeIcon: Icon(Icons.camera_alt, color: activiteColor),
              title: Text("旅拍", style: TextStyle(
                  color: curIndex == 2 ? activiteColor : defautColor),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_location, color: defautColor),
              activeIcon: Icon(Icons.my_location, color: activiteColor),
              title: Text("我的", style: TextStyle(
                  color: curIndex == 3 ? activiteColor : defautColor),)
          ),
        ],
      ),
    );
  }

}
