import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_show_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

part 'support_center_show_controller.g.dart';

class SupportCenterShowController extends _SupportCenterShowControllerBase
    with _$SupportCenterShowController {
  SupportCenterShowController({
    required SupportCenterUseCase supportCenterUseCase,
    required SupportCenterPlaceEntity? place,
  }) : super(place, supportCenterUseCase);
}

abstract class _SupportCenterShowControllerBase with Store, MapFailureMessage {
  _SupportCenterShowControllerBase(this._place, this._useCase) {
    setup();
  }

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
      SupportCenterPlaceDetailEntity detail,) async {
    state = SupportCenterShowState.loaded(detail);
  }

  void handleStateError(Failure f) {
    state = SupportCenterShowState.error(mapFailureMessage(f)!);
  }
}
