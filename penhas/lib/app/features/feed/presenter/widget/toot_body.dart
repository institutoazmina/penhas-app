import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TootBody extends StatelessWidget {
  final String bodyContent;
  const TootBody({
    Key key,
    @required this.bodyContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      bodyContent,
      textStyle: kTextStyleFeedTootBody,
      bodyPadding: EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
    );
  }
}
