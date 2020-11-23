import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController extends _ProfileEditControllerBase
    with _$ProfileEditController {
  ProfileEditController({@required AppStateUseCase appStateUseCase})
      : super(appStateUseCase);
}

abstract class _ProfileEditControllerBase with Store {
  final AppStateUseCase _appStateUseCase;

  _ProfileEditControllerBase(this._appStateUseCase);
}
