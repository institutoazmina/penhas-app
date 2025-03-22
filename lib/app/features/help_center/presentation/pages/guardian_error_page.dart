import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../shared/design_system/widgets/buttons/styles/text_button_style.dart';

class GuardianErrorPage extends StatelessWidget {
  const GuardianErrorPage({
    super.key,
    required String message,
    required VoidCallback onPressed,
  })  : _message = message,
        _onPressed = onPressed;

  final String _message;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 28.0,
                  top: 12.0,
                ),
                child: Text(
                  'Ocorreu um erro!',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Icon(
                  Icons.warning,
                  color: DesignSystemColors.white,
                  size: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  _message,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    letterSpacing: 0.44,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: PenhasButton(
                  onPressed: _onPressed,
                  style: TextButtonStyle(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.loop,
                        color: DesignSystemColors.easterPurple,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                'Tentar novamente',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
