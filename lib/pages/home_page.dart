import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/weight/local_nav.dart';
import 'package:flutter_trip/weight/grid_nav.dart';
import 'package:flutter_trip/model/home_model/common_model.dart';
import 'package:flutter_trip/model/home_model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model/home_model.dart';
import 'package:flutter_trip/weight/sub_nav.dart';
import 'package:flutter_trip/model/home_model/salex_box_model.dart';
import 'package:flutter_trip/weight/sales_box.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/weight/webview.dart';
import 'package:flutter_trip/weight/loading_container.dart';
import 'package:flutter_trip/weight/search_bar.dart';

const APPBAR_SCROLL_PFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;
  GridNavModel gridNav;
  double curoOpacity = 0;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    Future.delayed(Duration(milliseconds: 600), () {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
            isLoading: _loading,
            child: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: RefreshIndicator(
                        onRefresh: loadData,
                        child: NotificationListener(
                          child: _listView,
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              _scrollListener(
                                  scrollNotification.metrics.pixels);
                            }
                          },
                        )
                    )),
                _appBar
              ],
            ))
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80.0,
            decoration: BoxDecoration(
                color: Color.fromARGB(
                    (curoOpacity * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              enabled: false,
              hideLeft: false,
              searchBarType: curoOpacity > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              defaultText:SEARCH_BAR_DEFAULT_TEXT ,
            ),
          ),
        ),
        Container(
          height: curoOpacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNavWidget(localNavList),),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: GridNavWeight(gridNav)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SubNav(subNavList)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SalesBox(salesBoxModel)
        )
      ],

    );
  }

  /**
   * 加载数据
   */
  Future<Null> loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }

    return null;
  }

  /**
   * List滚动监听
   */
  _scrollListener(offset) {
    double alpha = offset / APPBAR_SCROLL_PFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      curoOpacity = alpha;
    });
  }

  /**
   * 顶部banner
   */
  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.network(bannerList[index].icon, fit: BoxFit.fill,),
            onTap: () {
              CommonModel model = bannerList[index];
              NavigatorUtil.push(context,
                  WebView(url: model.url,
                    title: model.title,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,));
            },
          );
        },

      ),

    );
  }
}
