import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_title.dart';
import 'package:penhas/app/features/feed/tweet_entity.dart';

class SingleTweet extends StatelessWidget {
  final TweetEntity tweet;
  final BuildContext _rootContext;

  const SingleTweet(
      {Key key, @required this.tweet, @required BuildContext rootContext})
      : assert(rootContext != null),
        this._rootContext = rootContext,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TweetAvatar(),
              flex: 1,
            ),
            SizedBox(width: 6.0),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  TweetTitle(
                    userName: tweet.userName,
                    time: tweet.time,
                    rootContext: _rootContext,
                  ),
                  TweetBody(bodyContent: tweet.content),
                  TweetBottom()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
