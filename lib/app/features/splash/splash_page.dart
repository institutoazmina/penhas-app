import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, this.title = 'Splash'}) : super(key: key);

  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.init();
    return Container(
      color: DesignSystemColors.ligthPurple,
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
