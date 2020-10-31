import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_location_controller.dart';

class SupportCenterLocationPage extends StatefulWidget {
  SupportCenterLocationPage({Key key}) : super(key: key);

  @override
  _SupportCenterLocationPageState createState() =>
      _SupportCenterLocationPageState();
}

class _SupportCenterLocationPageState extends ModularState<
    SupportCenterLocationPage, SupportCenterLocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
