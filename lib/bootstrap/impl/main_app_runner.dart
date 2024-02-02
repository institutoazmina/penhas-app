import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import '../../app/app_widget.dart';
import '../bootstrap.dart';
import 'app_runner_mixin.dart';

typedef RunApp = void Function(widgets.Widget app);

class MainAppRunner extends Runner with RunnerMixin {
  @widgets.visibleForTesting
  MainAppRunner.create(this._runApp);

  factory MainAppRunner() => MainAppRunner.create(widgets.runApp);

  final RunApp _runApp;

  @override
  void run() {
    _runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }
}
