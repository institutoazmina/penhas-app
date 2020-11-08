import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
part 'support_center_list_controller.g.dart';

class SupportCenterListController extends _SupportCenterListControllerBase
    with _$SupportCenterListController {
  SupportCenterListController(SupportCenterPlaceSessionEntity session)
      : super(session);
}

abstract class _SupportCenterListControllerBase with Store {
  final SupportCenterPlaceSessionEntity _session;

  _SupportCenterListControllerBase(this._session) {
    places = _session.places.asObservable();
  }

  @observable
  ObservableList<SupportCenterPlaceEntity> places =
      ObservableList<SupportCenterPlaceEntity>();
}
