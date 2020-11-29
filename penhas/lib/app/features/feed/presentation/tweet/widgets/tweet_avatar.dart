import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

class TweetAvatar extends StatelessWidget {
  final TweetEntity tweet;
  const TweetAvatar({
    Key key,
    @required this.tweet,
  })  : assert(tweet != null),
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
