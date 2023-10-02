import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../../shared/navigation/app_route.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/usecases/authenticate_user.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/password_validator.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../shared/map_failure_message.dart';
import '../shared/page_progress_indicator.dart';

part 'sign_in_controller.g.dart';

class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store, MapFailureMessage {
  _SignInControllerBase({
    required AuthenticateUserUseCase autenticateUserUseCase,
    required PasswordValidator passwordValidator,
    required AppStateUseCase appStateUseCase,
  })  : _appStateUseCase = appStateUseCase,
        _passwordValidator = passwordValidator,
        _authenticateUser = autenticateUserUseCase {
   _password = SignInPassword('', _passwordValidator);
  }

  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final AuthenticateUserUseCase _authenticateUser;
  final PasswordValidator _passwordValidator;
  final AppStateUseCase _appStateUseCase;
  EmailAddress _emailAddress = EmailAddress('');
  late SignInPassword _password;

  @observable
  ObservableFuture<Either<Failure, SessionEntity>>? _progress;

  @observable
  String warningEmail = '';

  @observable
  String warningPassword = '';

  @observable
  String? errorMessage = '';

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
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    warningEmail = address.isEmpty ? '' : _emailAddress.mapFailure;
  }

  @action
  void setPassword(String password) {
    _password = SignInPassword(password, _passwordValidator);
    warningPassword = _password.mapFailure;
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    if (!_emailAddress.isValid || !_password.isValid) {
      errorMessage = _invalidFieldsToProceedLogin;
      return;
    }
    errorMessage = '';

    _progress = ObservableFuture(
      _authenticateUser(
        email: _emailAddress,
        password: _password,
      ),
    );

    final Either<Failure, SessionEntity> response = await _progress!;

    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) => _forwardToLogged(session),
    );
  }

  @action
  Future<void> registerUserPressed() async {
    Modular.to.pushNamed('/authentication/signup');
  }

  @action
  Future<void> resetPasswordPressed() async {
    Modular.to.pushNamed('/authentication/reset_password');
  }

  Future<void> _forwardToLogged(SessionEntity session) async {
    if (session.deletedScheduled) {
      Modular.to.pushNamed('/accountDeleted', arguments: session.sessionToken);
    } else {
      final appState = await _appStateUseCase.check();
      appState.fold(
        (failure) => errorMessage = mapFailureMessage(failure),
        (_) => AppNavigator.popAndPush(AppRoute('/mainboard?page=feed')),
      );
    }
  }
}
