import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_list_controller.dart';

class SupportCenterListPage extends StatefulWidget {
  SupportCenterListPage({Key key}) : super(key: key);

  @override
  _SupportCenterListPageState createState() => _SupportCenterListPageState();
}

class _SupportCenterListPageState
    extends ModularState<SupportCenterListPage, SupportCenterListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Container(
        color: Colors.deepOrangeAccent,
      ),
    );
  }
}
