import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.network(
                  notification.icon,
                  height: 24,
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Text(notification.name, style: titleTextStyle),
                      Text(timeago.format(notification.time, locale: 'pt_br'),
                          style: timeTextStyle),
                    ],
                  ),
                ),
                Text(notification.title, style: titleTextStyle),
              ],
            ),
            _notificationContent(notification.content),
          ],
        ),
      ),
    );
  }

  Widget _notificationContent(String content) {
    if (content?.isEmpty ?? true) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: HtmlWidget(
        notification.content,
        webViewJs: false,
        textStyle: contentTextStyle,
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

  TextStyle get contentTextStyle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      fontWeight: FontWeight.normal);
}
