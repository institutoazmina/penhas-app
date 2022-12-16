import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({
    Key? key,
    required this.baseUrl,
  }) : super(key: key);

  final Uri baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Termos de Uso'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebView(
        initialUrl: baseUrl.resolve('web/termos-de-uso').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
