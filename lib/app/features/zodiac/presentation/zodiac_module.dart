import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/audio_record_services.dart';
import '../../../core/managers/audio_sync_manager.dart';
import '../../../core/managers/local_store.dart';
import '../../../core/managers/location_services.dart';
import '../../../core/managers/modules_sevices.dart';
import '../../../core/network/api_client.dart';
import '../../appstate/domain/entities/user_profile_entity.dart';
import '../../help_center/data/repositories/guardian_repository.dart';
import '../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../domain/usecases/stealth_security_action.dart';
import 'zodiac_controller.dart';
import 'zodiac_page.dart';

class ZodiacModule extends WidgetModule {
  ZodiacModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => ZodiacController(
            userProfileStore: i.get<LocalStore<UserProfileEntity>>(),
            securityAction: i.get<StealthSecurityAction>(),
          ),
        ),
        Bind.factory(
          (i) => StealthSecurityAction(
            audioServices: i.get<IAudioRecordServices>(),
            featureToggle: i.get<SecurityModeActionFeature>(),
            locationService: i.get<ILocationServices>(),
            guardianRepository: i.get<IGuardianRepository>(),
          ),
        ),
        Bind.factory<SecurityModeActionFeature>(
          (i) => SecurityModeActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
        Bind.factory<IGuardianRepository>(
          (i) => GuardianRepository(apiProvider: i.get<IApiProvider>()),
        ),
        Bind.factory<ILocationServices>(
          (i) => LocationServices(),
        ),
        Bind.factory<IAudioRecordServices>(
          (i) => AudioRecordServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
        ),
      ];

  @override
  Widget get view => ZodiacPage(
      controller: ZodiacController(
          securityAction: Modular.get<StealthSecurityAction>(),
          userProfileStore: Modular.get<LocalStore<UserProfileEntity>>()));
}
