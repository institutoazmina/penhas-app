import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: Modular.to.pop,
          ),
        ),
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
