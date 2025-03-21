import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../domain/states/feed_routing_state.dart';
import 'feed_routing_profile_chat_controller.dart';

class FeedRoutingProfileChatPage extends StatefulWidget {
  const FeedRoutingProfileChatPage({super.key, required this.controller});

  final FeedRoutingProfileChatController controller;

  @override
  State<FeedRoutingProfileChatPage> createState() =>
      _FeedRoutingProfileChatPageState();
}

class _FeedRoutingProfileChatPageState
    extends State<FeedRoutingProfileChatPage> {
  FeedRoutingProfileChatController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => pageBuilder(_controller.routingState));
  }
}

extension _Bodybuilder on _FeedRoutingProfileChatPageState {
  Widget pageBuilder(FeedRoutingState state) {
    return state.when(
      initial: (title) => loadingPage(title),
      error: (title, msg) => errorPage(title, msg),
    );
  }

  Widget loadingPage(String title) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: DesignSystemColors.easterPurple,
        foregroundColor: DesignSystemColors.white,
      ),
      body: SafeArea(
        child: PageProgressIndicator(
          progressState: PageProgressState.loading,
          progressMessage: 'Carregando...',
          child: Container(color: DesignSystemColors.white),
        ),
      ),
    );
  }

  Widget errorPage(String title, String message) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: DesignSystemColors.easterPurple,
        foregroundColor: DesignSystemColors.white,
      ),
      body: SafeArea(
        child: SupportCenterGeneralError(
          message: message,
          onPressed: _controller.retry,
        ),
      ),
    );
  }
}
