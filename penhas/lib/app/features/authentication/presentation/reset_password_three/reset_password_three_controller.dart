import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'reset_password_three_controller.g.dart';

const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class ResetPasswordThreeController extends _ResetPasswordThreeControllerBase
    with _$ResetPasswordThreeController {
  ResetPasswordThreeController(IResetPasswordRepository repository)
      : super(repository);
}

abstract class _ResetPasswordThreeControllerBase with Store {
  final IResetPasswordRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  _ResetPasswordThreeControllerBase(this.repository);

  @observable
  String errorMessage = '';

  @observable
  String warningPassword = '';

  @action
  void setPassword(String password) {
    _userRegisterModel.password = Password(password);
  }

  @action
  void nextStepPressed() {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _forwardLogin();
  }

  void _setErrorMessage(String s) {}

  bool _isValidToProceed() {
    return true;
  }

  void _forwardLogin() {
    Modular.to.pushReplacementNamed('/authentication');
  }
}
