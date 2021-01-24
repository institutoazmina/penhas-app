import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';
import 'package:penhas/app/features/notification/domain/states/notification_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'notification_controller.dart';
import 'pages/notification_card_page.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState
    extends ModularState<NotificationPage, NotificationController>
    with SnackBarHandler {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (_) {
          return bodyBuilder(controller.state);
        },
      ),
    );
  }
}

extension _PageStateBuilder on _NotificationState {
  Widget bodyBuilder(NotificationState state) {
    return state.when(
      initial: () => buildInitialState(),
      loaded: (notifications) => buildLoaded(notifications),
      empty: () => buildEmptyState(),
      error: (message) => SupportCenterGeneralError(
        message: message,
        onPressed: controller.retry,
      ),
    );
  }

  Widget buildEmptyState() {
    return SafeArea(
      child: Center(child: Text('Você não tem notificações', style: kTextEmptyList,),),
    );
  }

  Widget buildInitialState() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando...",
        child: Container(color: DesignSystemColors.white),
      ),
    );
  }

  Widget buildLoaded(List<NotificationEntity> notifications) {
    return SafeArea(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return NotificationCardPage(
            notification: notification,
          );
        },
      ),
    );
  }
}
