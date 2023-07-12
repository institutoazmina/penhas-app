import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/zodiac.dart';

part 'zodiac_controller.g.dart';

class ZodiacController extends _ZodiacControllerBase with _$ZodiacController {
  ZodiacController({
    required LocalStore<UserProfileEntity> userProfileStore,
    required StealthSecurityAction securityAction,
  }) : super(userProfileStore, securityAction);
}

abstract class _ZodiacControllerBase with Store {
  _ZodiacControllerBase(
    this._userProfileStore,
    this._securityAction,
  ) {
    _init();
  }

  final LocalStore<UserProfileEntity> _userProfileStore;
  final StealthSecurityAction _securityAction;

  bool _isSecurityRunning = false;
  StreamSubscription? _streamCache;

  Future<void> _init() async {
    final zodiac = Zodiac();
    final _userProfile = await _userProfileStore.retrieve();
    sign = zodiac.sign(_userProfile.birthdate);
    signList =
        zodiac.pickEightRandomSign(_userProfile.birthdate).asObservable();

    _registerDataSource();
  }

  @observable
  IZodiac sign = ZodiacSignAquarius();

  @observable
  ObservableList<IZodiac> signList = ObservableList<IZodiac>();

  @observable
  bool isSecurityRunning = false;

  @action
  void forwardStealthLogin() {
    Modular.to.pushReplacementNamed('/authentication/sign_in_stealth');
  }

  @action
  void stealthAction() {
    if (_isSecurityRunning) {
      _securityAction.stop();
    } else {
      isSecurityRunning = true;
      _securityAction.start();
    }

    _isSecurityRunning = !_isSecurityRunning;
  }

  @action
  void dispose() {
    _cancelDataSource();
    _securityAction.dispose();
  }

  void _registerDataSource() {
    _streamCache = _securityAction.isRunning.listen((event) {
      isSecurityRunning = event;
    });
  }

  void _cancelDataSource() {
    _streamCache?.cancel();
    _streamCache = null;
  }
}
