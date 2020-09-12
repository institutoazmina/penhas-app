import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';

part 'sign_in_anonymous_controller.g.dart';

class SignInAnonymousController extends _SignInAnonymousController
    with _$SignInAnonymousController {
  SignInAnonymousController(IAuthenticationRepository repository)
      : super(repository);
}

abstract class _SignInAnonymousController with Store, MapFailureMessage {
  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final IAuthenticationRepository repository;
  EmailAddress _emailAddress = EmailAddress("");
  Password _password = Password("");

  _SignInAnonymousController(this.repository);

  @observable
  ObservableFuture<Either<Failure, SessionEntity>> _progress;

  @observable
  String warningEmail = "";

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
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    warningEmail = address.length == 0 ? '' : _emailAddress.mapFailure;
  }

  @action
  void setPassword(String password) {
    _password = Password(password);

    warningPassword = password.length == 0 ? '' : _password.mapFailure;
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    _setErrorMessage('');

    if (!_emailAddress.isValid || !_password.isValid) {
      _setErrorMessage(_invalidFieldsToProceedLogin);
      return;
    }

    _progress = ObservableFuture(repository.signInWithEmailAndPassword(
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
    Modular.to.pushReplacementNamed('/');
  }

  void _setErrorMessage(String msg) {
    errorMessage = msg;
  }
}
