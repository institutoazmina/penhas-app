import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/states/security_toggle_state.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
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

abstract class _PenhasDrawerControllerBase with Store {
  final UserProfile _userProfile;
  final IAppConfiguration _appConfigure;
  final IAppModulesServices _modulesServices;

  _PenhasDrawerControllerBase(
      this._appConfigure, this._userProfile, this._modulesServices) {
    _init();
  }

  _init() async {
    showSecurityOptions = await _showSecurityModeToggle();
    await _updateProfileInformation();
  }

  @observable
  String userName = "";

  @observable
  String userAvatar = "";

  @observable
  bool showSecurityOptions = false;

  @observable
  SecurityToggleState stealthModeState = SecurityToggleState.empty();

  @observable
  SecurityToggleState anonymousModeState = SecurityToggleState.empty();

  @action
  void logoutPressed() {
    _appConfigure.logout();
    Modular.to.pushReplacementNamed('/');
  }

  Future<void> _toggleAnymousMode(bool toggle) async {
    anonymousModeState = _anonyousToggleState(toggle);
    final action = await _userProfile.anonymousMode(toggle);

    action.fold(
      (failure) => null,
      (success) async => _updateProfileInformation(),
    );
  }

  Future<void> _toggleStealthMode(bool toggle) async {
    stealthModeState = _stealthToggleState(toggle);
    final action = await _userProfile.stealthMode(toggle);

    action.fold(
      (failure) => null,
      (success) async => _updateProfileInformation(),
    );
  }

  Future<bool> _showSecurityModeToggle() async {
    final data = await _modulesServices.feature(
      name: SecurityModeActionFeature.featureCode,
    );

    return data != null;
  }

  Future<void> _updateProfileInformation() async {
    final profile = await _userProfile.currentProfile();
    userName = profile.nickname ?? "";
    userAvatar = profile.avatar ?? "";
    stealthModeState = _stealthToggleState(profile.stealthModeEnabled);
    anonymousModeState = _anonyousToggleState(profile.anonymousModeEnabled);
  }

  SecurityToggleState _anonyousToggleState(bool isEnabled) {
    return SecurityToggleState(
      title: 'Estou em situação de violência',
      isEnabled: isEnabled,
      onChanged: (value) async => _toggleAnymousMode(value),
    );
  }

  SecurityToggleState _stealthToggleState(bool isEnabled) {
    return SecurityToggleState(
      title: 'Modo camuflado',
      isEnabled: isEnabled,
      onChanged: (value) => _toggleStealthMode(value),
    );
  }
}
