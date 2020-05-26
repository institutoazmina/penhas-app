import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'reset_password_two_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";
const String WARNING_TOKEN = 'Precisa digitar o enviado';

class ResetPasswordTwoController extends _ResetPasswordTwoControllerBase
    with _$ResetPasswordTwoController {
  ResetPasswordTwoController(IChangePasswordRepository repository,
      UserRegisterFormFieldModel userRegisterModel)
      : super(repository, userRegisterModel);
}

enum StoreState { initial, loading, loaded }

abstract class _ResetPasswordTwoControllerBase with Store {
  final IChangePasswordRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _ResetPasswordTwoControllerBase(this.repository, this._userRegisterModel);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

  @observable
  String errorMessage = '';

  @observable
  String warrningToken = '';

  @computed
  StoreState get currentState {
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return StoreState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future<void> setToken(String token) async {
    _userRegisterModel.token = token.replaceAll(RegExp(r'\D'), '');
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (_userRegisterModel.token == null ||
        _userRegisterModel.token.length < 6) {
      _setErrorMessage(WARNING_TOKEN);
      return;
    }

    _progress = ObservableFuture(
      repository.validToken(
        emailAddress: _userRegisterModel.emailAddress,
        resetToken: _userRegisterModel.token,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (session) => _forwardToStep3(),
    );
  }

  void _setErrorMessage(String s) {
    errorMessage = s;
  }

  void _forwardToStep3() {
    Modular.to.pushNamed('/authentication/reset_password/step3',
        arguments: _userRegisterModel);
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        _setErrorMessage(ERROR_INTERNET_CONNECTION_FAILURE);
        break;
      case ServerFailure:
        _setErrorMessage(ERROR_SERVER_FAILURE);
        break;
      case ServerSideFormFieldValidationFailure:
        _mapFailureToFields(failure);
        break;
      default:
        throw UnsupportedError;
    }
  }

  _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    _setErrorMessage(failure.message);
  }
}
