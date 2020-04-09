import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

double APPBAR_SCROLL_PFFSET=100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List imageList = [
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3084018652,54808508&fm=26&gp=0.jpg",
    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2826405284,472233312&fm=26&gp=0.jpg",
  ];
  double curoOpacity = 0;

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
                      Container(
                        height: 160.0,
                        child: Swiper(
                          itemCount: imageList.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
//                  return Image(image: new CachedNetworkImageProvider(
//                  imageList[index]), fit: BoxFit.fill,);
                            return Image.network(
                              imageList[index], fit: BoxFit.fill,);
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      ListTile(
                        title: Text("更多", style: TextStyle(height: 800),),
                      )
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
   * List滚动监听
   */
  _scrollListener(offset) {
    double alpha=offset/APPBAR_SCROLL_PFFSET;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }
    setState(() {
      curoOpacity=alpha;
    });
  }

}
