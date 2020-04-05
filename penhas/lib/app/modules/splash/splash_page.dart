import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = autorun((_) {
      controller.increment();
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      )),
      color: DesignSystemColors.LigthPurple,
    );
  }
}
