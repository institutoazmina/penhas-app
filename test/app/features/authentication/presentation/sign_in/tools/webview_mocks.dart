import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MockWebViewPlatform extends Mock implements WebViewPlatform {}

class MockWebViewPlatformController extends Mock
    implements WebViewPlatformController {}

class FakeBuildContext extends Fake implements BuildContext {}

class FakeCreationParams extends Fake implements CreationParams {}

class FakeWebViewPlatformCallbacksHandler extends Fake
    implements WebViewPlatformCallbacksHandler {}

class FakeJavascriptChannelRegistry extends Fake
    implements JavascriptChannelRegistry {}

class FakeWebSettings extends Fake implements WebSettings {}

class MockWebViewCookieManagerPlatform extends WebViewCookieManagerPlatform {
  List<WebViewCookie> setCookieCalls = <WebViewCookie>[];

  @override
  Future<bool> clearCookies() async => true;

  @override
  Future<void> setCookie(WebViewCookie cookie) async {
    setCookieCalls.add(cookie);
  }

  void reset() {
    setCookieCalls = <WebViewCookie>[];
  }
}

class TestPlatformWebView extends StatefulWidget {
  const TestPlatformWebView({
    Key? key,
    required this.mockWebViewPlatformController,
    this.onWebViewPlatformCreated,
  }) : super(key: key);

  final MockWebViewPlatformController mockWebViewPlatformController;
  final WebViewPlatformCreatedCallback? onWebViewPlatformCreated;

  @override
  State<StatefulWidget> createState() => TestPlatformWebViewState();
}

class TestPlatformWebViewState extends State<TestPlatformWebView> {
  @override
  void initState() {
    super.initState();
    final WebViewPlatformCreatedCallback? onWebViewPlatformCreated =
        widget.onWebViewPlatformCreated;
    if (onWebViewPlatformCreated != null) {
      onWebViewPlatformCreated(widget.mockWebViewPlatformController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
