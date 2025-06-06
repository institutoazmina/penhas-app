import 'package:flutter/material.dart';

import 'text_styles.dart';
import 'widgets/buttons/penhas_button.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, this.onPressed, this.text});

  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return PenhasButton.text(
      onPressed: onPressed,
      child: Text(
        text!,
        style: kTextStyleFeedTweetShowReply,
      ),
    );
  }
}
