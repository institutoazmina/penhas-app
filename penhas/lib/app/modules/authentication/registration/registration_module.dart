import 'package:penhas/app/modules/authentication/registration/registration_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/modules/authentication/registration/registration_page.dart';

class RegistrationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => RegistrationController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => RegistrationPage()),
      ];

  static Inject get to => Inject<RegistrationModule>.of();
}
