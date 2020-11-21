import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCardPage extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationCardPage({Key key, @required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DesignSystemColors.pinkishGrey,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SvgPicture.network(
                    notification.icon,
                    height: 24,
                    width: 24,
                  ),
                ),
                Column(
                  children: [
                    Text(notification.name, style: titleTextStyle),
                    Text(timeago.format(notification.time, locale: 'pt_br'),
                        style: timeTextStyle),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(notification.title, style: titleTextStyle),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

extension _TextStyle on NotificationCardPage {
  TextStyle get titleTextStyle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      fontWeight: FontWeight.normal);

  TextStyle get timeTextStyle => TextStyle(
      color: DesignSystemColors.warnGrey,
      fontFamily: 'Lato',
      fontSize: 12.0,
      fontWeight: FontWeight.normal);
}
