import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../../../filters/states/filter_state.dart';
import 'pages/profile_skill_initial_widget.dart';
import 'pages/profile_skill_loaded_widget.dart';
import 'profile_skill_controller.dart';

class ProfileSkillPage extends StatefulWidget {
  const ProfileSkillPage({Key? key, required this.controller})
      : super(key: key);

  final ProfileSkillController controller;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<ProfileSkillPage> with SnackBarHandler {
  ProfileSkillController get _controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return pageBuilder(_controller.currentState);
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
        onResetAction: _controller.reset,
        onApplyFilterAction: _controller.setTags,
      ),
    );
  }
}
