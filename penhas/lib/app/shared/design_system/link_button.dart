import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class LinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const LinkButton({required Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed!,
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        text!,
        style: kTextStyleFeedTweetShowReply,
      ),
    );
  }
}
