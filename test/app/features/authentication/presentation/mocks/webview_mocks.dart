import 'package:flutter/widgets.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

/// Fake implementation of WebViewPlatform for testing.
class FakeWebViewPlatform extends WebViewPlatform {
  /// The last controller created by this platform, useful for asserting
  /// configuration values (e.g. JavaScriptMode) set during widget build.
  FakeWebViewController? lastController;

  @override
  PlatformWebViewController createPlatformWebViewController(
      PlatformWebViewControllerCreationParams params) {
    lastController = FakeWebViewController(params);
    return lastController!;
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams params) {
    return FakeWebViewWidget(params);
  }
}

/// Fake WebView Controller Implementation
class FakeWebViewController extends PlatformWebViewController {
  FakeWebViewController(PlatformWebViewControllerCreationParams params)
      : super.implementation(params);

  /// Captures the last JavaScriptMode set, enabling test assertions.
  JavaScriptMode? lastJavaScriptMode;

  @override
  Future<void> loadRequest(LoadRequestParams params) async {
    // Mock the behavior when loadRequest is called.
    // In a real scenario, this would trigger the webview to load a URL, but here we mock it.
    print('Mock loadRequest called with URL: ${params.uri}');
    // You can simulate additional behaviors here, like sending success or failure callbacks.
  }

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {
    lastJavaScriptMode = javaScriptMode;
  }

  @override
  Future<void> clearCache() async {
    // Simulate clearing cache.
  }

  @override
  Future<void> enableZoom(bool enabled) async {
    // Simulate enabling/disabling zoom.
  }

  @override
  Future<void> setPlatformNavigationDelegate(
      PlatformNavigationDelegate handler) async {
    // Simulate setting navigation delegate (needed by AboutPenhasPage).
  }
}

/// Fake WebView Widget
class FakeWebViewWidget extends PlatformWebViewWidget {
  FakeWebViewWidget(PlatformWebViewWidgetCreationParams params)
      : super.implementation(params);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Return an empty widget for testing.
  }
}
