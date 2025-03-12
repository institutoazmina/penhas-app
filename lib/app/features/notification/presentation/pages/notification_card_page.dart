import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../shared/design_system/colors.dart';
import '../../domain/entities/notification_session_entity.dart';

class NotificationCardPage extends StatelessWidget {
  const NotificationCardPage({Key? key, required this.notification})
      : super(key: key);

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: DesignSystemColors.pinkishGrey,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            Modular.to.pushNamed(notification.route!);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    notification.icon == null || notification.icon!.isEmpty
                        ? Container()
                        : SvgPicture.network(
                            notification.icon!,
                            height: 24,
                            width: 24,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Text(notification.name!,
                                      style: titleTextStyle),
                                ),
                                Text(notification.title!,
                                    style: titleTextStyle),
                              ],
                            ),
                          ),
                          Text(
                            timeago.format(notification.time!, locale: 'pt_br'),
                            style: timeTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _notificationContent(notification.content),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationContent(String? content) {
    if (content?.isEmpty ?? true) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 38),
      child: SizedBox.shrink(),
      // TODO: HtmlWidget(
      //   notification.content!,
      //   factoryBuilder: () => DisabledWebViewJsWidgetFactory(),
      //   textStyle: contentTextStyle,
      // ),
    );
  }
}

extension _TextStyle on NotificationCardPage {
  TextStyle get titleTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get timeTextStyle => const TextStyle(
        color: DesignSystemColors.warnGrey,
        fontFamily: 'Lato',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get contentTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      );
}

// TODO: class DisabledWebViewJsWidgetFactory extends WidgetFactory {
//   @override
//   bool get webViewJs => false;
// }
