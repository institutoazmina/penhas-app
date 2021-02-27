import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Termos de Uso"),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebView(
        initialUrl: 'https://***REMOVED***/web/termos-de-uso',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
