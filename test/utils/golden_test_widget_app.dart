import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:penhas/app/shared/design_system/theme.dart';

class GoldenTestWidgetApp extends StatelessWidget {
  const GoldenTestWidgetApp({
    Key? key,
    required this.device,
    required this.builder,
    this.transitionBuilder,
  }) : super(key: key);

  final Device device;
  final ValueGetter<Widget> builder;
  final TransitionBuilder? transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: TestAssetBundle(),
      child: GoldenTestScenario(
        name: device.name,
        child: ClipRect(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: device.size,
              padding: device.safeArea,
              platformBrightness: device.brightness,
              devicePixelRatio: device.devicePixelRatio,
              textScaler: TextScaler.linear(device.textScale),
            ),
            child: SizedBox(
              height: device.size.height,
              width: device.size.width,
              child: MaterialApp(
                theme: AppTheme.of(context),
                builder: transitionBuilder,
                home: builder(),
                debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
