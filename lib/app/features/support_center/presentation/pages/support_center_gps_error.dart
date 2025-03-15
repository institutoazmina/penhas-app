import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';

class SupportCenterGpsError extends StatelessWidget {
  const SupportCenterGpsError({
    super.key,
    required String message,
    required VoidCallback onPressed,
  })  : _message = message,
        _onPressed = onPressed;

  final String _message;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Localização inválida',
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
                Icons.location_off,
                color: DesignSystemColors.white,
                size: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _message,
                textAlign: TextAlign.center,
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
              child: TextButton.icon(
                onPressed: _onPressed,
                icon: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: DesignSystemColors.easterPurple,
                      size: 60,
                    ),
                  ],
                ),
                label: const SizedBox(),
              ),
            ),
            const Text(
              'Nova localização',
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
    );
  }
}
