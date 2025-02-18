import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../domain/entities/tweet_badge_entity.dart';
import '../../domain/entities/tweet_entity.dart';
import '../stores/tweet_controller.dart';
import 'widgets/tweet_avatar.dart';
import 'widgets/tweet_body.dart';
import 'widgets/tweet_bottom.dart';
import 'widgets/tweet_title.dart';

class ReplyTweet extends StatelessWidget {
  const ReplyTweet({
    Key? key,
    required this.tweet,
    required this.controller,
    required BuildContext context,
  })  : _context = context,
        super(key: key);

  final TweetEntity tweet;
  final BuildContext _context;

  final ITweetController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildMainTweet(_context),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Divider(
                height: 2,
                color: DesignSystemColors.warnGrey,
              ),
            ),
            const Text('Comentário', style: kTextStyleFeedTweetReplyHeader),
            const SizedBox(height: 8),
            // expanded replied tweets
            ..._expandeRepliedTweeters(_context),
            _buildReplyAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTweet(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.detail(tweet),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: TweetAvatar(tweet: tweet),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TweetTitle(
                    tweet: tweet,
                    context: context,
                    controller: controller,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: tweet.badges.isEmpty ? 0.0 : 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCloseUser(tweet),
                      ],
                    ),
                  ),
                  TweetBody(content: tweet.content),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TweetBottom(
                      tweet: tweet,
                      controller: controller,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _expandeRepliedTweeters(BuildContext context) {
    return tweet.lastReply
        .map(
          (e) => _RepliedTweet(
            repliedTweet: e,
            parentTweet: tweet,
            controller: controller,
          ),
        )
        .toList();
  }

  Widget _buildReplyAction() {
    return tweet.totalReply > 1
        ? Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0, top: 12.0),
                child: Divider(
                  height: 2,
                  color: DesignSystemColors.warnGrey,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () => controller.detail(tweet),
                color: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                child: const Text(
                  'Ver todos os comentários',
                  style: kTextStyleFeedTweetShowReply,
                ),
              ),
            ],
          )
        : Container();
  }
}

class _RepliedTweet extends StatelessWidget {
  const _RepliedTweet({
    Key? key,
    required this.repliedTweet,
    required this.parentTweet,
    required this.controller,
  }) : super(key: key);

  final TweetEntity parentTweet;
  final TweetEntity repliedTweet;
  final ITweetController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.detail(
        parentTweet,
        commentId: repliedTweet.id,
      ),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: TweetAvatar(tweet: repliedTweet),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TweetTitle(
                    tweet: repliedTweet,
                    context: context,
                    controller: controller,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: repliedTweet.badges.isEmpty ? 0.0 : 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCloseUser(repliedTweet),
                      ],
                    ),
                  ),
                  TweetBody(content: repliedTweet.content),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TweetBottom(
                        tweet: repliedTweet, controller: controller),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCloseUser(TweetEntity tweet) {
  if (tweet.badges.isEmpty) {
    return const SizedBox.shrink();
  }
  var _emptyBadge = TweetBadgeEntity(
      code: '',
      description: '',
      imageUrl: '',
      name: '',
      popUp: 0,
      showDescription: 0,
      style: '');
  final badge = tweet.badges.firstWhere(
    (badge) => badge.style == 'inline-block',
    orElse: () => _emptyBadge,
  );
  if (badge.style.isEmpty) {
    return const SizedBox.shrink();
  }
  return UserCloseBadgeWidget(
    badgeImageUrl: badge.imageUrl,
    badgeName: badge.name,
    badgePopUp: badge.popUp,
  );
}
