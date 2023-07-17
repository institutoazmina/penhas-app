import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/compose_tweet_fab_toggle.dart';
import '../domain/usecases/escape_manual_toggle.dart';
import '../domain/usecases/tweet_toggle_feature.dart';
import 'feed_controller.dart';
import 'feed_page.dart';
import 'stores/tweet_controller.dart';

class FeedModule extends WidgetModule {
  FeedModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => FeedController(
            useCase: i(),
            securityModeActionFeature: i(),
            composeTweetFabToggleFeature: ComposeTweetFabToggleFeature(
              escapeManualToggleFeature:
                  EscapeManualToggleFeature(modulesServices: i()),
              tweetToggleFeature: TweetToggleFeature(modulesServices: i()),
            ),
          ),
        ),
      ];

  @override
  Widget get view => FeedPage(tweetController: Modular.get<ITweetController>());
}
