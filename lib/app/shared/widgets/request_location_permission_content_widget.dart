import 'package:flutter/material.dart';

import '../design_system/text_styles.dart';

class RequestLocationPermissionContentWidget extends StatelessWidget {
  const RequestLocationPermissionContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Quando um guardião é cadastrado, recomendamos que o ',
        style: kTextStyleAlertDialogDescription,
        children: [
          TextSpan(
            text: 'PenhaS ',
            style: kTextStyleAlertDialogDescriptionBold,
          ),
          TextSpan(
            text:
                'seja autorizado a obter a sua localização. Esta informação será enviada para o Guardião quando o botão ',
            style: kTextStyleAlertDialogDescription,
          ),
          TextSpan(
            text: 'Alertar Guardiões ',
            style: kTextStyleAlertDialogDescriptionBold,
          ),
          TextSpan(
            text: 'for acionado.',
            style: kTextStyleAlertDialogDescription,
          ),
        ],
      ),
    );
  }
}
