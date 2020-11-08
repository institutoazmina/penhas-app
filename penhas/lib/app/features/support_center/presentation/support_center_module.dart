import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import 'add/support_center_add_controller.dart';
import 'list/support_center_list_controller.dart';
import 'location/support_center_location_controller.dart';
import 'show/support_center_show_controller.dart';
import 'support_center_page.dart';
import 'support_center_controller.dart';

class SupportCenterModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => SupportCenterController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind<SupportCenterUseCase>(
          (i) => SupportCenterUseCase(
            locationService: i.get<ILocationServices>(),
            supportCenterRepository: i.get<ISupportCenterRepository>(),
          ),
        ),
        Bind<ISupportCenterRepository>(
          (i) => SupportCenterRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind(
          (i) => SupportCenterAddController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind(
          (i) => SupportCenterListController(i.args.data),
          singleton: false,
        ),
        Bind(
          (i) => SupportCenterLocationController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
          singleton: false,
        ),
        Bind((i) => SupportCenterShowController()),
      ];

  @override
  Widget get view => SupportCenterPage();

  static Inject get to => Inject<SupportCenterModule>.of();
}
