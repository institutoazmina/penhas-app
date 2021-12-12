import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_controller.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_page.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_record_controller.dart';

class HelpCenterModule extends WidgetModule {
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
<<<<<<< HEAD
  Widget get view => const HelpCenterPage();
=======
  Widget get view => HelpCenterPage();
>>>>>>> Fix code syntax
}
