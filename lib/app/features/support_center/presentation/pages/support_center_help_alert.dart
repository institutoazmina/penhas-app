import 'package:flutter/material.dart';

import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';

class SupportCenterHelpAlert extends StatelessWidget {
  const SupportCenterHelpAlert({Key? key}) : super(key: key);

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
          child: PenhasButton.filled(
            child: const Text('Entendi', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
