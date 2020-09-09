import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/main_menu/domain/usecases/user_profile.dart';

part 'penhas_drawer_controller.g.dart';

class PenhasDrawerController extends _PenhasDrawerControllerBase
    with _$PenhasDrawerController {
  PenhasDrawerController({
    @required IAppConfiguration appConfigure,
    @required UserProfile userProfile,
  }) : super(
          appConfigure,
          userProfile,
        );
}

abstract class _PenhasDrawerControllerBase with Store {
  final UserProfile _userProfile;
  final IAppConfiguration _appConfigure;

  _PenhasDrawerControllerBase(
    this._appConfigure,
    this._userProfile,
  );

  @action
  void logoutPressed() {
    // appConfigure.logout();
    // Modular.to.pushReplacementNamed('/');
  }
}
