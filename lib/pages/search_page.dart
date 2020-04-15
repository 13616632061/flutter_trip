import 'package:flutter/material.dart';
import 'package:flutter_trip/weight/search_bar.dart';
import 'package:flutter_trip/model/search_model/search_model.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/weight/webview.dart';
import 'package:flutter_trip/util/navigator_util.dart';

const url = "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=";

class SearchPage extends StatefulWidget {

  bool hideLeft;
  String searchUrl;
  String keyword;
  String hint;


  SearchPage({this.hideLeft, this.searchUrl = url, this.keyword, this.hint});

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  @override
  void initState() {
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            _appbar(),
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: searchModel?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int position) {
                          return _item(position);
                        })))

          ],
        )
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchModelItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context,
            WebView(url: item.url, title: '详情',));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  child: _itemTitle(item),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  margin: EdgeInsets.only(top: 5),
                  child: _itemSubTitle(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _itemTitle(SearchModelItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)
    ));
    return RichText(text: TextSpan(children: spans));
  }

  _itemSubTitle(SearchModelItem item) {
    if (item != null && item.price != null) {
      return RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '价格：',
                    style: TextStyle(fontSize: 16, color: Colors.grey)
                ),
                TextSpan(
                    text: item.price ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.orange)
                ),
              ]

          ));
    } else {
      return RichText(
          text: TextSpan(
              text: item.price ?? '',
              style: TextStyle(fontSize: 16, color: Colors.orange)
          ));
    }
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    String wordL = word.toLowerCase(),
        keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle nomalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc]
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle
        ));
      }
      String val = arr[i];
      if (arr != null && arr.length > 0) {
        spans.add(TextSpan(text: val, style: nomalStyle));
      }
    }
    return spans;
  }

  _appbar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter)
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white),
            height: 80,
            child: SearchBar(
              hideLeft: widget.hideLeft,
              searchBarType: SearchBarType.nomal,
              hint: widget.hint,
              defaultText: widget.keyword,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            )
        )
      ],
    );
  }

  void _onTextChange(String text) {
    keyword = text;
    print(text);
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    print(url);
    SearchDao.fetch(url, text).then((SearchModel model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }


}
