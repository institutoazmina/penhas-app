import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_avatar.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_bottom.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_title.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SingleTweet extends StatelessWidget {
  final TweetEntity tweet;
  final BuildContext _context;
  final ITweetController controller;

  const SingleTweet({
    Key key,
    @required this.tweet,
    @required BuildContext context,
    @required this.controller,
  })  : assert(context != null),
        assert(controller != null),
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
                    controller: controller,
                  ),
                  TweetBody(content: tweet.content),
                  TweetBottom(tweet: tweet, controller: controller)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
