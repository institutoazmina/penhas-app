import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class SupportCenterHelpAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          'Pontos de apoio são serviços que integram toda a rede de acolhimento a mulheres vítimas de violência, como por exemplo delegacia da mulher, hospital, centro de atendimento à mulher em situação de violência, entre outros.',
          style: kTextStyleAlertDialogDescription,
        ),
      ),
      actions: [
        SizedBox(
          width: 120,
          child: FlatButton(
            color: DesignSystemColors.easterPurple,
            child: Text('Entendi', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
