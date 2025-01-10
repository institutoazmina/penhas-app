import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../../../filters/states/filter_state.dart';
import 'pages/profile_skill_initial_widget.dart';
import 'pages/profile_skill_loaded_widget.dart';
import 'profile_skill_controller.dart';

class ProfileSkillPage extends StatefulWidget {
  const ProfileSkillPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState
    extends ModularState<ProfileSkillPage, ProfileSkillController>
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
      initial: () => const ProfileSkillInitialWidget(),
      loaded: (skill) => ProfileSkillLoadedWidget(
        tags: skill,
        onResetAction: controller.reset,
        onApplyFilterAction: controller.setTags,
      ),
    );
  }
}
