import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/modules_sevices.dart';
import '../../escape_manual/domain/escape_manual_toggle.dart';
import '../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../domain/usecases/compose_tweet_fab_toggle.dart';
import '../domain/usecases/feed_use_cases.dart';
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
  Widget get view => FeedPage(
        tweetController: Modular.get<ITweetController>(),
        feedController: FeedController(
            composeTweetFabToggleFeature: ComposeTweetFabToggleFeature(
                escapeManualToggleFeature: EscapeManualToggleFeature(
                    modulesServices: Modular.get<IAppModulesServices>()),
                tweetToggleFeature: TweetToggleFeature(
                    modulesServices: Modular.get<IAppModulesServices>())),
            securityModeActionFeature: Modular.get<SecurityModeActionFeature>(),
            useCase: Modular.get<FeedUseCases>()),
      );
}
