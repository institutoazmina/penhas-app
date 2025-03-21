import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/error/failures.dart';
import '../../../../../domain/entities/session_entity.dart';
import '../../../../../domain/repositories/i_user_register_repository.dart';
import '../../../../../domain/usecases/email_address.dart';
import '../../../../../domain/usecases/password_validator.dart';
import '../../../../../domain/usecases/sign_up_password.dart';
import '../../../../shared/map_failure_message.dart';
import '../../../../shared/page_progress_indicator.dart';
import '../../../../shared/user_register_form_field_model.dart';

part 'sign_up_three_controller.g.dart';

class SignUpThreeController extends _SignUpThreeControllerBase
    with _$SignUpThreeController {
  SignUpThreeController(
    super.repository,
    super.userFormFielModel,
    super.passwordValidator,
  );
}

abstract class _SignUpThreeControllerBase with Store, MapFailureMessage {
  _SignUpThreeControllerBase(
    this.repository,
    this._userRegisterModel,
    this._passwordValidator,
  );

  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;
  final PasswordValidator _passwordValidator;

  @observable
  ObservableFuture<Either<Failure, SessionEntity>>? _progress;

  @observable
  String warningEmail = '';

  @observable
  String warningPassword = '';

  @observable
  String warningConfirmationPassword = '';

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
  void setEmail(String email) {
    _userRegisterModel.emailAddress = EmailAddress(email);

    warningEmail = email.isEmpty ? '' : _userRegisterModel.validateEmailAddress;
  }

  @action
  void setPassword(String password) {
    _userRegisterModel.password = SignUpPassword(password, _passwordValidator);
    warningPassword = _userRegisterModel.password!.mapFailure;
    warningConfirmationPassword =
        _userRegisterModel.passwordConfirmation?.isEmpty != false
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  void setConfirmationPassword(String password) {
    _userRegisterModel.passwordConfirmation = password;
    warningConfirmationPassword =
        _userRegisterModel.passwordConfirmation!.isEmpty
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  Future<void> registerUserPress() async {
    errorMessage = '';
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.signup(
        emailAddress: _userRegisterModel.emailAddress,
        password: _userRegisterModel.password,
        cep: _userRegisterModel.cep,
        cpf: _userRegisterModel.cpf,
        fullname: _userRegisterModel.fullname,
        socialName: _userRegisterModel.socialName,
        nickName: _userRegisterModel.nickname,
        birthday: _userRegisterModel.birthday,
        genre: _userRegisterModel.genre,
        race: _userRegisterModel.race,
      ),
    );

    final Either<Failure, SessionEntity> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) => _forwardToLogged(),
    );
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateEmailAddress.isNotEmpty) {
      isValid = false;
      warningEmail = _userRegisterModel.validateEmailAddress;
    }

    if ((_userRegisterModel.password?.isValid ?? false) == false) {
      isValid = false;
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

  void _forwardToLogged() {
    Modular.to.pushNamedAndRemoveUntil(
      '/',
      ModalRoute.withName('/'),
    );
  }
}
