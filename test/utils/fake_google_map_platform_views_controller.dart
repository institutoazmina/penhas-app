import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FakeGoogleMapPlatformViewsController {
  FakePlatformGoogleMap? lastCreatedView;

  Future<dynamic> fakePlatformViewsMethodHandler(MethodCall call) {
    switch (call.method) {
      case 'create':
        final Map<dynamic, dynamic> args =
            call.arguments as Map<dynamic, dynamic>;
        final Map<dynamic, dynamic> params =
            _decodeParams(args['params'] as Uint8List)!;
        lastCreatedView = FakePlatformGoogleMap(args['id'] as int, params);
        return Future<int>.sync(() => 1);
      default:
        return Future<void>.sync(() {});
    }
  }

  void reset() {
    lastCreatedView = null;
  }
}

Map<dynamic, dynamic>? _decodeParams(Uint8List paramsMessage) {
  final ByteBuffer buffer = paramsMessage.buffer;
  final ByteData messageBytes = buffer.asByteData(
    paramsMessage.offsetInBytes,
    paramsMessage.lengthInBytes,
  );
  return const StandardMessageCodec().decodeMessage(messageBytes)
      as Map<dynamic, dynamic>?;
}

class FakePlatformGoogleMap {
  FakePlatformGoogleMap(int id, Map<dynamic, dynamic> params)
      : cameraPosition =
            CameraPosition.fromMap(params['initialCameraPosition']),
        channel = MethodChannel('plugins.flutter.io/google_maps_$id') {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, onMethodCall);
  }

  MethodChannel channel;
  CameraPosition? cameraPosition;

  Future<dynamic> onMethodCall(MethodCall call) {
    return Future<void>.sync(() {});
  }
}
