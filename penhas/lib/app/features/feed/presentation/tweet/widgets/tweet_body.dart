import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'helpers/expand_child.dart';

class TweetBody extends StatelessWidget {
  final String bodyContent;
  const TweetBody({
    Key key,
    @required String content,
  })  : this.bodyContent = content,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final htmlBody = HtmlWidget(
      bodyContent,
      webViewJs: false,
      textStyle: kTextStyleFeedTweetBody,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 12.0),
      child: ExpandChild(
        expandedHint: 'menos',
        collapsedHint: 'mais',
        alignment: Alignment.topLeft,
        expandArrowStyle: ExpandArrowStyle.both,
        trimSize: 100.0,
        child: htmlBody,
      ),
    );
  }
}
