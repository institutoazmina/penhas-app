import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/help_center/presentation/guardians/guardians_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class GuardiansPage extends StatefulWidget {
  final String title;
  const GuardiansPage({Key key, this.title = "Guardians"}) : super(key: key);

  @override
  _GuardiansPageState createState() => _GuardiansPageState();
}

class _GuardiansPageState
    extends ModularState<GuardiansPage, GuardiansController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Guardiões'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
