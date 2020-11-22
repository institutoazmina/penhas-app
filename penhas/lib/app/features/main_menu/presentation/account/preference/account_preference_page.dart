import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class AccountPreference extends StatelessWidget {
  const AccountPreference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Preferência da conta"),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Container(color: Colors.amberAccent),
    );
  }
}
