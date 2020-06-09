import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_page.dart';

class FeedModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => FeedController(useCase: i.get<FeedUseCases>()),
        ),
      ];

  static Inject get to => Inject<FeedModule>.of();

  @override
  Widget get view => FeedPage();
}
