import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
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

part 'sign_in_anonymous_controller.g.dart';

class SignInAnonymousController extends _SignInAnonymousController
    with _$SignInAnonymousController {
  SignInAnonymousController({
    @required IAuthenticationRepository repository,
    @required LocalStore<UserProfileEntity> userProfileStore,
    @required PasswordValidator passwordValidator,
  }) : super(repository, userProfileStore, passwordValidator);
}

abstract class _SignInAnonymousController with Store, MapFailureMessage {
  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final LocalStore<UserProfileEntity> _userProfileStore;
  final IAuthenticationRepository _repository;
  final PasswordValidator _passwordValidator;

  EmailAddress _emailAddress = EmailAddress("");
  SignInPassword _password;

  _SignInAnonymousController(
      this._repository, this._userProfileStore, this._passwordValidator) {
    _init();
    _password = SignInPassword('', _passwordValidator);
  }

  void _init() async {
    final profile = await _userProfileStore.retrieve();
    _emailAddress = EmailAddress(profile.email);
    userEmail = profile.email;
    userGreetings = "Bem-vinda, ${profile.nickname}";
  }

  @observable
  ObservableFuture<Either<Failure, SessionEntity>> _progress;

  @observable
  String userGreetings = "";

  @observable
  String userEmail = "";

  @observable
  String warningPassword = "";

  @observable
  String errorMessage = "";

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setPassword(String password) {
    _password = SignInPassword(password, _passwordValidator);
    warningPassword = _password.mapFailure;
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    _setErrorMessage('');

    if (!_emailAddress.isValid || !_password.isValid) {
      _setErrorMessage(_invalidFieldsToProceedLogin);
      return;
    }

    _progress = ObservableFuture(_repository.signInWithEmailAndPassword(
      emailAddress: _emailAddress,
      password: _password,
    ));

    final response = await _progress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
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

  Future<void> _forwardToLogged() async {
    Modular.to.pushReplacementNamed('/mainboard');
  }

  void _setErrorMessage(String msg) {
    errorMessage = msg;
  }
}
