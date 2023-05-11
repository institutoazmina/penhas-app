import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/navigation/app_navigator.dart';

class AboutPenhasPage extends StatelessWidget {
  const AboutPenhasPage({
    Key? key,
    required this.baseUrl,
  }) : super(key: key);

  final Uri baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Sobre o PenhaS'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebView(
        initialUrl: baseUrl.resolve('web/faq').toString(),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest nav) async {
          if (nav.url.startsWith('mailto')) {
            AppNavigator.launchURL(nav.url);

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
