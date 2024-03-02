import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/src/presenters/navigation/modular_route_information_parser.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/app_module.dart';

import 'aditional_bind_module.dart';

void loadModules(
  List<Module> modules, {
  List<Bind> overrides = const [],
}) {
  modules = [
    AditionalBindModule(binds: overrides),
    ...modules,
  ];
  initModules(
    modules,
    replaceBinds: overrides,
  );

  addTearDown(() {
    modules.forEach(Modular.removeModule);
  });
}

Widget buildTestableApp({
  Widget? home,
  String? initialRoute,
  List<Module>? modules,
  List<Bind> overrides = const [],
}) {
  final testModule = _TestModule(
    home: home,
    modules: modules ?? [AppModule()],
    overrides: overrides,
  );

  addTearDown(() {
    Modular.removeModule(testModule);
  });

  return ModularApp(
    module: testModule,
    child: MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        initialRoute: initialRoute,
      ).modular(),
    ),
  );
}

class _TestModule extends Module {
  _TestModule({
    this.home,
    this.modules = const [],
    this.overrides = const [],
  }) {
    ModularRouteInformationParser.reset();
  }

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
