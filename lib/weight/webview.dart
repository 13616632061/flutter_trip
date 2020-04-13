import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5','m.ctrip.com/html5/you/',
];

class WebView extends StatefulWidget {

  String url;
  String statusBarColor;
  String title;
  bool hideAppBar;
  bool backForBid;


  WebView({this.url, this.statusBarColor, this.title, this.hideAppBar,
    this.backForBid = false}){
    if(url!=null&&url.contains('ctrip.com')){
      url=url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() {
    // TODO: implement createState
    return _WebViewState();
  }
}

class _WebViewState extends State<WebView> {

  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;


  @override
  void initState() {
    super.initState();

    _flutterWebviewPlugin.close();
    _onUrlChanged = _flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("onUrlChanged: url: " + url);
    });
    _onStateChanged = _flutterWebviewPlugin.onStateChanged.listen((
        WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url)) {
            if (widget.backForBid && !exiting) {
              _flutterWebviewPlugin.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        _flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
          print(error);
        });
  }

  /**
   * 是否去主页
   */
  _isToMain(String url) {
    bool contain = false;
    for (var value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColor == "ffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
   Map<String,String> headersMap=Map();
    headersMap.putIfAbsent("Content-Type", (){
      return "application/xml";
    });
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff' + statusBarColor)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              headers: headersMap,
              url: widget.url,
              userAgent: "null",
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),

            ),

          )
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backButtonColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close, color: backgroundColor, size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title ?? "",
                  style: TextStyle(color: backgroundColor, fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );
  }
}