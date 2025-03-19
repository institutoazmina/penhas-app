import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/managers/app_configuration.dart';
import '../../../../core/managers/audio_play_services.dart';
import '../../../../core/managers/audio_record_services.dart';
import '../../../../core/managers/audio_sync_manager.dart';
import '../../../../core/managers/impl/background_task_manager.dart';
import '../../../../core/managers/local_store.dart';
import '../../../../core/managers/location_services.dart';
import '../../../../core/managers/modules_sevices.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/cache_storage.dart';
import '../../../../core/storage/persistent_storage.dart';
import '../../../appstate/data/repositories/app_state_repository.dart';
import '../../../appstate/domain/entities/app_preferences_entity.dart';
import '../../../appstate/domain/entities/user_profile_entity.dart';
import '../../../appstate/domain/repositories/i_app_state_repository.dart';
import '../../../appstate/domain/usecases/app_preferences_use_case.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../../../chat/domain/entities/chat_channel_open_entity.dart';
import '../../../chat/domain/repositories/chat_channel_repository.dart';
import '../../../chat/domain/usecases/chat_channel_usecase.dart';
import '../../../chat/domain/usecases/chat_toggle_feature.dart';
import '../../../chat/domain/usecases/get_chat_channel_token_usecase.dart';
import '../../../chat/presentation/chat/chat_channel_controller.dart';
import '../../../chat/presentation/chat/chat_channel_page.dart';
import '../../../chat/presentation/chat_main_controller.dart';
import '../../../chat/presentation/people/chat_main_people_controller.dart';
import '../../../chat/presentation/talk/chat_main_talks_controller.dart';
import '../../../escape_manual/data/datasource/escape_manual_datasource.dart';
import '../../../escape_manual/data/datasource/impl/escape_manual_local_datasource.dart';
import '../../../escape_manual/data/datasource/impl/escape_manual_remote_datasource.dart';
import '../../../escape_manual/data/datastore/escape_manual_cache_store.dart';
import '../../../escape_manual/data/datastore/escape_manual_persistent_store.dart';
import '../../../escape_manual/data/repository/escape_manual_repository.dart';
import '../../../escape_manual/domain/delete_escape_manual_task.dart';
import '../../../escape_manual/domain/escape_manual_toggle.dart';
import '../../../escape_manual/domain/get_escape_manual.dart';
import '../../../escape_manual/domain/send_pending_escape_manual_tasks.dart';
import '../../../escape_manual/domain/start_escape_manual.dart';
import '../../../escape_manual/domain/update_escape_manual_task.dart';
import '../../../escape_manual/presentation/edit/edit_trusted_contacts_controller.dart';
import '../../../escape_manual/presentation/escape_manual_controller.dart';
import '../../../feed/data/repositories/tweet_filter_preference_repository.dart';
import '../../../feed/data/repositories/tweet_repository.dart';
import '../../../feed/domain/repositories/i_tweet_repositories.dart';
import '../../../feed/domain/usecases/compose_tweet_fab_toggle.dart';
import '../../../feed/domain/usecases/feed_use_cases.dart';
import '../../../feed/domain/usecases/tweet_filter_preference.dart';
import '../../../feed/domain/usecases/tweet_toggle_feature.dart';
import '../../../feed/presentation/category_tweet/category_tweet_controller.dart';
import '../../../feed/presentation/category_tweet/category_tweet_page.dart';
import '../../../feed/presentation/compose_tweet/compose_tweet_controller.dart';
import '../../../feed/presentation/compose_tweet/compose_tweet_navigator.dart';
import '../../../feed/presentation/compose_tweet/compose_tweet_page.dart';
import '../../../feed/presentation/detail_tweet/detail_tweet_controller.dart';
import '../../../feed/presentation/detail_tweet/detail_tweet_page.dart';
import '../../../feed/presentation/feed_controller.dart';
import '../../../feed/presentation/filter_tweet/filter_tweet_controller.dart';
import '../../../feed/presentation/filter_tweet/filter_tweet_page.dart';
import '../../../feed/presentation/reply_tweet/reply_tweet_controller.dart';
import '../../../feed/presentation/reply_tweet/reply_tweet_page.dart';
import '../../../feed/presentation/routing_profile_chat/feed_routing_profile_chat_controller.dart';
import '../../../feed/presentation/routing_profile_chat/feed_routing_profile_chat_page.dart';
import '../../../feed/presentation/stores/tweet_controller.dart';
import '../../../filters/data/repositories/filter_skill_repository.dart';
import '../../../filters/presentation/filter_module.dart';
import '../../../help_center/data/repositories/audios_repository.dart';
import '../../../help_center/data/repositories/guardian_repository.dart';
import '../../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../../../help_center/presentation/audios/audios_controller.dart';
import '../../../help_center/presentation/audios/audios_page.dart';
import '../../../help_center/presentation/guardians/guardians_controller.dart';
import '../../../help_center/presentation/guardians/guardians_page.dart';
import '../../../help_center/presentation/help_center_controller.dart';
import '../../../help_center/presentation/new_guardian/new_guardian_controller.dart';
import '../../../help_center/presentation/new_guardian/new_guardian_page.dart';
import '../../../help_center/presentation/pages/audio/audio_record_controller.dart';
import '../../../help_center/presentation/pages/audio/audio_record_page.dart';
import '../../../main_menu/domain/repositories/user_profile_repository.dart';
import '../../../main_menu/domain/usecases/user_profile.dart';
import '../../../main_menu/presentation/account/delete/account_delete_controller.dart';
import '../../../main_menu/presentation/account/delete/account_delete_page.dart';
import '../../../main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import '../../../main_menu/presentation/account/my_profile/profile_edit_page.dart';
import '../../../main_menu/presentation/account/my_profile/skill/profile_skill_module.dart';
import '../../../main_menu/presentation/account/preference/account_preference_controller.dart';
import '../../../main_menu/presentation/account/preference/account_preference_page.dart';
import '../../../main_menu/presentation/pages/about_penhas_page.dart';
import '../../../main_menu/presentation/penhas_drawer_controller.dart';
import '../../../notification/data/repositories/notification_repository.dart';
import '../../../notification/presentation/notification_controller.dart';
import '../../../notification/presentation/notification_page.dart';
import '../../../quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import '../../../support_center/data/repositories/support_center_repository.dart';
import '../../../support_center/domain/usecases/support_center_usecase.dart';
import '../../../support_center/presentation/add/support_center_add_controller.dart';
import '../../../support_center/presentation/add/support_center_add_page.dart';
import '../../../support_center/presentation/list/support_center_list_controller.dart';
import '../../../support_center/presentation/list/support_center_list_page.dart';
import '../../../support_center/presentation/show/support_center_show_controller.dart';
import '../../../support_center/presentation/show/support_center_show_page.dart';
import '../../../support_center/presentation/support_center_controller.dart';
import '../../../users/data/repositories/users_repository.dart';
import '../../../users/presentation/user_profile_module.dart';
import '../../domain/states/mainboard_state.dart';
import '../../domain/states/mainboard_store.dart';
import 'mainboard_controller.dart';
import 'mainboard_page.dart';

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
        ...feedBinds,
        ...supportCenterBinds,
        Bind.factory<MainboardStore>(
          (i) => MainboardStore(
            modulesServices: i.get<IAppModulesServices>(),
            initialPage: MainboardState.fromString(
              i.args.queryParams['page'] ?? i.args.data?['page'],
            ),
          ),
        ),
        Bind.factory(
          (i) => MainboardController(
            mainboardStore: i.get<MainboardStore>(),
            inactivityLogoutUseCase: i.get<InactivityLogoutUseCase>(),
            notification: i.get<INotificationRepository>(),
          ),
        ),
        Bind.lazySingleton<FeedUseCases>(
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
          child: (_, args) => MainboardPage(
            controller: Modular.get<MainboardController>(),
            composeTweetController: Modular.get<ComposeTweetController>(),
            penhasDrawerController: Modular.get<PenhasDrawerController>(),
            stealthController: Modular.get<StealthModeTutorialPageController>(),
          ),
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
          child: (_, args) => ReplyTweetPage(
            controller: Modular.get<ReplyTweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/compose',
          child: (_, args) => ComposeTweetPage(
            showAppBar: true,
            composeTweetController: Modular.get<ComposeTweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tweet/:id',
          child: (context, args) => DetailTweetPage(
            tweetController: Modular.get<ITweetController>(),
            detailTweetController: Modular.get<DetailTweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/category',
          child: (context, args) => CategoryTweetPage(
            controller: Modular.get<CategoryTweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tags',
          child: (context, args) => FilterTweetPage(
            controller: Modular.get<FilterTweetController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/tweet/perfil_chat',
          child: (context, args) => FeedRoutingProfileChatPage(
            controller: Modular.get<FeedRoutingProfileChatController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
      ];

  List<ModularRoute> get helpCenter => [
        ChildRoute(
          '/helpcenter/newGuardian',
          child: (context, args) => NewGuardianPage(
            controller: Modular.get<NewGuardianController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/guardians',
          child: (context, args) => GuardiansPage(
            controller: Modular.get<GuardiansController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/audios',
          child: (context, args) => AudiosPage(
            controller: Modular.get<AudiosController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/helpcenter/audioRecord',
          child: (context, args) => AudioRecordPage(
            controller: Modular.get<AudioRecordController>(),
          ),
          transition: TransitionType.rightToLeft,
        )
      ];

  List<ModularRoute> get supportCenter => [
        ChildRoute(
          '/supportcenter/add',
          child: (context, args) => SupportCenterAddPage(
            controller: Modular.get<SupportCenterAddController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/supportcenter/list',
          child: (context, args) => SupportCenterListPage(
            controller: Modular.get<SupportCenterListController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/supportcenter/show',
          child: (context, args) => SupportCenterShowPage(
            controller: Modular.get<SupportCenterShowController>(),
          ),
          transition: TransitionType.rightToLeft,
        )
      ];

  List<ModularRoute> get notificationCenter => [
        ChildRoute(
          '/notification',
          child: (context, args) => NotificationPage(
            controller: Modular.get<NotificationController>(),
          ),
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
          child: (context, args) => AboutPenhasPage(
            baseUrl: Modular.get<IAppConfiguration>().penhasServer,
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/profile_edit',
          child: (context, args) => ProfileEditPage(
            controller: Modular.get<ProfileEditController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/account_preference',
          child: (context, args) => AccountPreferencePage(
            controller: Modular.get<AccountPreferenceController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/account_delete',
          child: (context, args) => AccountDeletePage(
            controller: Modular.get<AccountDeleteController>(),
          ),
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
          child: (context, args) => ChatPage(
            controller: Modular.get<ChatChannelController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/chat_from_feed',
          child: (context, args) => ChatPage(
            controller: Modular.get<ChatChannelController>(),
          ),
          transition: TransitionType.noTransition,
        ),
      ];

  List<Bind> get chatBinds => [
        Bind.factory<ChatMainController>(
          (i) => ChatMainController(
            chatToggleFeature: i.get<ChatPrivateToggleFeature>(),
          ),
        ),
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
        Bind.factory(
          (i) => ChatChannelUseCase(
            session: i.args.data ??
                ChatChannelOpenEntity(token: i.args.params['token']),
            channelRepository: i.get<IChatChannelRepository>(),
          ),
        ),
        Bind.factory(
          (i) => GetChatChannelTokenUseCase(repository: i()),
        ),
        Bind.factory<ChatPrivateToggleFeature>(
          (i) => ChatPrivateToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<ChatMainTalksController>(
          (i) => ChatMainTalksController(
            chatChannelRepository: i.get<IChatChannelRepository>(),
          ),
        ),
        Bind.factory<ChatMainPeopleController>(
          (i) => ChatMainPeopleController(
            usersRepository: i.get<IUsersRepository>(),
            skillRepository: i.get<IFilterSkillRepository>(),
          ),
        ),
        Bind.factory<IUsersRepository>(
          (i) => UsersRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory<IChatChannelRepository>(
          (i) => ChatChannelRepository(
            apiProvider: i.get<IApiProvider>(),
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
            navigator: i.get<ComposeTweetNavigator>(),
          ),
        ),
        Bind.factory(
          (i) => ReplyTweetController(
            useCase: i.get<FeedUseCases>(),
            tweet: i.args.data,
          ),
        ),
        Bind.factory(
          (i) => DetailTweetController(
            useCase: i.get<FeedUseCases>(),
            tweetId: i.args.params['id'],
            tweet: i.args.data,
            commentId: i.args.queryParams['comment_id'],
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
        Bind.factory<ComposeTweetNavigator>(
          (i) => ComposeTweetNavigator(
            currentUri: i.args.uri,
          ),
        ),
        Bind.factory<IUsersRepository>(
          (i) => UsersRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory(
          (i) => FeedRoutingProfileChatController(
            usersRepository: i.get<IUsersRepository>(),
            channelRepository: i.get<IChatChannelRepository>(),
            routerType: i.args.data,
          ),
        )
      ];

  List<Bind> get interfaceBinds => [
        Bind.factory<ITweetController>(
          (i) => TweetController(useCase: i.get<FeedUseCases>()),
        ),
        Bind.factory<ITweetRepository>(
          (i) => TweetRepository(apiProvider: i.get<IApiProvider>()),
        ),
        Bind.factory<ITweetFilterPreferenceRepository>(
          (i) => TweetFilterPreferenceRepository(
            apiProvider: i.get<IApiProvider>(),
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
            analytics: i.get(),
          ),
        ),
        Bind.factory<InactivityLogoutUseCase>(
          (i) => InactivityLogoutUseCase(
            appPreferencesStore: i.get<LocalStore<AppPreferencesEntity>>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
          ),
        ),
        Bind.factory<IAppStateRepository>(
          (i) => AppStateRepository(apiProvider: i.get<IApiProvider>()),
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
          (i) => GuardianRepository(apiProvider: i.get<IApiProvider>()),
        ),
        Bind.factory<HelpCenterController>(
          (i) => HelpCenterController(
            locationService: i.get<ILocationServices>(),
            appConfiguration: i.get<IAppConfiguration>(),
            guardianRepository: i.get<IGuardianRepository>(),
            featureToogle: i.get<SecurityModeActionFeature>(),
            audioServices: i.get<IAudioRecordServices>(),
          ),
        ),
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory(
          (i) => AudioRecordController(
            featureToogle: i.get<SecurityModeActionFeature>(),
            audioServices: i.get<IAudioRecordServices>(),
          ),
        ),
      ];

  List<Bind> get feedBinds => [
        Bind.factory<ITweetRepository>(
          (i) => TweetRepository(apiProvider: i.get<IApiProvider>()),
        ),
        Bind.factory<ITweetFilterPreferenceRepository>(
          (i) => TweetFilterPreferenceRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind<FeedUseCases>(
          (i) => FeedUseCases(
            repository: i<ITweetRepository>(),
            filterPreference: i<TweetFilterPreference>(),
          ),
        ),
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<EscapeManualToggleFeature>(
          (i) => EscapeManualToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<TweetToggleFeature>(
          (i) => TweetToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<ComposeTweetFabToggleFeature>(
          (i) => ComposeTweetFabToggleFeature(
            escapeManualToggleFeature: i.get<EscapeManualToggleFeature>(),
            tweetToggleFeature: i.get<TweetToggleFeature>(),
          ),
        ),
        Bind.factory(
          (i) => FeedController(
            useCase: i.get<FeedUseCases>(),
            securityModeActionFeature: i.get<SecurityModeActionFeature>(),
            composeTweetFabToggleFeature: i.get<ComposeTweetFabToggleFeature>(),
          ),
        ),
      ];

  List<Bind> get escapeManualBinds => [
        Bind.lazySingleton<EscapeManualController>(
          (i) => EscapeManualController(
            getEscapeManual: i.get<GetEscapeManualUseCase>(),
            startEscapeManual: i.get<StartEscapeManualUseCase>(),
            updateTask: i.get<UpdateEscapeManualTaskUseCase>(),
            deleteTask: i.get<DeleteEscapeManualTaskUseCase>(),
            backgroundTaskManager: i.get<BackgroundTaskManager>(),
          ),
        ),
        Bind.factory<EditTrustedContactsController>(
          (i) => EditTrustedContactsController(
            contacts: i.args.data,
            escapeManualToggleFeature: i.get<EscapeManualToggleFeature>(),
          ),
        ),
        Bind.factory<GetEscapeManualUseCase>(
          (i) => GetEscapeManualUseCase(
            repository: i.get<IEscapeManualRepository>(),
          ),
        ),
        Bind.factory(
          (i) => StartEscapeManualUseCase(
            repository: i.get<IEscapeManualRepository>(),
          ),
        ),
        Bind.factory<UpdateEscapeManualTaskUseCase>(
          (i) => UpdateEscapeManualTaskUseCase(
            repository: i.get<IEscapeManualRepository>(),
          ),
        ),
        Bind.factory<DeleteEscapeManualTaskUseCase>(
          (i) => DeleteEscapeManualTaskUseCase(
            repository: i.get<IEscapeManualRepository>(),
          ),
        ),
        Bind.factory<SendPendingEscapeManualTasksUseCase>(
          (i) => SendPendingEscapeManualTasksUseCase(
            repository: i.get<IEscapeManualRepository>(),
          ),
        ),
        Bind.factory<IEscapeManualRepository>(
          (i) => EscapeManualRepository(
            localDatasource: i.get<IEscapeManualLocalDatasource>(),
            remoteDatasource: i.get<IEscapeManualRemoteDatasource>(),
          ),
        ),
        Bind.factory<IEscapeManualRemoteDatasource>(
          (i) => EscapeManualRemoteDatasource(
            apiProvider: i.get<IApiProvider>(),
            cacheStorage: EscapeManualCacheStore(
              storage: i.get<ICacheStorage>(),
            ),
          ),
        ),
        Bind.factory<IEscapeManualLocalDatasource>(
          (i) => EscapeManualLocalDatasource(
            store: i.get<EscapeManualTasksStore>(),
          ),
        ),
        Bind.factory<EscapeManualTasksStore>(
          (i) => EscapeManualTasksStore(
            storageFactory: i.get<IPersistentStorageFactory>(),
          ),
        ),
      ];

  List<Bind> get supportCenterBinds => [
        Bind.factory<ISupportCenterRepository>(
          (i) => SupportCenterRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory<SupportCenterUseCase>(
          (i) => SupportCenterUseCase(
            locationService: i.get<ILocationServices>(),
            supportCenterRepository: i.get<ISupportCenterRepository>(),
          ),
        ),
        Bind.factory<SupportCenterController>(
          (i) => SupportCenterController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => SupportCenterAddController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => SupportCenterListController(i.args.data),
        ),
        Bind.factory(
          (i) => SupportCenterShowController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
            place: i.args.data,
          ),
        ),
      ];
}
