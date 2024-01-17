import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/app_module.dart';

Widget buildTestableApp({
  Widget? home,
  String? initialRoute,
  List<Module>? modules,
  List<Bind> overrides = const [],
}) =>
    ModularApp(
      module: _TestModule(
        home: home,
        modules: modules ?? [AppModule()],
        overrides: overrides,
      ),
      child: MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          initialRoute: initialRoute,
        ).modular(),
      ),
    );

class _TestModule extends Module {
  _TestModule({
    this.home,
    this.modules = const [],
    this.overrides = const [],
  });

  final Widget? home;
  final List<Module> modules;
  final List<Bind> overrides;

  @override
  List<Module> get imports =>
      modules.expand((module) => module.imports).toList();

  @override
  List<Bind> get binds => [
        ...overrides,
        ...modules.expand((module) => module.binds),
      ];

  @override
  List<ModularRoute> get routes => [
        if (home != null) ChildRoute('/', child: (_, __) => home!),
        ...modules.expand((module) => module.routes),
      ];
}
