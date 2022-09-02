import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/presentation/widget/request_location_permission_content_widget.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_state.dart';
part 'stealth_mode_tutorial_page_controller.g.dart';

class StealthModeTutorialPageController
    extends _StealthModeTutorialPageControllerBase
    with _$StealthModeTutorialPageController {
  StealthModeTutorialPageController({
    required ILocationServices locationService,
  }) : super(locationService);
}

abstract class _StealthModeTutorialPageControllerBase with Store {
  _StealthModeTutorialPageControllerBase(this._locationService) {
    _loadState();
  }

  final ILocationServices _locationService;

  @observable
  StealthModeTutorialState state =
      const StealthModeTutorialState(locationPermissionGranted: false);

  Future<void> _loadState() async {
    final isPermissionGranted = await _locationService.isPermissionGranted();
    state = StealthModeTutorialState(
      locationPermissionGranted: isPermissionGranted,
    );
  }

  void requestLocationPermission() {
    _locationService.requestPermission(
      title: 'O guardião precisa da sua localização',
      description: RequestLocationPermissionContentWidget(),
    );
  }
}
