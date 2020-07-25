import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GuardianRateLimitPage extends StatelessWidget {
  final int _maxLimit;

  const GuardianRateLimitPage({
    Key key,
    @required int maxLimit,
  })  : this._maxLimit = maxLimit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
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
                padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                child: Text(
                  'Você atingiu o limite máximo de $_maxLimit guardiões, não sendo possível cadastrar um novo guardião.',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    letterSpacing: 0.44,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
