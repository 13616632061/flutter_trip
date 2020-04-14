import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  Widget child;
  bool isLoading;
  bool cover;

  LoadingContainer(
      {@required this.child, @required this.isLoading, this.cover = false});

  @override
  Widget build(BuildContext context) {
    return !cover ? !isLoading ? child : _loadingView :
    Stack(children: <Widget>[child, isLoading ? _loadingView : Container()],);
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}