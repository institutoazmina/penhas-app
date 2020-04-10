import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/modules/authentication/authentication_controller.dart';
import 'package:penhas/app/modules/authentication/authentication_page.dart';
import 'package:penhas/app/modules/authentication/password_recovery/password_recovery_module.dart';
import 'package:penhas/app/modules/authentication/registration/registration_module.dart';

class AuthenticationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthenticationController()),
        Bind((i) => RegistrationModule()),
        Bind((i) => PasswordRecoveryModule())
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => AuthenticationPage()),
        Router('registration/', module: RegistrationModule()),
        Router('recovery/', module: PasswordRecoveryModule())
      ];

  static Inject get to => Inject<AuthenticationModule>.of();
}
