import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/notification/domain/states/notification_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';

import 'notification_controller.dart';

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Observer(
          builder: (_) {
            return bodyBuilder(controller.state);
          },
        ),
      ),
    );
  }
}

extension _SupportCenterPageStateBuilder on _NotificationState {
  Widget bodyBuilder(NotificationState state) {
    return state.when(
      initial: () => Container(color: Colors.yellowAccent),
      loaded: () => Container(color: Colors.redAccent),
      error: (message) => SupportCenterGeneralError(
        message: message,
        onPressed: controller.retry,
      ),
    );
  }
}
