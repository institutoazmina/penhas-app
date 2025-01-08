import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../states/filter_state.dart';
import 'filter_controller.dart';
import 'pages/filter_initial_state_page.dart';
import 'pages/filter_loaded_state_page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends ModularState<FilterPage, FilterController>
    with SnackBarHandler {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return pageBuilder(controller.currentState);
      },
    );
  }
}

extension _FilterPageStateMethods on _FilterPageState {
  Widget pageBuilder(FilterState state) {
    return state.when(
      initial: () => const FilterInitialStatePage(),
      loaded: (skill) => FilterLoadedStatePage(
        tags: skill,
        onResetAction: controller.reset,
        onApplyFilterAction: controller.setTags,
      ),
    );
  }
}
