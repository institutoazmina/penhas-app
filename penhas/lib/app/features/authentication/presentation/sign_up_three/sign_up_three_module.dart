import 'package:penhas/app/features/authentication/presentation/sign_up_three/sign_up_three_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up_three/sign_up_three_page.dart';

class SignUpThreeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SignUpThreeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SignUpThreePage()),
      ];

  static Inject get to => Inject<SignUpThreeModule>.of();
}
