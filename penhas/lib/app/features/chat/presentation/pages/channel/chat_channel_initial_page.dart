import 'package:flutter/material.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatChannelInitialPage extends StatelessWidget {
  const ChatChannelInitialPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageProgressIndicator(
      progressMessage: 'Carregando...',
      progressState: PageProgressState.loading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: DesignSystemColors.easterPurple,
          title: Text("Chat"),
        ),
        body: Container(),
      ),
    );
  }
}
