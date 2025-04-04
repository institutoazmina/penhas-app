import 'package:flutter/material.dart';

import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
    required this.onChanged,
  });

  final void Function() onChanged;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: PenhasButton.roundedFilled(
        onPressed: widget.onChanged,
        child: const Text(
          'Entrar',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
