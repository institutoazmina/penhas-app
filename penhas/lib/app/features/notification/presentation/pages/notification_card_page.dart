import 'package:flutter/material.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

class NotificationCardPage extends StatelessWidget {
  final NotificationEntity notification;
  const NotificationCardPage({Key key, @required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(notification.content),
    );
  }
}
