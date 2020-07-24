import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';

part 'mainboard_controller.g.dart';

class MainboardController extends _MainboardControllerBase
    with _$MainboardController {
  MainboardController({
    @required IAppConfiguration appConfigure,
    @required MainboardStore mainboardStore,
    @required IUserProfileStore userProfileStore,
  }) : super(
          appConfigure,
          mainboardStore,
          userProfileStore,
        );
}

abstract class _MainboardControllerBase with Store {
  final MainboardStore mainboardStore;
  final IAppConfiguration _appConfigure;
  final IUserProfileStore _userProfileStore;

  _MainboardControllerBase(
    this._appConfigure,
    this.mainboardStore,
    this._userProfileStore,
  );

  Future<String> get userName => _getUserName();
  Future<String> get userAvatar => _getUserAvatar();

  @observable
  int selectedIndex = 0;

  @action
  void logoutPressed() {
    _appConfigure.logout();
    _userProfileStore.delete();
    Modular.to.pushReplacementNamed('/');
  }

  Future<String> _getUserName() async {
    if (_userProfileStore == null) {
      return "";
    }

    return _userProfileStore
        .retreive()
        .then((v) => v.nickname)
        .catchError(_handleError);
  }

  Future<String> _getUserAvatar() async {
    if (_userProfileStore == null) {
      return "";
    }

    return _userProfileStore
        .retreive()
        .then((v) => v.avatar)
        .catchError(_handleError);
  }

  Future<String> _handleError(Object error) async {
    return "";
  }
}
