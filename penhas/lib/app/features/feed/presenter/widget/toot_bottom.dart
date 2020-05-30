import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TootBottom extends StatelessWidget {
  const TootBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border,
                size: 30.0, color: DesignSystemColors.blueyGrey),
            onPressed: () {},
          ),
          Text('12', style: kTextStyleFeedTootTime),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline,
                size: 30.0, color: DesignSystemColors.blueyGrey),
            onPressed: () {},
          ),
          Text('12', style: kTextStyleFeedTootTime),
        ],
      ),
    );
  }
}
