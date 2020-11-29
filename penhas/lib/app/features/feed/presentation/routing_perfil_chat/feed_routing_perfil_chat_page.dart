import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/states/feed_routing_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'feed_routing_perfil_chat_controller.dart';

class FeedRoutingPerfilChatPage extends StatefulWidget {
  FeedRoutingPerfilChatPage({Key key}) : super(key: key);

  @override
  _FeedRoutingPerfilChatPageState createState() =>
      _FeedRoutingPerfilChatPageState();
}

class _FeedRoutingPerfilChatPageState extends ModularState<
    FeedRoutingPerfilChatPage, FeedRoutingPerfilChatController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => pageBuilder(controller.routingState));
  }
}

extension _Bodybuilder on _FeedRoutingPerfilChatPageState {
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
      ),
      body: SafeArea(
        child: PageProgressIndicator(
          progressState: PageProgressState.loading,
          progressMessage: "Carregando...",
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
      ),
      body: SafeArea(
        child: SupportCenterGeneralError(
          message: message,
          onPressed: controller.retry,
        ),
      ),
    );
  }
}
