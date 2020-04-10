import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  final String title;
  const RegistrationPage({Key key, this.title = "Registration"})
      : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState
    extends ModularState<RegistrationPage, RegistrationController> {
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
