import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/managers/local_store.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../../shared/navigation/app_route.dart';
import '../../../appstate/domain/entities/user_profile_entity.dart';
import '../../../zodiac/domain/entities/izodiac.dart';
import '../../../zodiac/domain/entities/zodiac_sign_aquarius.dart';
import '../../../zodiac/domain/usecases/stealth_security_action.dart';
import '../../../zodiac/domain/usecases/zodiac.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/usecases/authenticate_user.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/password_validator.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../shared/map_failure_message.dart';
import '../shared/page_progress_indicator.dart';

part 'sign_in_stealth_controller.g.dart';

class SignInStealthController = _SignInStealthController
    with _$SignInStealthController;

abstract class _SignInStealthController with Store, MapFailureMessage {
  _SignInStealthController(
      {required AuthenticateStealthUser authenticateUser,
      required LocalStore<UserProfileEntity> userProfileStore,
      required StealthSecurityAction securityAction,
      required PasswordValidator passwordValidator})
      : _authenticateUser = authenticateUser,
        _userProfileStore = userProfileStore,
        _securityAction = securityAction,
        _passwordValidator = passwordValidator {
    _init();
    _password = SignInPassword('', _passwordValidator);
  }

  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final LocalStore<UserProfileEntity> _userProfileStore;
  final AuthenticateStealthUser _authenticateUser;
  final StealthSecurityAction _securityAction;
  final PasswordValidator _passwordValidator;

  EmailAddress _emailAddress = EmailAddress('');
  SignInPassword? _password;
  bool _isSecurityRunning = false;
  StreamSubscription? _streamCache;

  Future<void> _init() async {
    final profile = await _userProfileStore.retrieve();
    _emailAddress = EmailAddress(profile.email);
    userEmail = profile.email;
    userGreetings = 'Bem-vinda, ${profile.nickname}';

    final zodiac = Zodiac();
    sign = zodiac.sign(profile.birthdate);
    signList = zodiac.pickEightRandomSign(profile.birthdate).asObservable();

    _registerDataSource();
  }

  @observable
  ObservableFuture<Either<Failure, SessionEntity>>? _progress;

  @observable
  String userGreetings = '';

  @observable
  String? userEmail = '';

  @observable
  String warningPassword = '';

  @observable
  String? errorMessage = '';

  @observable
  IZodiac sign = ZodiacSignAquarius();

  @observable
  ObservableList<IZodiac> signList = ObservableList<IZodiac>();

  @observable
  bool isSecurityRunning = false;

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setPassword(String password) {
    _password = SignInPassword(password, _passwordValidator);
    warningPassword = _password!.mapFailure;
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    errorMessage = '';

    if (!_emailAddress.isValid || !_password!.isValid) {
      errorMessage = _invalidFieldsToProceedLogin;
      return;
    }

    _progress = ObservableFuture(
      _authenticateUser(
        email: _emailAddress,
        password: _password!,
      ),
    );

    final Either<Failure, SessionEntity> response = await _progress!;

    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) => _forwardToLogged(),
    );
  }

  @action
  Future<void> changeAccount() async {
    Modular.to.pushNamed('/authentication');
  }

  @action
  Future<void> resetPasswordPressed() async {
    Modular.to.pushNamed('/authentication/reset_password');
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

  Future<void> _forwardToLogged() async {
    AppNavigator.tryPopOrPushReplacement(AppRoute('/mainboard'));
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
