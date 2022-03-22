import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutPenhasPage extends StatelessWidget {
  const AboutPenhasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Sobre o PenhaS'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebView(
        initialUrl: 'https://***REMOVED***/web/faq',
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest nav) async {
          if (nav.url.startsWith('mailto')) {
            if (await canLaunch(nav.url)) {
              launch(nav.url);
            }

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
