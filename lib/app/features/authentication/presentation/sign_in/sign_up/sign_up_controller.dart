import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'sign_up_controller.g.dart';

class SignUpController extends _SignUpControllerBase with _$SignUpController {
  SignUpController(IUserRegisterRepository repository) : super(repository);
}

abstract class _SignUpControllerBase with Store, MapFailureMessage {
  _SignUpControllerBase(this.repository);

  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel =
      UserRegisterFormFieldModel();

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _progress;

  @observable
  String? errorMessage = '';

  @observable
  String? warningFullname = '';

  @observable
  String? warningBirthday = '';

  @observable
  String? warningCpf = '';

  @observable
  String? warningCep = '';

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
  void setFullname(String fullname) {
    _userRegisterModel.fullname = Fullname(fullname);

    warningFullname =
        fullname.isEmpty ? '' : _userRegisterModel.validateFullName;
  }

  @action
  void setBirthday(String birthday) {
    _userRegisterModel.birthday = Birthday(birthday);

    warningBirthday = _userRegisterModel.validateBirthday;
  }

  @action
  void setCpf(String cpf) {
    _userRegisterModel.cpf = Cpf(cpf);

    warningCpf = cpf.isEmpty ? '' : _userRegisterModel.validateCpf;
  }

  @action
  void setCep(String cep) {
    _userRegisterModel.cep = Cep(cep);

    warningCep = cep.isEmpty ? '' : _userRegisterModel.validateCep;
  }

  @action
  Future<void> nextStepPressed() async {
    errorMessage = '';
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

    final Either<Failure, ValidField> response = await _progress!;
    response.fold(
      (failure) => _triggerMessageError(failure),
      (session) => _forwardToStep2(),
    );
  }

  void _forwardToStep2() {
    Modular.to.pushNamed(
      '/authentication/signup/step2',
      arguments: _userRegisterModel,
    );
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

  void _triggerMessageError(Failure failure) {
    if (failure is ServerSideFormFieldValidationFailure) {
      errorMessage = _mapFailureToFields(failure);
    } else {
      errorMessage = mapFailureMessage(failure);
    }
  }

  String? _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    String? message = '';
    if (failure.field == 'nome_completo') {
      _mapToFullNameField(failure);
    } else if (failure.field == 'dt_nasc') {
      _mapToBirthdayField(failure);
    } else if (failure.field == 'cpf') {
      _mapToCpfField(failure);
    } else if (failure.field == 'cep') {
      _mapToCepField(failure);
    } else {
      message = failure.message;
    }

    return message;
  }

  void _mapToFullNameField(ServerSideFormFieldValidationFailure failure) {
    String? message = failure.message;
    if (failure.error == 'name_not_match') {
      message = 'Nome não confere com o CPF';
    }

    warningFullname = message;
  }

  void _mapToCpfField(ServerSideFormFieldValidationFailure failure) {
    final String? message = failure.message;

    warningCpf = message;
  }

  void _mapToCepField(ServerSideFormFieldValidationFailure failure) {
    final String? message = failure.message;

    warningCep = message;
  }

  void _mapToBirthdayField(ServerSideFormFieldValidationFailure failure) {
    final String? message = failure.message;

    warningBirthday = message;
  }
}
