import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/edit/edit_trusted_contacts_controller.dart';
import 'presentation/edit/edit_trusted_contacts_page.dart';
import 'presentation/escape_manual_controller.dart';
import 'presentation/escape_manual_page.dart';

class EscapeManualModule extends WidgetModule {
  EscapeManualModule({super.key});

  @override
  Widget get view => EscapeManualPage(
        controller: Modular.get<EscapeManualController>(),
      );

  @override
  // ignore: override_on_non_overriding_member
  List<ModularRoute> get routes => [
        ChildRoute(
          '/edit/trusted_contacts',
          child: (_, __) => EditTrustedContactsPage(
            controller: Modular.get<EditTrustedContactsController>(),
          ),
        )
      ];

  @override
  final List<Bind<Object>> binds = [];
}
