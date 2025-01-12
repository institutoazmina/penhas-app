import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/design_system/colors.dart';
import '../../../shared/design_system/text_styles.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../support_center/presentation/pages/support_center_general_error.dart';
import '../domain/entities/notification_session_entity.dart';
import '../domain/states/notification_state.dart';
import 'notification_controller.dart';
import 'pages/notification_card_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final NotificationController controller;

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> with SnackBarHandler {
  // Getter para acessar o controller
  NotificationController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
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
    return const SafeArea(
      child: Center(
        child: Text(
          'Você não tem notificações',
          style: kTextEmptyList,
        ),
      ),
    );
  }

  Widget buildInitialState() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: 'Carregando...',
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
