import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../states/filter_state.dart';
import 'filter_controller.dart';
import 'pages/filter_initial_state_page.dart';
import 'pages/filter_loaded_state_page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key, required this.controller});

  final FilterController controller;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with SnackBarHandler {
  FilterController get _controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return pageBuilder(_controller.currentState);
      },
    );
  }
}

extension _FilterPageStateMethods on FilterPageState {
  Widget pageBuilder(FilterState state) {
    return state.when(
      initial: () => const FilterInitialStatePage(),
      loaded: (skill) => FilterLoadedStatePage(
        tags: skill,
        onResetAction: _controller.reset,
        onApplyFilterAction: _controller.setTags,
      ),
    );
  }
}
