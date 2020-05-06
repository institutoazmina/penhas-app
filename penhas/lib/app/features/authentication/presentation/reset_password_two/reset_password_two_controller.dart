import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'reset_password_two_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class ResetPasswordTwoController extends _ResetPasswordTwoControllerBase
    with _$ResetPasswordTwoController {
  ResetPasswordTwoController(IResetPasswordRepository repository)
      : super(repository);
}

abstract class _ResetPasswordTwoControllerBase with Store {
  final IResetPasswordRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  @observable
  String errorMessage = '';

  _ResetPasswordTwoControllerBase(this.repository);

  @action
  void setToken(String token) {}
  @action
  void nextStepPressed() {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _forwardToLogged();
  }

  void _setErrorMessage(String s) {}

  bool _isValidToProceed() {
    return true;
  }

  void _forwardToLogged() {
    Modular.to.pushNamed('/authentication/reset_password/step3');
  }
}
