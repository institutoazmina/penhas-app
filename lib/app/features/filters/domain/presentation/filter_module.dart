import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/domain/presentation/filter_controller.dart';
import 'package:penhas/app/features/filters/domain/presentation/filter_page.dart';

class FilterModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => FilterController(
              tags: i.args?.data as List<FilterTagEntity>? ?? [],),
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
