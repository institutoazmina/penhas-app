import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'reset_password_controller.g.dart';

const String WARNING_INVALID_EMAIL = 'Endereço de email inválido';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class ResetPasswordController extends _ResetPasswordControllerBase
    with _$ResetPasswordController {
  ResetPasswordController(IResetPasswordRepository repository)
      : super(repository);
}

enum StoreState { initial, loading, loaded }

abstract class _ResetPasswordControllerBase with Store {
  final IResetPasswordRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  _ResetPasswordControllerBase(this.repository);

  @observable
  ObservableFuture<Either<Failure, ResetPasswordResponseEntity>> _progress;

  @observable
  String errorMessage = '';

  @observable
  String warningEmail = '';

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
  void setEmail(String address) {
    _userRegisterModel.emailAddress = EmailAddress(address);

    warningEmail = _userRegisterModel.emailAddress.value.fold(
      (failure) => address.length == 0 ? '' : WARNING_INVALID_EMAIL,
      (_) => '',
    );
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }
    _progress = ObservableFuture(
      repository.request(emailAddress: _userRegisterModel.emailAddress),
    );

    final response = await _progress;
    response.fold(
      (failure) => _mapFailureToMessage(failure),
      (session) => _forwardToStep2(session),
    );
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

  void _setErrorMessage(String s) {
    errorMessage = s;
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.emailAddress == null ||
        !_userRegisterModel.emailAddress.isValid) {
      isValid = false;
      warningEmail = WARNING_INVALID_EMAIL;
    }

    return isValid;
  }

  void _forwardToStep2(ResetPasswordResponseEntity entity) {
    Modular.to.pushNamed('/authentication/reset_password/step2',
        arguments: _userRegisterModel);
  }
}
