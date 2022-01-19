import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_preferences_use_case.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_channel_usecase.dart';
import 'package:penhas/app/features/chat/presentation/chat/chat_channel_controller.dart';
import 'package:penhas/app/features/chat/presentation/chat/chat_channel_page.dart';
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
import 'package:penhas/app/features/feed/presentation/routing_perfil_chat/feed_routing_perfil_chat_controller.dart';
import 'package:penhas/app/features/feed/presentation/routing_perfil_chat/feed_routing_perfil_chat_page.dart';
import 'package:penhas/app/features/feed/presentation/stores/tweet_controller.dart';
import 'package:penhas/app/features/filters/domain/presentation/filter_module.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_page.dart';
import 'package:penhas/app/features/help_center/presentation/guardians/guardians_controller.dart';
import 'package:penhas/app/features/help_center/presentation/guardians/guardians_page.dart';
import 'package:penhas/app/features/help_center/presentation/new_guardian/new_guardian_controller.dart';
import 'package:penhas/app/features/help_center/presentation/new_guardian/new_guardian_page.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_record_page.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';
import 'package:penhas/app/features/main_menu/presentation/account/delete/account_delete_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/delete/account_delete_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/profile_edit_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/profile_skill_module.dart';
import 'package:penhas/app/features/main_menu/presentation/account/preference/account_preference_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/preference/account_preference_page.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/about_penhas_page.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';
import 'package:penhas/app/features/notification/presentation/notification_controller.dart';
import 'package:penhas/app/features/notification/presentation/notification_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_page.dart';
import 'package:penhas/app/features/support_center/presentation/list/support_center_list_page.dart';
import 'package:penhas/app/features/support_center/presentation/location/support_center_location_page.dart';
import 'package:penhas/app/features/support_center/presentation/show/support_center_show_page.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_module.dart';

class MainboardModule extends Module {
  @override
  List<Bind> get binds => [
        ...interfaceBinds,
        ...drawerBinds,
        ...tweetBinds,
        ...helpCenterBinds,
        ...audioServicesBinds,
        ...notificationBinds,
        ...menuBind,
        ...chatBinds,
        Bind.factory<MainboardStore>(
          (i) => MainboardStore(
            modulesServices: i.get<IAppModulesServices>(),
            initialPage: i.args?.data == null
                ? const MainboardState.feed()
                // ignore: avoid_dynamic_calls
                : MainboardState.fromString(i.args?.data['page']),
          ),
        ),
        Bind.factory(
          (i) => MainboardController(
            mainboardStore: i.get<MainboardStore>(),
            inactivityLogoutUseCase: i.get<InactivityLogoutUseCase>(),
            modulesServices: i.get<IAppModulesServices>(),
            notification: i.get<INotificationRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => FeedUseCases(
            repository: i.get<ITweetRepository>(),
            filterPreference: i.get<TweetFilterPreference>(),
          ),
        ),
        Bind.factory<IFilterSkillRepository>(
          (i) => FilterSkillRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const MainboardPage(),
        ),
        ...tweetRoutes,
        ...helpCenter,
        ...supportCenter,
        ...users,
        ...filters,
        ...chat,
        ...notificationCenter,
        ...menuRouters,
      ];

  List<ModularRoute> get tweetRoutes => [
        ChildRoute(
          '/reply',
          child: (_, args) => const ReplyTweetPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tweet/:id',
          child: (context, args) => DetailTweetPage(
            tweetController: Modular.get<ITweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/category',
          child: (context, args) => const CategoryTweetPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tags',
          child: (context, args) => const FilterTweetPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tweet/perfil_chat',
          child: (context, args) => const FeedRoutingPerfilChatPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<ModularRoute> get helpCenter => [
        ChildRoute(
          '/helpcenter/newGuardian',
          child: (context, args) => const NewGuardianPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/guardians',
          child: (context, args) => const GuardiansPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/audios',
          child: (context, args) => const AudiosPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/audioRecord',
          child: (context, args) => const AudioRecordPage(),
          transition: TransitionType.rightToLeft,
        )
      ];

  List<ModularRoute> get supportCenter => [
        ChildRoute(
          '/supportcenter/add',
          child: (context, args) => const SupportCenterAddPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/supportcenter/list',
          child: (context, args) => const SupportCenterListPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/supportcenter/location',
          child: (context, args) => const SupportCenterLocationPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/supportcenter/show',
          child: (context, args) => const SupportCenterShowPage(),
          transition: TransitionType.rightToLeft,
        )
      ];

  List<ModularRoute> get notificationCenter => [
        ChildRoute(
          '/notification',
          child: (context, args) => const NotificationPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<Bind> get notificationBinds => [
        Bind.factory<INotificationRepository>(
          (i) => NotificationRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory(
          (i) => NotificationController(
            notificationRepository: i.get<INotificationRepository>(),
          ),
        ),
      ];

  List<ModularRoute> get menuRouters => [
        ChildRoute(
          '/menu/about',
          child: (context, args) => const AboutPenhasPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/profile_edit',
          child: (context, args) => const ProfileEditPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/account_preference',
          child: (context, args) => const AccountPreferencePage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/account_delete',
          child: (context, args) => const AccountDeletePage(),
          transition: TransitionType.rightToLeft,
        ),
        ModuleRoute(
          '/menu/profile_edit/skills',
          module: ProfileSkillModule(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<Bind> get menuBind => [
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory(
          (i) => ProfileEditController(
            appStateUseCase: i.get<AppStateUseCase>(),
            skillRepository: i.get<IFilterSkillRepository>(),
            securityModeActionFeature: i.get<SecurityModeActionFeature>(),
          ),
        ),
        Bind.factory(
          (i) => AccountDeleteController(
            appConfiguration: i.get<IAppConfiguration>(),
            profileRepository: i.get<IUserProfileRepository>(),
          ),
        ),
        Bind.factory(
          (i) => AccountPreferenceController(
            profileRepository: i.get<IUserProfileRepository>(),
          ),
        ),
      ];

  List<ModularRoute> get users => [
        ModuleRoute(
          '/users',
          module: UserProfileModule(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<ModularRoute> get filters => [
        ModuleRoute(
          '/filters',
          module: FilterModule(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<ModularRoute> get chat => [
        ChildRoute(
          '/chat/:token',
          child: (context, args) => const ChatPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/chat_from_feed',
          child: (context, args) => const ChatPage(),
          transition: TransitionType.noTransition,
        ),
      ];

  List<Bind> get chatBinds => [
        Bind.factory<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory(
          (i) => ChatChannelController(
            useCase: i.get<ChatChannelUseCase>(),
          ),
        ),
      ];

  List<Bind> get audioServicesBinds => [
        Bind.factory<IAudioRecordServices>(
          (i) => AudioRecordServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
        ),
        Bind.factory<IAudioPlayServices>(
          (i) => AudioPlayServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
        )
      ];

  List<Bind> get tweetBinds => [
        Bind.factory(
          (i) => ComposeTweetController(
            useCase: i.get<FeedUseCases>(),
            mainboardStore: i.get<MainboardStore>(),
          ),
        ),
        Bind.factory(
          (i) => ReplyTweetController(
            useCase: i.get<FeedUseCases>(),
            tweet: i.args?.data,
          ),
        ),
        Bind.factory(
          (i) => DetailTweetController(
            useCase: i.get<FeedUseCases>(),
            tweetId: i.args?.params['id'],
            tweet: i.args?.data,
          ),
        ),
        Bind.factory(
          (i) => CategoryTweetController(
            useCase: i.get<TweetFilterPreference>(),
          ),
        ),
        Bind.factory(
          (i) => FilterTweetController(
            useCase: i.get<TweetFilterPreference>(),
          ),
        ),
        Bind.factory<IUsersRepository>(
          (i) => UsersRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => FeedRoutingPerfilChatController(
            usersRepository: i.get<IUsersRepository>(),
            channelRepository: i.get<IChatChannelRepository>(),
            routerType: i.args?.data,
          ),
        )
      ];

  List<Bind> get interfaceBinds => [
        Bind.factory<ITweetController>(
          (i) => TweetController(useCase: i.get<FeedUseCases>()),
        ),
        Bind.factory<ITweetRepository>(
          (i) => TweetRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<ITweetDataSource>(),
          ),
        ),
        Bind.factory<ITweetDataSource>(
          (i) => TweetDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<ITweetFilterPreferenceDataSource>(
          (i) => TweetFilterPreferenceDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<ITweetFilterPreferenceRepository>(
          (i) => TweetFilterPreferenceRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<ITweetFilterPreferenceDataSource>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => TweetFilterPreference(
            repository: i.get<ITweetFilterPreferenceRepository>(),
          ),
        ),
        Bind.factory<ILocationServices>(
          (i) => LocationServices(),
        ),
      ];

  List<Bind> get drawerBinds => [
        Bind.factory(
          (i) => PenhasDrawerController(
            appConfigure: i.get<IAppConfiguration>(),
            userProfile: i.get<UserProfile>(),
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<UserProfile>(
          (i) => UserProfile(
            repository: i.get<IUserProfileRepository>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            appStateUseCase: i.get<AppStateUseCase>(),
          ),
        ),
        Bind.factory<AppStateUseCase>(
          (i) => AppStateUseCase(
            appStateRepository: i.get<IAppStateRepository>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            appConfiguration: i.get<IAppConfiguration>(),
            appModulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<InactivityLogoutUseCase>(
          (i) => InactivityLogoutUseCase(
            appPreferencesStore: i.get<LocalStore<AppPreferencesEntity>>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
          ),
        ),
        Bind.factory<IAppStateRepository>(
          (i) => AppStateRepository(
            networkInfo: i.get<INetworkInfo>(),
            dataSource: i.get<IAppStateDataSource>(),
          ),
        ),
        Bind.factory<IAppStateDataSource>(
          (i) => AppStateDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<StealthModeTutorialPageController>(
          (i) => StealthModeTutorialPageController(
            locationService: i.get<ILocationServices>(),
          ),
        ),
      ];

  List<Bind> get helpCenterBinds => [
        Bind.factory(
          (i) => NewGuardianController(
            guardianRepository: i.get<IGuardianRepository>(),
            locationService: i.get<ILocationServices>(),
          ),
        ),
        Bind.factory(
          (i) => GuardiansController(
            guardianRepository: i.get<IGuardianRepository>(),
          ),
        ),
        Bind.factory(
          (i) => AudiosController(
            audiosRepository: i.get<IAudiosRepository>(),
            audioPlayServices: i.get<IAudioPlayServices>(),
          ),
        ),
        Bind.factory(
          (i) => AudiosRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory<IGuardianRepository>(
          (i) => GuardianRepository(
            dataSource: i.get<IGuardianDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind.factory<IGuardianDataSource>(
          (i) => GuardianDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
      ];
}
