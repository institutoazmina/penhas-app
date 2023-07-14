import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../authentication/presentation/shared/page_progress_indicator.dart';

class ChatChannelInitialPage extends StatelessWidget {
  const ChatChannelInitialPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
        title: const Text('Chat'),
      ),
      body: PageProgressIndicator(
        progressMessage: 'Carregando...',
        progressState: PageProgressState.loading,
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }
}
