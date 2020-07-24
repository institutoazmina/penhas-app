import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'reset_password_three_controller.g.dart';

class ResetPasswordThreeController extends _ResetPasswordThreeControllerBase
    with _$ResetPasswordThreeController {
  ResetPasswordThreeController(
    IChangePasswordRepository repository,
    UserRegisterFormFieldModel userRegisterModel,
  ) : super(repository, userRegisterModel);
}

abstract class _ResetPasswordThreeControllerBase with Store, MapFailureMessage {
  final IChangePasswordRepository _repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _ResetPasswordThreeControllerBase(this._repository, this._userRegisterModel);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

  @observable
  String errorMessage = '';

  @observable
  String warningPassword = '';

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
    _userRegisterModel.password = Password(password);

    warningPassword =
        password.length == 0 ? '' : _userRegisterModel.validatePassword;
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      _repository.reset(
        emailAddress: _userRegisterModel.emailAddress,
        password: _userRegisterModel.password,
        resetToken: _userRegisterModel.token,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) => _forwardLogin(),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validatePassword.isNotEmpty) {
      isValid = false;
      warningPassword = _userRegisterModel.validatePassword;
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
