import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'golden_test_device_scenario.dart';

class GoldenTestWidgetApp extends StatelessWidget {
  const GoldenTestWidgetApp({
    Key? key,
    required this.device,
    required this.builder,
    this.embedInMaterialApp = false,
    this.navigatorKey,
  }) : super(key: key);

  final Device device;
  final ValueGetter<Widget> builder;
  final bool embedInMaterialApp;
  final GlobalKey? navigatorKey;

  @override
  Widget build(BuildContext context) {
    final content = DefaultAssetBundle(
      bundle: TestAssetBundle(),
      child: GoldenTestDeviceScenario(
        device: device,
        builder: builder,
      ),
    );

    return embedInMaterialApp
        ? MediaQuery(
            data: MediaQueryData(size: device.size, padding: device.safeArea),
            child: MaterialApp(
              key: navigatorKey,
              debugShowCheckedModeBanner: false,
              home: content,
            ),
          )
        : content;
  }
}
