import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class AppModulesMock {
  static late IAppConfiguration appConfiguration;
  static late IUserProfileRepository userProfileRepository;
  static late AppStateUseCase appStateUseCase;

  static void init() {
    _initMocks();
  }

  static void _initMocks() {
    appStateUseCase = MockAppStateUseCase();
    appConfiguration = MockAppConfiguration();
    userProfileRepository = MockUserProfileRepository();
  }
}

///
/// Mock classes
///

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockAppStateUseCase extends Mock implements AppStateUseCase {}
