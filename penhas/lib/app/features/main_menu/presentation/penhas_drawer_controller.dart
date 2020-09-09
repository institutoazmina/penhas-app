import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';

part 'penhas_drawer_controller.g.dart';

class PenhasDrawerController extends _PenhasDrawerControllerBase
    with _$PenhasDrawerController {
  PenhasDrawerController({
    @required IAppConfiguration appConfigure,
    @required UserProfile userProfile,
    @required IAppModulesServices modulesServices,
  }) : super(appConfigure, userProfile, modulesServices);
}

/*
  AudioSyncManager({@required IAudioSyncRepository audioRepository})
      : this._audioRepository = audioRepository {
    _init();
  }

  _init() async {
    await loadAudioQueue();
    setupUploadTimer();
  }
*/

abstract class _PenhasDrawerControllerBase with Store {
  final UserProfile _userProfile;
  final IAppConfiguration _appConfigure;
  final IAppModulesServices _modulesServices;

  _PenhasDrawerControllerBase(
      this._appConfigure, this._userProfile, this._modulesServices) {
    _init();
  }

  _init() async {
    userName = await _userProfile.userName();
    userAvatar = await _userProfile.userAvatar();
  }

  @observable
  String userName = "";

  @observable
  String userAvatar = "";

  @action
  void toggleStealthMode() {}

  @action
  void toggleAnymousMode() {}

  @action
  void logoutPressed() {
    // appConfigure.logout();
    // Modular.to.pushReplacementNamed('/');
  }

  // bool _showSecurityModeToggle() async {
  //   final data = await _modulesServices.feature(
  //       name: HelpCenterCallActionFeature.featureCode);
  // }
}
