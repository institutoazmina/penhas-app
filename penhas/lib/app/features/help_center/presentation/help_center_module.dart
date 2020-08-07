import 'package:flutter/material.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_page.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_record_controller.dart';

class HelpCenterModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => HelpCenterController(
            locationService: i.get<ILocationServices>(),
            appConfiguration: i.get<IAppConfiguration>(),
            guardianRepository: i.get<IGuardianRepository>(),
            helpCenterCallActionFeature: i.get<HelpCenterCallActionFeature>(),
          ),
        ),
        Bind<HelpCenterCallActionFeature>(
          (i) => HelpCenterCallActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind(
          (i) => AudioRecordController(),
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
