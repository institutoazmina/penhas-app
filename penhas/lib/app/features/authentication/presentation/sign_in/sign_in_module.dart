import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:http/http.dart' as http;

class SignInModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignInController(i.get<IAuthenticationRepository>())),
        Bind<IAuthenticationRepository>((i) => AuthenticationRepository(
            dataSource: i.get<IAuthenticationDataSource>(),
            networkInfo: i.get<INetworkInfo>())),
        Bind<IAuthenticationDataSource>((i) => AuthenticationDataSource(
            apiClient: i.get<http.Client>(), serverConfiguration: null)),
        Bind<IApiServerConfigure>((i) => ApiServerConfigure(baseUri: null)),
        Bind<http.Client>((i) => http.Client()),
        Bind<INetworkInfo>((i) => NetworkInfo(i.get<DataConnectionChecker>())),
        Bind((i) => DataConnectionChecker()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignInPage()),
      ];

  static Inject get to => Inject<SignInModule>.of();
}
