import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../../../../core/managers/app_configuration.dart';
import '../../../../core/managers/audio_record_services.dart';
import '../../../../core/managers/audio_sync_manager.dart';
import '../../../../core/managers/local_store.dart';
import '../../../../core/managers/location_services.dart';
import '../../../../core/managers/modules_sevices.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/remoteconfig/i_remote_config.dart';
import '../../../appstate/domain/entities/user_profile_entity.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../../../help_center/data/datasources/guardian_data_source.dart';
import '../../../help_center/data/repositories/guardian_repository.dart';
import '../../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../../../zodiac/domain/usecases/stealth_security_action.dart';
import '../../../zodiac/presentation/zodiac_module.dart';
import '../../data/datasources/authentication_data_source.dart';
import '../../data/datasources/change_password_data_source.dart';
import '../../data/datasources/user_register_data_source.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/change_password_repository.dart';
import '../../data/repositories/user_register_repository.dart';
import '../../domain/repositories/i_authentication_repository.dart';
import '../../domain/repositories/i_reset_password_repository.dart';
import '../../domain/repositories/i_user_register_repository.dart';
import '../../domain/usecases/authenticate_user.dart';
import '../../domain/usecases/login_offline_toggle.dart';
import '../../domain/usecases/password_validator.dart';
import '../reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import '../reset_password/pages/reset_password_three/reset_password_three_page.dart';
import '../reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import '../reset_password/pages/reset_password_two/reset_password_two_page.dart';
import '../reset_password/reset_password_controller.dart';
import '../reset_password/reset_password_page.dart';
import '../sign_in_anonymous/sign_in_anonymous_controller.dart';
import '../sign_in_anonymous/sign_in_anonymous_page.dart';
import '../sign_in_stealth/sign_in_stealth_controller.dart';
import '../sign_in_stealth/sign_in_stealth_page.dart';
import 'privacy_policy/privacy_policy_page.dart';
import 'sign_in_controller.dart';
import 'sign_in_page.dart';
import 'sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'sign_up/pages/sign_up_three/sign_up_three_page.dart';
import 'sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'sign_up/pages/sign_up_two/sign_up_two_page.dart';
import 'sign_up/sign_up_controller.dart';
import 'sign_up/sign_up_page.dart';
import 'terms_of_use/terms_of_use_page.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        ..._interfaces,
        ..._signIn,
        ..._signUp,
        ..._resetPassword,
        ..._signInAnonymous,
        ..._signInStealth,
        ..._loginOfflineToggle
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => SignInPage(
                  controller: Modular.get<SignInController>(),
                )),
        ChildRoute(
          '/signup',
          child: (_, args) => SignUpPage(
            controller: Modular.get<SignUpController>(),
          ),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/signup/step2',
          child: (_, args) => const SignUpTwoPage(),
        ),
        ChildRoute(
          '/signup/step3',
          child: (_, args) => const SignUpThreePage(),
        ),
        ChildRoute(
          '/reset_password',
          child: (_, args) => ResetPasswordPage(
            controller: Modular.get<ResetPasswordController>(),
          ),
        ),
        ChildRoute(
          '/reset_password/step2',
          child: (_, args) => ResetPasswordTwoPage(
            controller: Modular.get<ResetPasswordTwoController>(),
          ),
        ),
        ChildRoute(
          '/reset_password/step3',
          child: (_, args) => ResetPasswordThreePage(
            controller: Modular.get<ResetPasswordThreeController>(),
          ),
        ),
        ChildRoute(
          '/sign_in_anonymous',
          child: (_, args) => SignInAnonymousPage(
            controller: Modular.get<SignInAnonymousController>(),
          ),
        ),
        ChildRoute(
          '/sign_in_stealth',
          child: (_, args) => SignInStealthPage(
            controller: Modular.get<SignInStealthController>(),
          ),
        ),
        ChildRoute(
          '/terms_of_use',
          child: (_, args) => TermsOfUsePage(
            baseUrl: inject<IAppConfiguration>().penhasServer,
          ),
        ),
        ChildRoute(
          '/privacy_policy',
          child: (_, args) => PrivacyPolicyPage(
            baseUrl: inject<IAppConfiguration>().penhasServer,
          ),
        ),
        ChildRoute(
          '/stealth',
          child: (_, args) => ZodiacModule(),
        ),
      ];

  List<Bind> get _interfaces => [
        Bind.factory<IResetPasswordRepository>(
          (i) => ChangePasswordRepository(
            changePasswordDataSource: i.get<IChangePasswordDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind.factory<IChangePasswordDataSource>(
          (i) => ChangePasswordDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<IAuthenticationRepository>(
          (i) => AuthenticationRepository(
            dataSource: i.get<IAuthenticationDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind.factory<IAuthenticationDataSource>(
          (i) => AuthenticationDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<IUserRegisterRepository>(
          (i) => UserRegisterRepository(
            dataSource: i.get<IUserRegisterDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind.factory<IUserRegisterDataSource>(
          (i) => UserRegisterDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<PasswordValidator>((_) => PasswordValidator())
      ];

  List<Bind> get _signUp => [
        // Sign-Up
        Bind.factory<SignUpController>(
          (i) => SignUpController(i.get<IUserRegisterRepository>()),
        ),
        Bind.factory<SignUpTwoController>(
          (i) => SignUpTwoController(
            i.get<IUserRegisterRepository>(),
            i.args?.data,
          ),
        ),
        Bind.factory<SignUpThreeController>(
          (i) => SignUpThreeController(
            i.get<IUserRegisterRepository>(),
            i.args?.data!,
            i.get<PasswordValidator>(),
          ),
        ),
      ];

  List<Bind> get _resetPassword => [
        Bind.factory<ResetPasswordController>(
          (i) => ResetPasswordController(i.get<IResetPasswordRepository>()),
        ),
        Bind.factory<ResetPasswordTwoController>(
          (i) => ResetPasswordTwoController(
            i.get<IChangePasswordRepository>(),
            i.args?.data,
          ),
        ),
        Bind.factory<ResetPasswordThreeController>(
          (i) => ResetPasswordThreeController(
            i.get<IChangePasswordRepository>(),
            i.args?.data,
            i.get<PasswordValidator>(),
          ),
        ),
      ];

  List<Bind> get _signIn => [
        Bind.factory<SignInController>(
          (i) => SignInController(
            authenticateUserUseCase: i.get<AuthenticateUserUseCase>(),
            appStateUseCase: i.get<AppStateUseCase>(),
            passwordValidator: i.get<PasswordValidator>(),
          ),
        ),
        Bind.factory<AuthenticateUserUseCase>(
            (i) => AuthenticateUserUseCase(authenticationRepository: i.get()))
      ];

  List<Bind> get _signInAnonymous => [
        Bind.factory<SignInAnonymousController>(
          (i) => SignInAnonymousController(
            authenticateAnonymousUserUseCase:
                i.get<AuthenticateAnonymousUserUseCase>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            passwordValidator: i.get<PasswordValidator>(),
          ),
        ),
        Bind.factory<AuthenticateAnonymousUserUseCase>((i) =>
            AuthenticateAnonymousUserUseCase(
                authenticationRepository: i.get(),
                loginOfflineToggleFeature: i.get()))
      ];

  List<Bind> get _loginOfflineToggle => [
        Bind.factory<LoginOfflineToggleFeature>((_) =>
            LoginOfflineToggleFeature(
                remoteConfig: Modular.get<IRemoteConfigService>()))
      ];

  List<Bind> get _signInStealth => [
        Bind.factory<SignInStealthController>(
          (i) => SignInStealthController(
            authenticateStealthUserUseCase:
                i.get<AuthenticateStealthUserUseCase>(),
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            securityAction: i.get<StealthSecurityAction>(),
            passwordValidator: i.get<PasswordValidator>(),
          ),
        ),
        Bind.factory<AuthenticateStealthUserUseCase>((i) =>
            AuthenticateStealthUserUseCase(
                authenticationRepository: i.get(),
                loginOfflineToggleFeature: i.get())),
        Bind.factory<StealthSecurityAction>(
          (i) => StealthSecurityAction(
            audioServices: i.get<IAudioRecordServices>(),
            featureToggle: i.get<SecurityModeActionFeature>(),
            locationService: i.get<ILocationServices>(),
            guardianRepository: i.get<IGuardianRepository>(),
          ),
        ),
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<IGuardianRepository>(
          (i) => GuardianRepository(
            dataSource: i.get<IGuardianDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind.factory<ILocationServices>(
          (i) => LocationServices(),
        ),
        Bind.factory<IGuardianDataSource>(
          (i) => GuardianDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<IAudioRecordServices>(
          (i) => AudioRecordServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
        )
      ];
}
