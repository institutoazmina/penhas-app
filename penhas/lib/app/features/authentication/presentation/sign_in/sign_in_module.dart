import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/data/repositories/change_password_repository.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_page.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_module.dart';

class SignInModule extends ChildModule {
  @override
  List<Bind> get binds => [
        ..._interfaces,
        // Sign-In
        Bind((i) => SignInController(i.get<IAuthenticationRepository>())),
        ..._signUp,
        ..._resetPassword,
        ..._signInAnonymous,
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignInPage()),
        Router('/signup',
            child: (_, args) => SignUpPage(),
            transition: TransitionType.rightToLeft),
        Router(
          '/signup/step2',
          child: (_, args) => SignUpTwoPage(),
        ),
        Router(
          '/signup/step3',
          child: (_, args) => SignUpThreePage(),
        ),
        Router(
          '/reset_password',
          child: (_, args) => ResetPasswordPage(),
        ),
        Router(
          '/reset_password/step2',
          child: (_, args) => ResetPasswordTwoPage(),
        ),
        Router(
          '/reset_password/step3',
          child: (_, args) => ResetPasswordThreePage(),
        ),
        Router(
          '/sign_in_anonymous',
          child: (_, args) => SignInAnonymousPage(),
        ),
        Router(
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
          ),
        ),
      ];

  List<Bind> get _signInAnonymous => [
        Bind(
          (i) => SignInAnonymousController(
              repository: i.get<IAuthenticationRepository>(),
              userProfileStore: i.get<IUserProfileStore>()),
        )
      ];

  static Inject get to => Inject<SignInModule>.of();
}
