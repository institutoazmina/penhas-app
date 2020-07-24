import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/help_center/presentation/new_guardian/new_guardian_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class NewGuardianPage extends StatefulWidget {
  final String title;
  const NewGuardianPage({Key key, this.title = "NewGuardian"})
      : super(key: key);

  @override
  _NewGuardianPageState createState() => _NewGuardianPageState();
}

class _NewGuardianPageState
    extends ModularState<NewGuardianPage, NewGuardianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Guardião'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
