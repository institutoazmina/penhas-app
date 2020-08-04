import 'package:flutter/material.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_page.dart';

class HelpCenterModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => HelpCenterController(
              guardianRepository: i.get<IGuardianRepository>(),
              locationService: i.get<ILocationServices>()),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HelpCenterPage()),
      ];

  static Inject get to => Inject<HelpCenterModule>.of();

  @override
  Widget get view => HelpCenterPage();
}
