import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key key, this.title = "Feed"}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
