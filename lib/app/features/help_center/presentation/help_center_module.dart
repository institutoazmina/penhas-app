import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/app_configuration.dart';
import '../../../core/managers/audio_record_services.dart';
import '../../../core/managers/location_services.dart';
import '../data/repositories/guardian_repository.dart';
import '../domain/usecases/security_mode_action_feature.dart';
import 'help_center_controller.dart';
import 'help_center_page.dart';

class HelpCenterModule extends WidgetModule {
  HelpCenterModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [];

  @override
  Widget get view => HelpCenterPage(
        controller: HelpCenterController(
            appConfiguration: Modular.get<IAppConfiguration>(),
            audioServices: Modular.get<IAudioRecordServices>(),
            featureToogle: Modular.get<SecurityModeActionFeature>(),
            guardianRepository: Modular.get<IGuardianRepository>(),
            locationService: Modular.get<ILocationServices>()),
      );
}
