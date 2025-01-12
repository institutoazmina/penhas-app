import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/managers/location_services.dart';
import '../../../core/network/api_client.dart';
import '../data/repositories/support_center_repository.dart';
import '../domain/usecases/support_center_usecase.dart';
import 'add/support_center_add_controller.dart';
import 'list/support_center_list_controller.dart';
import 'show/support_center_show_controller.dart';
import 'support_center_controller.dart';
import 'support_center_page.dart';

class SupportCenterModule extends WidgetModule {
  SupportCenterModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => SupportCenterController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind.factory<SupportCenterUseCase>(
          (i) => SupportCenterUseCase(
            locationService: i.get<ILocationServices>(),
            supportCenterRepository: i.get<ISupportCenterRepository>(),
          ),
        ),
        Bind.factory<ISupportCenterRepository>(
          (i) => SupportCenterRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
        Bind.factory(
          (i) => SupportCenterAddController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
        ),
        Bind.factory(
          (i) => SupportCenterListController(i.args?.data),
        ),
        Bind.factory(
          (i) => SupportCenterShowController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
            place: i.args?.data,
          ),
        ),
      ];

  @override
  Widget get view => SupportCenterPage(
        controller: Modular.get<SupportCenterController>(),
      );
}
