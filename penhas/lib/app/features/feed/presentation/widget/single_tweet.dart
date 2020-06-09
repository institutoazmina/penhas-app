import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/feed_typedef.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_title.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SingleTweet extends StatelessWidget {
  final TweetEntity tweet;
  final TweetReaction onLikePressed;
  final TweetReaction onReplyPressed;
  final BuildContext _context;

  const SingleTweet({
    Key key,
    @required this.tweet,
    @required BuildContext context,
    @required this.onLikePressed,
    @required this.onReplyPressed,
  })  : assert(context != null),
        this._context = context,
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
              child: TweetAvatar(
                avatar: SvgPicture.network(
                  tweet.avatar,
                  color: DesignSystemColors.darkIndigo,
                  height: 36,
                ),
              ),
              flex: 1,
            ),
            SizedBox(width: 6.0),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TweetTitle(
                    tweet: tweet,
                    context: _context,
                  ),
                  TweetBody(content: tweet.content),
                  TweetBottom(
                    replyCount: tweet.totalReply,
                    likeCount: tweet.totalLikes,
                    isLiked: tweet.meta.liked,
                    onLikePressed: () => onLikePressed(tweet),
                    onReplyPressed: () => onReplyPressed(tweet),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
