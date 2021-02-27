import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/presentation/widget/RequestLocationPermissionContentWidget.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_state.dart';
part 'stealth_mode_tutorial_page_controller.g.dart';

class StealthModeTutorialPageController extends _StealthModeTutorialPageControllerBase
    with _$StealthModeTutorialPageController {
  StealthModeTutorialPageController({
    @required ILocationServices locationService,
  }) : super(locationService);
}

abstract class _StealthModeTutorialPageControllerBase with Store {
  final ILocationServices _locationService;

  _StealthModeTutorialPageControllerBase(this._locationService) {
    _loadState();
  }

  @observable
  StealthModeTutorialState state = StealthModeTutorialState(locationPermissionGranted: false);

  Future<void> _loadState() async {
    final isPermissionGranted = await _locationService.isPermissionGranted();
    state = StealthModeTutorialState(locationPermissionGranted: isPermissionGranted);
  }

  void requestLocationPermission() {
    _locationService
        .requestPermission(
        title: 'O guardião precisa da sua localização',
        description: RequestLocationPermissionContentWidget());
  }
}