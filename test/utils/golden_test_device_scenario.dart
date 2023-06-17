import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class GoldenTestDeviceScenario extends StatelessWidget {
  const GoldenTestDeviceScenario({
    Key? key,
    required this.device,
    required this.builder,
  }) : super(key: key);

  final Device device;
  final ValueGetter<Widget> builder;

  @override
  Widget build(BuildContext context) {
    return GoldenTestScenario(
      name: device.name,
      child: ClipRect(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: device.size,
            padding: device.safeArea,
            platformBrightness: device.brightness,
            devicePixelRatio: device.devicePixelRatio,
            textScaleFactor: device.textScale,
          ),
          child: SizedBox(
            height: device.size.height,
            width: device.size.width,
            child: builder(),
          ),
        ),
      ),
    );
  }
}
