import 'package:flutter/material.dart';

import '../../shared/design_system/colors.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, this.title = 'Splash', required this.controller})
      : super(key: key);

  final String title;
  final SplashController controller;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController get _controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    _controller.init();
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
