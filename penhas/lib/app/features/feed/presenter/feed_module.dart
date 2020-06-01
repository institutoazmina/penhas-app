import 'package:penhas/app/features/feed/presenter/compose_toot/compose_toot_controller.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/features/feed/presenter/feed_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/feed/presenter/feed_page.dart';

class FeedModule extends ModuleWidget {
  @override
  List<Bind> get binds => [
        Bind((i) => ComposeTootController()),
        Bind((i) => FeedController()),
      ];

  static Inject get to => Inject<FeedModule>.of();

  @override
  Widget get view => FeedPage();
}
