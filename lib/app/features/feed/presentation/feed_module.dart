import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_page.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';

class FeedModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => FeedController(
            useCase: i.get<FeedUseCases>(),
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
      ];

  @override
  Widget get view => FeedPage(tweetController: Modular.get<ITweetController>());
}
