import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

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
            supportCenterRepository: i.get<ISupportCenterRepository>(),
          ),
        ),
        Bind<ISupportCenterRepository>(
          (i) => SupportCenterRepository(
            apiProvider: i.get<IApiProvider>(),
          ),
        ),
      ];

  @override
  Widget get view => SupportCenterPage();

  static Inject get to => Inject<SupportCenterModule>.of();
}
