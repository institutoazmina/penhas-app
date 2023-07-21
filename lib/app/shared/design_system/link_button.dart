import 'package:flutter/material.dart';

import 'text_styles.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({Key? key, this.onPressed, this.text}) : super(key: key);

  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        text!,
        style: kTextStyleFeedTweetShowReply,
      ),
    );
  }
}
