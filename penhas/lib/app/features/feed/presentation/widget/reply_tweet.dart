import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_title.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ReplyTweet extends StatelessWidget {
  final TweetEntity tweet;
  const ReplyTweet({
    Key key,
    @required this.tweet,
  }) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
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
                          userName: tweet.userName, time: tweet.createdAt),
                      TweetBody(bodyContent: tweet.content),
                      TweetBottom()
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Divider(
                height: 2,
                color: DesignSystemColors.warnGrey,
              ),
            ),
            Text('Comentário', style: kTextStyleFeedTweetReplyHeader),
            SizedBox(height: 20),
            TweetTitle(
                userName: tweet.lastReplay.userName,
                time: tweet.lastReplay.createdAt),
            TweetBody(bodyContent: tweet.lastReplay.content),
            TweetBottom(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Divider(
                height: 2,
                color: DesignSystemColors.warnGrey,
              ),
            ),
            RaisedButton(
              onPressed: () {},
              elevation: 0,
              color: Colors.transparent,
              child: Text(
                "Ver todos os comentários",
                style: kTextStyleFeedTweetShowReply,
              ),
            )
          ],
        ),
      ),
    );
  }
}
