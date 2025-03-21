import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/navigation/app_navigator.dart';

class AboutPenhasPage extends StatelessWidget {
  const AboutPenhasPage({
    super.key,
    required this.baseUrl,
  });

  final Uri baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: DesignSystemColors.white,
        elevation: 0.0,
        title: const Text('Sobre o PenhaS'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('mailto')) {
              AppNavigator.launchURL(request.url);

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }))
          ..loadRequest(baseUrl.resolve('web/faq')),
      ),
    );
  }
}
