import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_controller.dart';
import 'package:penhas/app/features/support_center/presentation/list/support_center_list_controller.dart';
import 'package:penhas/app/features/support_center/presentation/location/support_center_location_controller.dart';
import 'package:penhas/app/features/support_center/presentation/show/support_center_show_controller.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_controller.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_page.dart';

class SupportCenterModule extends WidgetModule {
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
          (i) => SupportCenterLocationController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
          ),
                  ),
        Bind.factory(
          (i) => SupportCenterShowController(
            supportCenterUseCase: i.get<SupportCenterUseCase>(),
            place: i.args?.data,
          ),
        ),
      ];

  @override
  Widget get view => SupportCenterPage();
}
