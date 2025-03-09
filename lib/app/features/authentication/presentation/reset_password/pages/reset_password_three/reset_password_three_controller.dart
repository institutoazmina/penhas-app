import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/entities/valid_fiel.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../domain/repositories/i_reset_password_repository.dart';
import '../../../../domain/usecases/password_validator.dart';
import '../../../../domain/usecases/sign_up_password.dart';
import '../../../shared/map_failure_message.dart';
import '../../../shared/page_progress_indicator.dart';
import '../../../shared/user_register_form_field_model.dart';

part 'reset_password_three_controller.g.dart';

class ResetPasswordThreeController extends _ResetPasswordThreeControllerBase
    with _$ResetPasswordThreeController {
  ResetPasswordThreeController(
    IChangePasswordRepository repository,
    UserRegisterFormFieldModel? userRegisterModel,
    PasswordValidator passwordValidator,
  ) : super(repository, userRegisterModel, passwordValidator);
}

abstract class _ResetPasswordThreeControllerBase with Store, MapFailureMessage {
  _ResetPasswordThreeControllerBase(
    this._repository,
    this._userRegisterModel,
    this._passwordValidator,
  );

  final IChangePasswordRepository _repository;
  final UserRegisterFormFieldModel? _userRegisterModel;
  final PasswordValidator _passwordValidator;

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _progress;

  @observable
  String? errorMessage = '';

  @observable
  String warningPassword = '';

  @observable
  String warningConfirmationPassword = '';

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
    _userRegisterModel!.password = SignUpPassword(password, _passwordValidator);
    warningPassword = _userRegisterModel.password!.mapFailure;
    warningConfirmationPassword =
        (_userRegisterModel.passwordConfirmation ?? '').isEmpty
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  void setConfirmationPassword(String password) {
    _userRegisterModel!.passwordConfirmation = password;
    warningConfirmationPassword =
        (_userRegisterModel.passwordConfirmation ?? '').isEmpty
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  Future<void> nextStepPressed() async {
    errorMessage = '';
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      _repository.reset(
        emailAddress: _userRegisterModel!.emailAddress!,
        password: _userRegisterModel.password!,
        resetToken: _userRegisterModel.token!,
      ),
    );

    final Either<Failure, ValidField> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) => _forwardLogin(),
    );
  }

  bool _isValidToProceed() {
    if (_userRegisterModel == null) {
      return false;
    }

    bool isValid = _userRegisterModel.password!.isValid;

    if (!isValid) {
      warningPassword = _userRegisterModel.password?.mapFailure ??
          SignUpPassword('', _passwordValidator).mapFailure;
    }

    if (_userRegisterModel.validatePasswordConfirmation.isNotEmpty) {
      isValid = false;
      warningConfirmationPassword =
          _userRegisterModel.validatePasswordConfirmation;
    }

    return isValid;
  }

  void _forwardLogin() {
    Modular.to.pushNamedAndRemoveUntil(
      '/authentication',
      ModalRoute.withName('/'),
    );
  }
}
