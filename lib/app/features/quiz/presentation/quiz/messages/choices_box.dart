import 'package:flutter/material.dart';

import '../../../../../shared/design_system/button_shape.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';

class ChoicesBox extends StatelessWidget {
  const ChoicesBox({
    Key? key,
    required this.children,
    this.onSend,
  }) : super(key: key);

  final List<Widget> children;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: DesignSystemColors.blueyGrey,
            offset: Offset(0.0, 2.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          child: Column(
            children: <Widget>[
              ...children,
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onSend,
                child: const Text(
                  'ENVIAR',
                  style: kTextStyleDefaultFilledButtonLabel,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignSystemColors.ligthPurple,
                  elevation: 0,
                  shape: kButtonShapeFilled,
                  minimumSize: const Size(double.infinity, 52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
