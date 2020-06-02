import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_page.dart';

class FeedModule extends ModuleWidget {
  @override
  List<Bind> get binds => [
        Bind((i) => ComposeTweetController()),
        Bind((i) => FeedController()),
      ];

  static Inject get to => Inject<FeedModule>.of();

  @override
  Widget get view => FeedPage();
}
