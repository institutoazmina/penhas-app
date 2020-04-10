import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'password_recovery_controller.dart';

class PasswordRecoveryPage extends StatefulWidget {
  final String title;
  const PasswordRecoveryPage({Key key, this.title = "PasswordRecovery"})
      : super(key: key);

  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState
    extends ModularState<PasswordRecoveryPage, PasswordRecoveryController> {
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
