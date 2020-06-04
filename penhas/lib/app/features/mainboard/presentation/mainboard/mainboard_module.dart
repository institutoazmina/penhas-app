import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/reply_tweet/reply_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/reply_tweet/reply_tweet_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';

class MainboardModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => MainboardController(
            appConfigure: i.get<IAppConfiguration>(),
          ),
        ),
        Bind(
          (i) => ComposeTweetController(
            repository: i.get<ITweetRepository>(),
          ),
          singleton: false,
        ),
        Bind(
          (i) => ReplyTweetController(
              repository: i.get<ITweetRepository>(), tweet: i.args.data),
          singleton: false,
        ),
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
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => MainboardPage()),
        Router(
          '/reply',
          child: (_, args) => ReplyTweetPage(),
          transition: TransitionType.rightToLeft,
        )
      ];

  static Inject get to => Inject<MainboardModule>.of();
}
