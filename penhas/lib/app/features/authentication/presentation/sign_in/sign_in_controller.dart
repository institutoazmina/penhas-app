import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

part 'sign_in_controller.g.dart';

const String WARNING_INVALID_EMAIL = 'Endereço de email inválido';
const String WARNING_INVALID_PASSWORD =
    'Senha inválido, favor informar uma senha válida';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(IAuthenticationRepository repository) : super(repository);
}

abstract class _SignInControllerBase with Store {
  final IAuthenticationRepository repository;
  EmailAddress _emailAddress = EmailAddress("");
  Password _password = Password("");

  _SignInControllerBase(this.repository);

  @observable
  String warningEmail = "";

  @observable
  String warningPassword = "";

  @observable
  String errorMessage = "";

  @computed
  bool get hasValidEmailAndPassword =>
      _emailAddress.isValid && _password.isValid;

  @action
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    warningEmail = _emailAddress.value.fold(
      (failure) => WARNING_INVALID_EMAIL,
      (_) => "",
    );
  }

  @action
  void setPassword(String password) {
    _password = Password(password);

    warningPassword = _password.value.fold(
      (failure) => WARNING_INVALID_PASSWORD,
      (_) => "",
    );
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    if (!hasValidEmailAndPassword) {
      return;
    }

    var foo = await repository.signInWithEmailAndPassword(
      emailAddress: _emailAddress,
      password: _password,
    );

    foo.fold((failure) => _mapFailureToMessage(failure), (session) => "");
  }

  void _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        errorMessage = ERROR_SERVER_FAILURE;
        break;
      case InternetConnectionFailure:
        errorMessage = ERROR_INTERNET_CONNECTION_FAILURE;
        break;
      default:
        throw UnsupportedError;
    }
  }
}
