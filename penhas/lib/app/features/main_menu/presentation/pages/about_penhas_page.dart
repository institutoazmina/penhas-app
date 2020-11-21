import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutPenhasPage extends StatelessWidget {
  const AboutPenhasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Sobre o PenhaS"),
          backgroundColor: DesignSystemColors.easterPurple,
        ),
        body: WebView(
          initialUrl: 'https://www.mdb.org.br/',
        ));
  }
}
