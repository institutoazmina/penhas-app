import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_filter_preference_data_source.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';

Map<String, dynamic> userProfileEntityToJson(UserProfileEntity? entity) =>
    throw 'not implemented';

UserProfileEntity userProfileEntityFromJson(Map<String, dynamic>? json) =>
    throw 'not implemented';

UserProfileEntity userProfileEntityDefaultEntity() => throw 'not implemented';

Map<String, dynamic> appPreferencesEntityToJson(AppPreferencesEntity? entity) =>
    throw 'not implemented';

AppPreferencesEntity appPreferencesEntityFromJson(Map<String, dynamic>? json) =>
    throw 'not implemented';

AppPreferencesEntity appPreferencesEntityDefaultEntity() =>
    throw 'not implemented';

@GenerateMocks([
  IApiServerConfigure,
  ILocalStorage,
  DataConnectionChecker,
  IAppStateRepository,
  IAppConfiguration,
  IAppModulesServices,
  IChangePasswordDataSource,
  INetworkInfo,
  IApiProvider,
  AppStateUseCase,
  IUserProfileRepository,
  IQuizDataSource,
  ILocationServices,
  ITweetRepository,
  TweetFilterPreference,
  IAuthenticationRepository,
  IUserRegisterRepository,
  IResetPasswordRepository,
  ITweetDataSource,
  ISupportCenterRepository,
  IGuardianDataSource,
  IUserRegisterDataSource,
  IAppStateDataSource,
  IChangePasswordRepository,
  AuthenticationDataSource,
  ITweetFilterPreferenceDataSource,
  AuthenticationRepository,
  ITweetFilterPreferenceRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<LocalStore<UserProfileEntity>>(
    as: #MockUserProfileStore,
    fallbackGenerators: {
      #toJson: userProfileEntityToJson,
      #fromJson: userProfileEntityFromJson,
      #defaultEntity: userProfileEntityDefaultEntity,
    },
  ),
  MockSpec<LocalStore<AppPreferencesEntity>>(
    as: #MockAppPreferencesStore,
    fallbackGenerators: {
      #toJson: appPreferencesEntityToJson,
      #fromJson: appPreferencesEntityFromJson,
      #defaultEntity: appPreferencesEntityDefaultEntity,
    },
  ),
],)
void main() {
  // just for mocks
}
