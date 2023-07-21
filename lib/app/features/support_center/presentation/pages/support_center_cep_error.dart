import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';

class SupportCenterCepError extends StatelessWidget {
  const SupportCenterCepError({
    Key? key,
    required String message,
  })  : _message = message,
        super(key: key);

  final String _message;

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
          ],
        ),
      ),
    );
  }
}
