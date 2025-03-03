import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../domain/entities/support_center_place_detail_entity.dart';
import '../../domain/entities/support_center_place_entity.dart';
import '../../domain/states/support_center_show_state.dart';
import '../../domain/usecases/support_center_usecase.dart';

part 'support_center_show_controller.g.dart';

class SupportCenterShowController extends _SupportCenterShowControllerBase
    with _$SupportCenterShowController {
  SupportCenterShowController({
    required SupportCenterUseCase supportCenterUseCase,
    required SupportCenterPlaceEntity? place,
  }) : super(place, supportCenterUseCase);
}

abstract class _SupportCenterShowControllerBase with Store, MapFailureMessage {
  _SupportCenterShowControllerBase(this._place, this._useCase);

  final SupportCenterUseCase _useCase;
  final SupportCenterPlaceEntity? _place;

  @observable
  SupportCenterShowState state = const SupportCenterShowState.initial();

  @action
  Future<void> onRate(double value) async {
    await _useCase.rating(place: _place, rate: value);
  }

  @action
  Future<void> retry() async {
    setup();
  }

  Future<void> initialize() async {
    await setup();
  }
}

extension _PrivateMethods on _SupportCenterShowControllerBase {
  Future<void> setup() async {
    final result = await _useCase.detail(_place);
    result.fold(
      (failure) => handleStateError(failure),
      (detail) => handleLoadDetailSuccess(detail),
    );
  }

  Future<void> handleLoadDetailSuccess(
    SupportCenterPlaceDetailEntity detail,
  ) async {
    state = SupportCenterShowState.loaded(detail);
  }

  void handleStateError(Failure f) {
    state = SupportCenterShowState.error(mapFailureMessage(f));
  }
}
