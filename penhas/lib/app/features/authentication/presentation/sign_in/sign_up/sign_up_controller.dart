import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';

part 'sign_up_controller.g.dart';

class SignUpController extends _SignUpControllerBase with _$SignUpController {
  SignUpController(IUserRegisterRepository repository) : super(repository);
}

abstract class _SignUpControllerBase with Store, MapFailureMessage {
  final IUserRegisterRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  _SignUpControllerBase(this.repository);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

  @observable
  String errorMessage = '';

  @observable
  String warningFullname = '';

  @observable
  String warningBirthday = '';

  @observable
  String warningCpf = '';

  @observable
  String warningCep = '';

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
  void setFullname(String fullname) {
    _userRegisterModel.fullname = Fullname(fullname);

    warningFullname =
        fullname.length == 0 ? '' : _userRegisterModel.validateFullName;
  }

  @action
  void setBirthday(DateTime birthday) {
    _userRegisterModel.birthday = Birthday.datetime(birthday);

    warningBirthday =
        birthday == null ? '' : _userRegisterModel.validateBirthday;
  }

  @action
  void setCpf(String cpf) {
    _userRegisterModel.cpf = Cpf(cpf);

    warningCpf = cpf.length == 0 ? '' : _userRegisterModel.validateCpf;
  }

  @action
  void setCep(String cep) {
    _userRegisterModel.cep = Cep(cep);

    warningCep = cep.length == 0 ? '' : _userRegisterModel.validateCep;
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.checkField(
        birthday: _userRegisterModel.birthday,
        cpf: _userRegisterModel.cpf,
        fullname: _userRegisterModel.fullname,
        cep: _userRegisterModel.cep,
      ),
    );

    final response = await _progress;
    response.fold(
      (failure) => _triggerMessageError(failure),
      (session) => _forwardToStep2(),
    );
  }

  void _forwardToStep2() {
    Modular.to.pushNamed('/authentication/signup/step2',
        arguments: _userRegisterModel);
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateFullName.isNotEmpty) {
      isValid = false;
      warningFullname = _userRegisterModel.validateFullName;
    }

    if (_userRegisterModel.validateBirthday.isNotEmpty) {
      isValid = false;
      warningBirthday = _userRegisterModel.validateBirthday;
    }

    if (_userRegisterModel.validateCpf.isNotEmpty) {
      isValid = false;
      warningCpf = _userRegisterModel.validateCpf;
    }

    if (_userRegisterModel.validateCep.isNotEmpty) {
      isValid = false;
      warningCep = _userRegisterModel.validateCep;
    }

    return isValid;
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  _triggerMessageError(Failure failure) {
    if (failure is ServerSideFormFieldValidationFailure) {
      _setErrorMessage(_mapFailureToFields(failure));
    } else {
      _setErrorMessage(mapFailureMessage(failure));
    }
  }

  _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    _setErrorMessage(failure.message);
    if (failure.field == 'nome_completo') {
      _mapToFullNameField(failure);
    } else if (failure.field == 'dt_nasc') {
      _mapToBirthdayField(failure);
    } else if (failure.field == 'cpf') {
      _mapToCpfField(failure);
    } else if (failure.field == 'cep') {
      _mapToCepField(failure);
    }
  }

  void _mapToFullNameField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;
    if (failure.error == 'name_not_match') {
      message = 'Nome não confere com o CPF';
    }

    warningFullname = message;
  }

  void _mapToCpfField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;

    warningCpf = message;
  }

  void _mapToCepField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;

    warningCep = message;
  }

  void _mapToBirthdayField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;

    warningBirthday = message;
  }
}
