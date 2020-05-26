import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_module.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password_three/reset_password_three_module.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password_two/reset_password_two_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';

class SignInModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignInController(i.get<IAuthenticationRepository>())),
        Bind((i) => SignUpController(i.get<IUserRegisterRepository>()),
            singleton: false),
        Bind((i) =>
            SignUpTwoController(i.get<IUserRegisterRepository>(), i.args.data)),
        Bind((i) => SignUpThreeController(
            i.get<IUserRegisterRepository>(), i.args.data)),
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

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignInPage()),
        Router('/signup',
            child: (_, args) => SignUpPage(),
            transition: TransitionType.rightToLeft),
        Router('/signup/step2', child: (_, args) => SignUpTwoPage()),
        Router('/signup/step3', child: (_, args) => SignUpThreePage()),
        Router('/reset_password', module: ResetPasswordModule()),
        Router('/reset_password/step2', module: ResetPasswordTwoModule()),
        Router('/reset_password/step3', module: ResetPasswordThreeModule()),
      ];

  static Inject get to => Inject<SignInModule>.of();
}
