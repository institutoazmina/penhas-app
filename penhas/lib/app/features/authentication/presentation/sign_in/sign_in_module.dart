import 'package:http/http.dart' as http;
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/sign_up_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up_three/sign_up_three_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up_two/sign_up_two_module.dart';

class SignInModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignInController(i.get<IAuthenticationRepository>())),
        Bind<IAuthenticationRepository>(
          (i) => AuthenticationRepository(
            dataSource: i.get<IAuthenticationDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind<IAuthenticationDataSource>(
          (i) => AuthenticationDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignInPage()),
        Router('/signup', module: SignUpModule()),
        Router('/signup/step2', module: SignUpTwoModule()),
        Router('/signup/step3', module: SignUpThreeModule()),
      ];

  static Inject get to => Inject<SignInModule>.of();
}
