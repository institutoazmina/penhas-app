import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({
    Key? key,
    required this.baseUrl,
  }) : super(key: key);

  final Uri baseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Política de privacidade'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: WebView(
        initialUrl: baseUrl.resolve('web/politica-privacidade').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
