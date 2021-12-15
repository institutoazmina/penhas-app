import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class LoginButton extends StatefulWidget {
  final void Function() onChanged;

  // final void Function() _onChanged;

  const LoginButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: widget.onChanged,
          elevation: 0,
          color: DesignSystemColors.ligthPurple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Text(
            'Entrar',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
