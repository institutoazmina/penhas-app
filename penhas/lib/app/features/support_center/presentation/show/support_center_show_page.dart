import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_show_controller.dart';

class SupportCenterShowPage extends StatefulWidget {
  const SupportCenterShowPage({Key key}) : super(key: key);

  @override
  _SupportCenterShowPageState createState() => _SupportCenterShowPageState();
}

class _SupportCenterShowPageState
    extends ModularState<SupportCenterShowPage, SupportCenterShowController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe do Ponto"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Container(
        color: Colors.pinkAccent,
      ),
    );
  }
}
