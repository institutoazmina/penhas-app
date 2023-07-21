import 'package:flutter/material.dart';

import '../../domain/entities/tweet_entity.dart';
import '../stores/tweet_controller.dart';
import 'widgets/tweet_avatar.dart';
import 'widgets/tweet_body.dart';
import 'widgets/tweet_bottom.dart';
import 'widgets/tweet_title.dart';

class SingleTweet extends StatelessWidget {
  const SingleTweet({
    Key? key,
    required this.tweet,
    required BuildContext context,
    required this.controller,
  })  : _context = context,
        super(key: key);

  final TweetEntity tweet;
  final BuildContext _context;
  final ITweetController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.detail(tweet),
      child: Container(
        decoration: const BoxDecoration(
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
                child: TweetAvatar(tweet: tweet),
              ),
              const SizedBox(width: 6.0),
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
      ),
    );
  }
}
