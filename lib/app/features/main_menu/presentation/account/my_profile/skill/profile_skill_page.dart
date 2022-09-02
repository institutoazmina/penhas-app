import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/filters/states/filter_state.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/pages/profile_skill_initial_state_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/pages/profile_skill_loaded_state_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/profile_skill_controller.dart';

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
      initial: () => const ProfileSkillInitialStatePage(),
      loaded: (skill) => ProfilSkillLoadedStatePage(
        tags: skill,
        onResetAction: controller.reset,
        onAplyFilterAction: controller.setTags,
      ),
    );
  }
}
