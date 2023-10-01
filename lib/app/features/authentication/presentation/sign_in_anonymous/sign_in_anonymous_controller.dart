import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/managers/local_store.dart';
import '../../../appstate/domain/entities/user_profile_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/usecases/authenticate_user.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/password_validator.dart';
import '../../domain/usecases/sign_in_password.dart';
import '../shared/map_failure_message.dart';
import '../shared/page_progress_indicator.dart';

part 'sign_in_anonymous_controller.g.dart';

class SignInAnonymousController = _SignInAnonymousController
    with _$SignInAnonymousController;

abstract class _SignInAnonymousController with Store, MapFailureMessage {
  _SignInAnonymousController({
    required AuthenticateAnonymousUser authenticateAnonymousUser,
    required LocalStore<UserProfileEntity> userProfileStore,
    required PasswordValidator passwordValidator,
  })  : _authenticateAnonymousUser = authenticateAnonymousUser,
        _userProfileStore = userProfileStore,
        _passwordValidator = passwordValidator {
    _init();
    _password = SignInPassword('', _passwordValidator);
  }

  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final LocalStore<UserProfileEntity> _userProfileStore;
  final PasswordValidator _passwordValidator;
  final AuthenticateAnonymousUser _authenticateAnonymousUser;


  EmailAddress _emailAddress = EmailAddress('');
  late SignInPassword _password;

  Future<void> _init() async {
    final profile = await _userProfileStore.retrieve();
    _emailAddress = EmailAddress(profile.email);
    userEmail = profile.email;
    userGreetings = 'Bem-vinda, ${profile.nickname}';
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
      _authenticateAnonymousUser(
        email: _emailAddress,
        password: _password,
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

  Future<void> _forwardToLogged() async {
    Modular.to.pushReplacementNamed('/mainboard');
  }
}
