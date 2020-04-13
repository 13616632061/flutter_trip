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

double APPBAR_SCROLL_PFFSET = 100;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MediaQuery.removePadding(context: context, removeTop: true,
          child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _scrollListener(scrollNotification.metrics.pixels);
                }
              },
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      _banner,
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNavWidget(localNavList),),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: GridNavWeight(gridNav)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: SubNav(subNavList)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: SalesBox(salesBoxModel))
                    ],

                  ),
                  Opacity(
                    opacity: curoOpacity,
                    child: Container(
                      height: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text("首页"),
                    ),
                  )
                ],
              ))
      ),
    );
  }

  /**
   * 加载数据
   */
  void loadData() async {
    HomeModel model = await HomeDao.fetch();
    setState(() {
      bannerList = model.bannerList;
      localNavList = model.localNavList;
      gridNav = model.gridNav;
      subNavList = model.subNavList;
      salesBoxModel=model.salesBox;
    });
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
              CommonModel data = bannerList[index];
//              NavigatorUtil.push(context,
//                  WebView());
            },
          );
        },

      ),

    );
  }
}
