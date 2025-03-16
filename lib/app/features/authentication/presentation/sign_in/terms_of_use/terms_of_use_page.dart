import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../shared/design_system/colors.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({
    super.key,
    required this.baseUrl,
  });

  final Uri baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Termos de Uso'),
        backgroundColor: DesignSystemColors.easterPurple,
        foregroundColor: DesignSystemColors.white,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(baseUrl.resolve('web/termos-de-uso')),
      ),
    );
  }
}
