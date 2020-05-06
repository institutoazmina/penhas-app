import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'sign_up_controller.g.dart';

const WARNING_FULL_NAME = 'Nome inválido para o sistema';
const WARNING_BIRTHDAY = 'Data de nascimento inválida';
const WARNING_CPF = 'CPF inválido';
const WARNING_CEP = 'CEP inválido';
const WARNING_INVALID_FIELD_TO_CONTINUE =
    'Todos os campos precisam estar válidos antes de continguar.';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class SignUpController extends _SignUpControllerBase with _$SignUpController {
  SignUpController(IUserRegisterRepository repository) : super(repository);
}

enum StoreState { initial, loading, loaded }

abstract class _SignUpControllerBase with Store {
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
  StoreState get currentState {
    print('***currentState***');
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return StoreState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  void setFullname(String fullname) {
    _userRegisterModel.fullname = Fullname(fullname);

    warningFullname = _userRegisterModel.fullname.value.fold(
      (failure) => fullname.length == 0 ? '' : WARNING_FULL_NAME,
      (_) => '',
    );
  }

  @action
  void setBirthday(DateTime birthday) {
    _userRegisterModel.birthday = Birthday.datetime(birthday);

    warningBirthday = _userRegisterModel.birthday.value.fold(
      (failure) => birthday == null ? '' : WARNING_FULL_NAME,
      (_) => '',
    );
  }

  @action
  void setCpf(String cpf) {
    _userRegisterModel.cpf = Cpf(cpf);

    warningCpf = _userRegisterModel.cpf.value.fold(
      (failure) => cpf.length == 0 ? '' : WARNING_CPF,
      (_) => '',
    );
  }

  @action
  void setCep(String cep) {
    _userRegisterModel.cep = Cep(cep);

    warningCep = _userRegisterModel.cep.value.fold(
      (failure) => cep.length == 0 ? '' : WARNING_CEP,
      (_) => '',
    );
  }

  @action
  Future<void> nextStepPressed() async {
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
      (failure) => _mapFailureToMessage(failure),
      (session) => throw RedirectException(
        'nextStepPressed não implementada',
        [],
      ),
    );
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.fullname == null ||
        !_userRegisterModel.fullname.isValid) {
      isValid = false;
      warningFullname = WARNING_FULL_NAME;
    }

    if (_userRegisterModel.birthday == null ||
        !_userRegisterModel.birthday.isValid) {
      isValid = false;
      warningBirthday = WARNING_BIRTHDAY;
    }

    if (_userRegisterModel.cpf == null || !_userRegisterModel.cpf.isValid) {
      isValid = false;
      warningCpf = WARNING_CPF;
    }

    if (_userRegisterModel.cep == null || !_userRegisterModel.cep.isValid) {
      isValid = false;
      warningCep = WARNING_CEP;
    }

    return isValid;
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
    errorMessage = '';
  }

  _mapFailureToMessage(Failure failure) {
    print(failure);
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
    String message =
        failure.message == null ? WARNING_FULL_NAME : failure.message;
    if (failure.error == 'name_not_match') {
      message = 'Nome não confere com o CPF';
    }

    warningFullname = message;
  }

  void _mapToCpfField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message == null ? WARNING_CPF : failure.message;

    warningCpf = message;
  }

  void _mapToCepField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message == null ? WARNING_CEP : failure.message;

    warningCep = message;
  }

  void _mapToBirthdayField(ServerSideFormFieldValidationFailure failure) {
    String message =
        failure.message == null ? WARNING_BIRTHDAY : failure.message;

    warningBirthday = message;
  }
}
