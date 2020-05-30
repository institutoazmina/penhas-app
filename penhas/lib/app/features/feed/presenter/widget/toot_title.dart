import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TootTitle extends StatelessWidget {
  final String userName;
  final String tootTime;
  const TootTitle({
    Key key,
    @required this.userName,
    @required this.tootTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(userName, style: kTextStyleFeedTootTitle), flex: 2),
          Text(tootTime, style: kTextStyleFeedTootTime),
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
