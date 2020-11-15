import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'notification_page.dart';

class NotificationModule extends WidgetModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get view => NotificationPage();

  static Inject get to => Inject<NotificationModule>.of();
}
