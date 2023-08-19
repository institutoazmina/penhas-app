import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class AppModulesMock {
  static late IAppConfiguration appConfiguration;
  static late IUserProfileRepository userProfileRepository;

  static void init() {
    _initMocks();
  }

  static void _initMocks() {
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
