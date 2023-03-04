import 'package:flutter/material.dart';

import '../../domain/entities/tweet_entity.dart';
import '../stores/tweet_controller.dart';
import 'reply_tweet.dart';
import 'single_tweet.dart';

class Tweet extends StatelessWidget {
  const Tweet({
    Key? key,
    required this.model,
    required this.controller,
  }) : super(key: key);

  final TweetEntity model;
  final ITweetController controller;

  @override
  Widget build(BuildContext context) {
    final hasRepliedTweet = model.lastReply.isNotEmpty;
    return hasRepliedTweet
        ? ReplyTweet(context: context, tweet: model, controller: controller)
        : SingleTweet(context: context, tweet: model, controller: controller);
  }
}
