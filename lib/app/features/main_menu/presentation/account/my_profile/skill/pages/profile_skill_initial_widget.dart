import 'package:flutter/material.dart';

import '../../../../../../../shared/design_system/colors.dart';
import '../../../../../../authentication/presentation/shared/page_progress_indicator.dart';

class ProfileSkillInitialWidget extends StatelessWidget {
  const ProfileSkillInitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.ligthPurple,
        title: const Text('Habilidades'),
      ),
      body: PageProgressIndicator(
        progressMessage: 'Carregando...',
        progressState: PageProgressState.loading,
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }
}
