import 'package:http/http.dart' as http;
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up_two/sign_up_two_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up_two/sign_up_two_page.dart';

class SignUpTwoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignUpTwoController(i.get<IUserRegisterRepository>())),
        Bind<IUserRegisterRepository>(
          (i) => UserRegisterRepository(
            dataSource: i.get<IUserRegisterDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
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
        Router(Modular.initialRoute, child: (_, args) => SignUpTwoPage()),
      ];

  static Inject get to => Inject<SignUpTwoModule>.of();
}
