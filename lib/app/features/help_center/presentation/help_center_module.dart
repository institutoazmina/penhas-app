import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/app_configuration.dart';
import '../../../core/managers/audio_record_services.dart';
import '../../../core/managers/location_services.dart';
import '../../../core/managers/modules_sevices.dart';
import '../data/repositories/guardian_repository.dart';
import '../domain/usecases/security_mode_action_feature.dart';
import 'help_center_controller.dart';
import 'help_center_page.dart';
import 'pages/audio/audio_record_controller.dart';

class HelpCenterModule extends WidgetModule {
  HelpCenterModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => HelpCenterController(
            locationService: i.get<ILocationServices>(),
            appConfiguration: i.get<IAppConfiguration>(),
            guardianRepository: i.get<IGuardianRepository>(),
            featureToogle: i.get<SecurityModeActionFeature>(),
            audioServices: i.get<IAudioRecordServices>(),
          ),
        ),
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory(
          (i) => AudioRecordController(
            featureToogle: i.get<SecurityModeActionFeature>(),
            audioServices: i.get<IAudioRecordServices>(),
          ),
        ),
      ];

  @override
  Widget get view => const HelpCenterPage();
}
