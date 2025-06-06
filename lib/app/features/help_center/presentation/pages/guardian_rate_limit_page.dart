import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GuardianRateLimitPage extends StatelessWidget {
  const GuardianRateLimitPage({
    super.key,
    required int maxLimit,
  }) : _maxLimit = maxLimit;

  final int _maxLimit;

  TextStyle get _bodyTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.44,
      );

  TextStyle get _bodyTextBoldStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.44,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                bottom: 28.0,
                top: 12.0,
              ),
              child: Text(
                'Limite de Guardiões',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SvgPicture.asset(
                'assets/images/svg/tutorial/tutorial_guardian_01.svg',
                height: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RichText(
                text: TextSpan(
                  text: 'Você atingiu o limite ',
                  style: _bodyTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'máximo de $_maxLimit guardiões',
                      style: _bodyTextBoldStyle,
                    ),
                    TextSpan(
                      text: ', não sendo possível cadastrar um novo guardião.',
                      style: _bodyTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
