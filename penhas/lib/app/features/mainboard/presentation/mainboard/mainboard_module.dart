import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_filter_preference_data_source.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';
import 'package:penhas/app/features/feed/presentation/category_tweet/category_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/category_tweet/category_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/detail_tweet/detail_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/detail_tweet/detail_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/filter_tweet/filter_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/filter_tweet/filter_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/reply_tweet/reply_tweet_controller.dart';
import 'package:penhas/app/features/feed/presentation/reply_tweet/reply_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';

class MainboardModule extends ChildModule {
  @override
  List<Bind> get binds => [
        ...interfaceBinds,
        ...tweetBinds,
        Bind<MainboardStore>((i) => MainboardStore()),
        Bind(
          (i) => MainboardController(
            appConfigure: i.get<IAppConfiguration>(),
            mainboardStore: i.get<MainboardStore>(),
            userProfileStore: i.get<IUserProfileStore>(),
          ),
        ),
        Bind(
          (i) => FeedUseCases(
            repository: i.get<ITweetRepository>(),
            filterPreference: i.get<TweetFilterPreference>(),
            maxRows: 10,
          ),
          singleton: true,
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => MainboardPage()),
        ...tweetRoutes,
      ];

  static Inject get to => Inject<MainboardModule>.of();

  List<Router> get tweetRoutes => [
        Router(
          '/reply',
          child: (_, args) => ReplyTweetPage(),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/detail',
          child: (context, args) => DetailTweetPage(
            tweetController: Modular.get<ITweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/category',
          child: (context, args) => CategoryTweetPage(),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/tags',
          child: (context, args) => FilterTweetPage(),
          transition: TransitionType.rightToLeft,
        )
      ];

  List<Bind> get tweetBinds => [
        Bind(
          (i) => ComposeTweetController(
            useCase: i.get<FeedUseCases>(),
            mainboardStore: i.get<MainboardStore>(),
          ),
          singleton: false,
        ),
        Bind(
          (i) => ReplyTweetController(
            useCase: i.get<FeedUseCases>(),
            tweet: i.args.data,
          ),
          singleton: false,
        ),
        Bind(
          (i) => DetailTweetController(
            useCase: i.get<FeedUseCases>(),
            tweet: i.args.data,
          ),
          singleton: false,
        ),
        Bind(
          (i) => CategoryTweetController(
            useCase: i.get<TweetFilterPreference>(),
          ),
        ),
        Bind(
          (i) => FilterTweetController(
            useCase: i.get<TweetFilterPreference>(),
          ),
          singleton: true,
        ),
      ];

  List<Bind> get interfaceBinds => [
        Bind<ITweetController>(
          (i) => TweetController(useCase: i.get<FeedUseCases>()),
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
        Bind<ITweetFilterPreferenceDataSource>(
          (i) => TweetFilterPreferenceDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<ITweetFilterPreferenceRepository>(
          (i) => TweetFilterPreferenceRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<ITweetFilterPreferenceDataSource>(),
          ),
        ),
        Bind<TweetFilterPreference>(
          (i) => TweetFilterPreference(
            repository: i.get<ITweetFilterPreferenceRepository>(),
          ),
        ),
      ];
}
