import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
part 'support_center_list_controller.g.dart';

class SupportCenterListController extends _SupportCenterListControllerBase
    with _$SupportCenterListController {
  SupportCenterListController(SupportCenterPlaceSessionEntity session)
      : super(session);
}

abstract class _SupportCenterListControllerBase with Store {
  _SupportCenterListControllerBase(this._session) {
    places = _session.places.asObservable();
  }

  final SupportCenterPlaceSessionEntity _session;

  @observable
  ObservableList<SupportCenterPlaceEntity> places =
      ObservableList<SupportCenterPlaceEntity>();

  @action
  void selected(SupportCenterPlaceEntity place) {
    Modular.to.pushNamed(
      '/mainboard/supportcenter/show',
      arguments: place,
    );
  }
}

// Future<void> onKeywordsAction(String keywords) async {
//   _fetchRequest = _fetchRequest.copyWith(keywords: keywords);

//   await loadSupportCenter(_fetchRequest);
// }

/*
          Modular.to.pushNamed(
            "/mainboard/supportcenter/show",
            arguments: place,
          );
*/
