// import 'package:http/http.dart' as http;
// import 'package:penhas/app/core/network/api_server_configure.dart';
// import 'package:penhas/app/core/network/network_info.dart';
// import 'package:penhas/app/features/authentication/data/datasources/change_password_data_source.dart';
// import 'package:penhas/app/features/authentication/data/repositories/change_password_repository.dart';
// import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
// import 'package:penhas/app/features/authentication/presentation/reset_password_two/reset_password_two_controller.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:penhas/app/features/authentication/presentation/reset_password_two/reset_password_two_page.dart';

// class ResetPasswordTwoModule extends ChildModule {
//   @override
//   List<Bind> get binds => [
//         Bind((i) => ResetPasswordTwoController(
//               i.get<IChangePasswordRepository>(),
//               i.args.data,
//             )),
//         Bind<IChangePasswordRepository>(
//           (i) => ChangePasswordRepository(
//             changePasswordDataSource: i.get<IChangePasswordDataSource>(),
//             networkInfo: i.get<INetworkInfo>(),
//           ),
//         ),
//         Bind<IResetPasswordRepository>(
//           (i) => ChangePasswordRepository(
//             changePasswordDataSource: i.get<IChangePasswordDataSource>(),
//             networkInfo: i.get<INetworkInfo>(),
//           ),
//         ),
//         Bind<IChangePasswordDataSource>(
//           (i) => ChangePasswordDataSource(
//             apiClient: i.get<http.Client>(),
//             serverConfiguration: i.get<IApiServerConfigure>(),
//           ),
//         ),
//       ];

//   @override
//   List<Router> get routers => [
//         Router(Modular.initialRoute,
//             child: (_, args) => ResetPasswordTwoPage()),
//       ];

//   static Inject get to => Inject<ResetPasswordTwoModule>.of();
// }
