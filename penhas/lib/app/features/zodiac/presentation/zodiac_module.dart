import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_controller.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_page.dart';

class ZodiacModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ZodiacController(
            userProfileStore: i.get<IUserProfileStore>(),
            securityAction: i.get<StealthSecurityAction>(),
          ),
          singleton: false,
        ),
        Bind(
          (i) => StealthSecurityAction(
              audioServices: i.get<IAudioRecordServices>(),
              featureToogle: i.get<HelpCenterCallActionFeature>(),
              locationService: i.get<ILocationServices>(),
              guardianRepository: i.get<IGuardianRepository>()),
          singleton: false,
        ),
        Bind<HelpCenterCallActionFeature>(
          (i) => HelpCenterCallActionFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
          singleton: false,
        ),
        Bind<IGuardianRepository>(
          (i) => GuardianRepository(
            dataSource: i.get<IGuardianDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
          singleton: false,
        ),
        Bind<ILocationServices>(
          (i) => LocationServices(),
          singleton: false,
        ),
        Bind<IGuardianDataSource>(
          (i) => GuardianDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
          singleton: false,
        ),
        Bind<IAudioRecordServices>(
          (i) => AudioRecordServices(
            audioSyncManager: i.get<IAudioSyncManager>(),
          ),
          singleton: false,
        ),
      ];

  static Inject get to => Inject<ZodiacModule>.of();

  @override
  Widget get view => ZodiacPage();
}
