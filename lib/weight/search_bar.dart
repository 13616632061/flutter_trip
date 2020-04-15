import 'package:flutter/material.dart';

enum SearchBarType { nomal, home, homeLight }

class SearchBar extends StatefulWidget {

  bool enabled;
  bool hideLeft;
  SearchBarType searchBarType;
  String hint;
  String defaultText;
  void Function() leftButtonClick;
  void Function() rightButtonClick;
  void Function() speekClick;
  void Function() inputBoxClick;
  ValueChanged<String> onChanged;


  SearchBar({this.enabled = true,
    this.hideLeft,
    this.searchBarType = SearchBarType.nomal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speekClick,
    this.inputBoxClick,
    this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if(widget.defaultText!=null){
      setState(() {
        _controller.text=widget.defaultText;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.nomal
        ? _genNomalSearch() : _genHomeSearch();
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
            child: Row(
              children: <Widget>[
                Text("上海",
                  style: TextStyle(color: _homeFontColor(), fontSize: 14),),
                Icon(Icons.expand_more, color: _homeFontColor(), size: 22,)
              ],
            ),
          ), widget.leftButtonClick),
          Expanded(
              flex: 1,
              child: _inputBox()),
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Icon(
              Icons.comment,
              color: _homeFontColor(),
              size: 26,
            ),
          ), widget.rightButtonClick)

        ],
      ),
    );
  }

  _genNomalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget?.hideLeft ?? false ? null : Icon(
                  Icons.arrow_back_ios,
                  size: 26,
                  color: Colors.grey,

                ),
              ), widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "搜索", style: TextStyle(color: Colors.blue, fontSize: 14),),
              )
              , widget.rightButtonClick)
        ],
      ),
    );
  }

  /**
   * widget 点击事件
   */
  _wrapTap(Widget widget, void Function() callback) {
    return GestureDetector(
      child: widget,
      onTap: () {
        if (callback != null) callback();
      },
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }

  /**
   * 输入框
   */
  _inputBox() {
    Color inputBoxColor = widget.searchBarType == SearchBarType.home
        ? Colors.white
        : Color(0xffededed);
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.nomal ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 20,
            color: widget.searchBarType == SearchBarType.nomal ? Color(
                0xffa9a9a9) : Colors.blue,),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.nomal
                ? TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 11),
                  border: InputBorder.none,
                  hintText: widget.hint ?? "",
                  hintStyle: TextStyle(fontSize: 15)
              ),
            ) : _wrapTap(
                Container(
                  child: Text(widget.defaultText,
                    style: TextStyle(fontSize: 13, color: Colors.grey),),
                )
                , widget.inputBoxClick),

          ),
          !showClear
              ? _wrapTap(
              Icon(
                Icons.mic,
                size: 22,
                color: widget.searchBarType == SearchBarType.nomal
                    ? Colors.blue
                    : Colors.grey,

              ), widget.speekClick)
              : _wrapTap(
              Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey,
              ), () {
            setState(() {
              _controller.clear();
            });
            _onChanged("");
          })
          ,
        ]
        ,
      )
      ,
    );
  }

  /**
   * 输入框输入变化监听
   */
  _onChanged(String value) {
    if (value.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    print(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}