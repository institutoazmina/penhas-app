import 'package:penhas/app/modules/authentication/authentication_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/modules/authentication/authentication_page.dart';

class AuthenticationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthenticationController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => AuthenticationPage()),
      ];

  static Inject get to => Inject<AuthenticationModule>.of();
}
