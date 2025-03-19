import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../shared/design_system/text_styles.dart';

class TweetBody extends StatelessWidget {
  const TweetBody({
    super.key,
    required String? content,
  }) : bodyContent = content;

  final String? bodyContent;

  @override
  Widget build(BuildContext context) {
    final htmlBody = Html(
      data: bodyContent!,
      style: {
        'body': Style.fromTextStyle(kTextStyleFeedTweetBody),
        'iframe': Style(display: Display.none),
      },
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
      child: htmlBody,
    );
  }
}
