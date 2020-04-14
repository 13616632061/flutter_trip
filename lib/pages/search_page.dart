import 'package:flutter/material.dart';
import 'package:flutter_trip/weight/search_bar.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: Colors.white),
          height: 80,
          child: SearchBar(
            enabled: true,
            hideLeft: true,
            searchBarType: SearchBarType.nomal,
            hint: "搜索",
            defaultText: "",
          ),
        )

    );
  }

}
