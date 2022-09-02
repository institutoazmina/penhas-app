import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterGeneralError extends StatelessWidget {
  const SupportCenterGeneralError({
    Key? key,
    required String message,
    required VoidCallback onPressed,
  })  : _message = message,
        _onPressed = onPressed,
        super(key: key);

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
                child: FlatButton.icon(
                  onPressed: _onPressed,
                  icon: const Icon(
                    Icons.loop,
                    color: DesignSystemColors.easterPurple,
                    size: 60,
                  ),
                  label: Container(),
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
