import 'package:flutter_modular/flutter_modular.dart';

import '../domain/entities/filter_tag_entity.dart';
import '../presentation/filter_page.dart';
import 'filter_controller.dart';

class FilterModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => FilterController(
            tags: i.args?.data as List<FilterTagEntity>? ?? [],
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const FilterPage(),
        )
      ];
}
