import 'package:penhas/app/modules/authentication/password_recovery/password_recovery_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/modules/authentication/password_recovery/password_recovery_page.dart';

class PasswordRecoveryModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PasswordRecoveryController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => PasswordRecoveryPage()),
      ];

  static Inject get to => Inject<PasswordRecoveryModule>.of();
}
