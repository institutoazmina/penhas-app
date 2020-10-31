import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_add_controller.dart';

class SupportCenterAddPage extends StatefulWidget {
  SupportCenterAddPage({Key key}) : super(key: key);

  @override
  _SupportCenterAddPageState createState() => _SupportCenterAddPageState();
}

class _SupportCenterAddPageState
    extends ModularState<SupportCenterAddPage, SupportCenterAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Ponto"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Container(
        color: Colors.redAccent,
      ),
    );
  }
}
