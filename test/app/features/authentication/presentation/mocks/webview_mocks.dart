import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewMocks {
  static late WebViewPlatform webViewPlatform;
  static late WebViewController webViewPlatformController;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    webViewPlatform = MockWebViewPlatform();
    webViewPlatformController = MockWebViewPlatformController();
  }

  static void _initFallbacks() {
    registerFallbackValue(FakeBuildContext());
  }
}

class MockWebViewPlatform extends Mock implements WebViewPlatform {}

class MockWebViewPlatformController extends Mock implements WebViewController {}

class FakeBuildContext extends Fake implements BuildContext {}

class TestPlatformWebView extends StatefulWidget {
  const TestPlatformWebView({
    Key? key,
    required this.mockWebViewPlatformController,
  }) : super(key: key);

  final WebViewController mockWebViewPlatformController;

  @override
  State<StatefulWidget> createState() => TestPlatformWebViewState();
}

class TestPlatformWebViewState extends State<TestPlatformWebView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
