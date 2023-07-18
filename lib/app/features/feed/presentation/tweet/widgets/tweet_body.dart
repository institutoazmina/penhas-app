import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/widgets/no_webview_js_wiget_factory.dart';

class TweetBody extends StatelessWidget {
  const TweetBody({
    Key? key,
    required String? content,
  })  : bodyContent = content,
        super(key: key);

  final String? bodyContent;

  @override
  Widget build(BuildContext context) {
    final htmlBody = HtmlWidget(
      bodyContent!,
      textStyle: kTextStyleFeedTweetBody,
      factoryBuilder: () => NoWebviewJsWidgetFactory(),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 12.0),
      child: htmlBody,
    );
  }
}
