import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/filters/domain/presentation/filter_controller.dart';
import 'package:penhas/app/features/filters/domain/presentation/filter_page.dart';

class FilterModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => FilterController(tags: i.args.data),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (context, args) => FilterPage(),
        )
      ];

  static Inject get to => Inject<FilterModule>.of();
}
