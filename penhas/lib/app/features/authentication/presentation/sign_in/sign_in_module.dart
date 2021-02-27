import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/data/repositories/change_password_repository.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/privacy_policy/privacy_policy_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/terms_of_use/terms_of_use_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_page.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_module.dart';

class SignInModule extends ChildModule {
  @override
  List<Bind> get binds => [
        ..._interfaces,
        // Sign-In
        Bind((i) => SignInController(
              i.get<IAuthenticationRepository>(),
              i.get<PasswordValidator>(),
              i.get<AppStateUseCase>(),
            )),
        ..._signUp,
        ..._resetPassword,
        ..._signInAnonymous,
        ..._signInStealth,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SignInPage()),
        ModularRouter('/signup',
            child: (_, args) => SignUpPage(),
            transition: TransitionType.rightToLeft),
        ModularRouter(
          '/signup/step2',
          child: (_, args) => SignUpTwoPage(),
        ),
        ModularRouter(
          '/signup/step3',
          child: (_, args) => SignUpThreePage(),
        ),
        ModularRouter(
          '/reset_password',
          child: (_, args) => ResetPasswordPage(),
        ),
        ModularRouter(
          '/reset_password/step2',
          child: (_, args) => ResetPasswordTwoPage(),
        ),
        ModularRouter(
          '/reset_password/step3',
          child: (_, args) => ResetPasswordThreePage(),
        ),
        ModularRouter(
          '/sign_in_anonymous',
          child: (_, args) => SignInAnonymousPage(),
        ),
        ModularRouter(
          '/sign_in_stealth',
          child: (_, args) => SignInStealthPage(),
        ),
        ModularRouter(
          '/terms_of_use',
          child: (_, args) => TermsOfUsePage(),
        ),
        ModularRouter(
          '/privacy_policy',
          child: (_, args) => PrivacyPolicyPage(),
        ),
        ModularRouter(
          '/stealth',
          child: (_, args) => ZodiacModule(),
        ),
      ];

  List<Bind> get _interfaces => [
        Bind<IResetPasswordRepository>(
          (i) => ChangePasswordRepository(
            changePasswordDataSource: i.get<IChangePasswordDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind<IChangePasswordDataSource>(
          (i) => ChangePasswordDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<IAuthenticationRepository>(
          (i) => AuthenticationRepository(
            dataSource: i.get<IAuthenticationDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind<IAuthenticationDataSource>(
          (i) => AuthenticationDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<IUserRegisterRepository>(
          (i) => UserRegisterRepository(
            dataSource: i.get<IUserRegisterDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind<IUserRegisterDataSource>(
          (i) => UserRegisterDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<PasswordValidator>((_) => PasswordValidator())
      ];

  List<Bind> get _signUp => [
        // Sign-Up
        Bind((i) => SignUpController(i.get<IUserRegisterRepository>()),
            singleton: false),
        Bind(
          (i) => SignUpTwoController(
            i.get<IUserRegisterRepository>(),
            i.args.data,
          ),
        ),
        Bind(
          (i) => SignUpThreeController(
            i.get<IUserRegisterRepository>(),
            i.args.data,
            i.get<PasswordValidator>(),
          ),
        ),
      ];

  List<Bind> get _resetPassword => [
        Bind((i) => ResetPasswordController(i.get<IResetPasswordRepository>())),
        Bind(
          (i) => ResetPasswordTwoController(
            i.get<IChangePasswordRepository>(),
            i.args.data,
          ),
        ),
        Bind(
          (i) => ResetPasswordThreeController(
            i.get<IChangePasswordRepository>(),
            i.args.data,
            i.get<PasswordValidator>(),
          ),
        ),
      ];

  List<Bind> get _signInAnonymous => [
        Bind(
          (i) => SignInAnonymousController(
            repository: i.get<IAuthenticationRepository>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            passwordValidator: i.get<PasswordValidator>(),
          ),
          singleton: false,
        )
      ];

  List<Bind> get _signInStealth => [
        Bind(
          (i) => SignInStealthController(
            repository: i.get<IAuthenticationRepository>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            securityAction: i.get<StealthSecurityAction>(),
            passwordValidator: i.get<PasswordValidator>(),
          ),
          singleton: false,
        ),
        Bind(
          (i) => StealthSecurityAction(
              audioServices: i.get<IAudioRecordServices>(),
              featureToogle: i.get<SecurityModeActionFeature>(),
              locationService: i.get<ILocationServices>(),
              guardianRepository: i.get<IGuardianRepository>()),
          singleton: false,
        ),
        Bind<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
          singleton: false,
        ),
        Bind<IGuardianRepository>(
          (i) => GuardianRepository(
            dataSource: i.get<IGuardianDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind<ILocationServices>(
          (i) => LocationServices(),
          singleton: false,
        ),
        Bind<IGuardianDataSource>(
          (i) => GuardianDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<IAudioRecordServices>(
          (i) => AudioRecordServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
          singleton: false,
        )
      ];

  static Inject get to => Inject<SignInModule>.of();
}
