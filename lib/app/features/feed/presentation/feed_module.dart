import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'feed_controller.dart';
import 'feed_page.dart';
import 'stores/tweet_controller.dart';

class FeedModule extends WidgetModule {
  FeedModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [];

  @override
  Widget get view => FeedPage(
        tweetController: Modular.get<ITweetController>(),
        feedController: Modular.get<FeedController>(),
      );
}
