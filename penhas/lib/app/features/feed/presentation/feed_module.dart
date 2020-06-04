import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_controller.dart';
import 'package:penhas/app/features/feed/presentation/feed_page.dart';

class FeedModule extends ModuleWidget {
  @override
  List<Bind> get binds => [
        Bind((i) => FeedController(repository: i.get<ITweetRepository>())),
        Bind((i) =>
            ComposeTweetController(repository: i.get<ITweetRepository>())),
        Bind<ITweetRepository>(
          (i) => TweetRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<ITweetDataSource>(),
          ),
        ),
        Bind<ITweetDataSource>(
          (i) => TweetDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        )
      ];

  static Inject get to => Inject<FeedModule>.of();

  @override
  Widget get view => FeedPage();
}
