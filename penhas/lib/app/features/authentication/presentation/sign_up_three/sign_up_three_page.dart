import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'sign_up_three_controller.dart';

class SignUpThreePage extends StatefulWidget {
  final String title;
  const SignUpThreePage({Key key, this.title = "SignUpThree"})
      : super(key: key);

  @override
  _SignUpThreePageState createState() => _SignUpThreePageState();
}

class _SignUpThreePageState
    extends ModularState<SignUpThreePage, SignUpThreeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
