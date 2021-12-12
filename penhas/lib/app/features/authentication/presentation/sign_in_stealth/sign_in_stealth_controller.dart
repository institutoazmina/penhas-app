import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/zodiac.dart';

part 'sign_in_stealth_controller.g.dart';

class SignInStealthController extends _SignInStealthController
    with _$SignInStealthController {
  SignInStealthController({
    required IAuthenticationRepository repository,
    required LocalStore<UserProfileEntity> userProfileStore,
    required StealthSecurityAction securityAction,
    required PasswordValidator passwordValidator,
  }) : super(repository, userProfileStore, securityAction, passwordValidator);
}

abstract class _SignInStealthController with Store, MapFailureMessage {
  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final LocalStore<UserProfileEntity> _userProfileStore;
  final IAuthenticationRepository _repository;
  final StealthSecurityAction _securityAction;
  final PasswordValidator _passwordValidator;

  EmailAddress _emailAddress = EmailAddress("");
  SignInPassword? _password;
  bool _isSecurityRunning = false;
  StreamSubscription? _streamCache;

  _SignInStealthController(
    this._repository,
    this._userProfileStore,
    this._securityAction,
    this._passwordValidator,
  ) {
    _init();
    _password = SignInPassword('', _passwordValidator);
  }

  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final LocalStore<UserProfileEntity> _userProfileStore;
  final IAuthenticationRepository _repository;
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
    final _userProfile = await _userProfileStore.retrieve();
    sign = zodiac.sign(_userProfile.birthdate);
    signList =
        zodiac.pickEigthRandonSign(_userProfile.birthdate).asObservable();

    _registerDataSource();
  }

  @observable
  ObservableFuture<Either<Failure, SessionEntity>>? _progress;

  @observable
  String userGreetings = '';

  @observable
  String? userEmail = "";

  @observable
  String warningPassword = '';

  @observable
  String? errorMessage = "";

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
    _setErrorMessage('');

    if (!_emailAddress.isValid || !_password!.isValid) {
      _setErrorMessage(_invalidFieldsToProceedLogin);
      return;
    }
    errorMessage = '';

    _progress = ObservableFuture(
      _repository.signInWithEmailAndPassword(
        emailAddress: _emailAddress,
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
    Modular.to.pushReplacementNamed('/mainboard');
  }

  void _setErrorMessage(String? msg) {
    errorMessage = msg;
  }

  _registerDataSource() {
    _streamCache = _securityAction.isRunning.listen((event) {
      isSecurityRunning = event;
    });
  }

  _cancelDataSource() {
    if (_streamCache != null) {
      _streamCache!.cancel();
      _streamCache = null;
    }
  }
}
