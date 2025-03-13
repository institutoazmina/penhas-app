import 'package:flutter/material.dart';

class TweetBody extends StatelessWidget {
  const TweetBody({
    super.key,
    required String? content,
  }) : bodyContent = content;

  final String? bodyContent;

  @override
  Widget build(BuildContext context) {
    // TODO: final htmlBody = HtmlWidget(
    //   bodyContent!,
    //   textStyle: kTextStyleFeedTweetBody,
    //   factoryBuilder: () => DisabledWebViewJsWidgetFactory(),
    // );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
      child: SizedBox.shrink(),
    );
  }
}

// class DisabledWebViewJsWidgetFactory extends WidgetFactory {
//   @override
//   bool get webViewJs => false;
// }
