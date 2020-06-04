import 'package:flutter/material.dart';

class TweetAvatar extends StatelessWidget {
  final Widget avatar;
  const TweetAvatar({
    Key key,
    @required this.avatar,
  })  : assert(avatar != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color.fromRGBO(239, 239, 239, 1.0),
      radius: 24.0,
      child: avatar,
    );
  }
}
