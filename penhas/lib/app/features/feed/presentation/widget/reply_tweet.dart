import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/feed_typedef.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/widget/tweet_title.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ReplyTweet extends StatelessWidget {
  final TweetEntity tweet;
  final TweetReaction onLikePressed;
  final TweetReaction onReplyPressed;
  final BuildContext _context;

  const ReplyTweet({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildMainTweet(context),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Divider(
                height: 2,
                color: DesignSystemColors.warnGrey,
              ),
            ),
            Text('Comentário', style: kTextStyleFeedTweetReplyHeader),
            SizedBox(height: 20),
            // expanded replied tweets
            ..._expandeRepliedTweeters(context),
            //
            _buildReplyAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTweet(BuildContext context) {
    return Row(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TweetTitle(
                userName: tweet.userName,
                time: tweet.createdAt,
                context: context,
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
    );
  }

  List<Widget> _expandeRepliedTweeters(BuildContext context) {
    return tweet.lastReply
        .map(
          (e) => RepliedTweet(
            repliedTweet: e,
            onLikePressed: onLikePressed,
            onReplyPressed: onReplyPressed,
            context: context,
          ),
        )
        .toList();
  }

  Widget _buildReplyAction() {
    return tweet.totalReply > 1
        ? Column(
            children: <Widget>[
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
          )
        : Container();
  }
}

class RepliedTweet extends StatelessWidget {
  final TweetEntity repliedTweet;
  final TweetReaction onLikePressed;
  final TweetReaction onReplyPressed;
  final BuildContext _context;

  const RepliedTweet({
    Key key,
    @required this.repliedTweet,
    @required this.onLikePressed,
    @required this.onReplyPressed,
    @required BuildContext context,
  })  : assert(repliedTweet != null),
        _context = context,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TweetTitle(
          userName: repliedTweet.userName,
          time: repliedTweet.createdAt,
          context: context,
        ),
        TweetBody(content: repliedTweet.content),
        TweetBottom(
          replyCount: repliedTweet.totalReply,
          likeCount: repliedTweet.totalLikes,
          isLiked: repliedTweet.meta.liked,
          onLikePressed: () => onLikePressed(repliedTweet),
          onReplyPressed: () => onReplyPressed(repliedTweet),
        ),
      ],
    );
  }
}
