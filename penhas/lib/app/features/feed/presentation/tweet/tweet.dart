import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/tweet/reply_tweet.dart';
import 'package:penhas/app/features/feed/presentation/tweet/single_tweet.dart';

class Tweet extends StatelessWidget {
  final TweetEntity model;
  final ITweetController controller;
  const Tweet({
    Key key,
    @required this.model,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasRepliedTweet =
        model.lastReply != null && model.lastReply.isNotEmpty;
    return hasRepliedTweet
        ? ReplyTweet(context: context, tweet: model, controller: controller)
        : SingleTweet(context: context, tweet: model, controller: controller);
  }
}
