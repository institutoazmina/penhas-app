import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';

class MainboardModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MainboardController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => MainboardPage()),
      ];

  static Inject get to => Inject<MainboardModule>.of();
}
