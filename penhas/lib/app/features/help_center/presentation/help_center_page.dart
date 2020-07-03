import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'help_center_controller.dart';

class HelpCenterPage extends StatefulWidget {
  final String title;
  const HelpCenterPage({Key key, this.title = "HelpCenter"}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState
    extends ModularState<HelpCenterPage, HelpCenterController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: DesignSystemColors.helpCenterBackGround),
    );
  }
}
