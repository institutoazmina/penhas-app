import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../domain/usecases/feed_use_cases.dart';
import 'feed_controller.dart';
import 'feed_page.dart';
import 'stores/tweet_controller.dart';

class FeedModule extends WidgetModule {
  FeedModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => FeedController(
            useCase: i.get<FeedUseCases>(),
            securityModeActionFeature: i.get<SecurityModeActionFeature>(),
          ),
        ),
      ];

  @override
  Widget get view => FeedPage(tweetController: Modular.get<ITweetController>());
}
