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

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(IAuthenticationRepository repository) : super(repository);
}

abstract class _SignInControllerBase with Store {
  final IAuthenticationRepository repository;
  EmailAddress _emailAddress = EmailAddress("");
  Password _password = Password("");

  _SignInControllerBase(this.repository);

  @observable
  String invalidEmailAddress = "";

  @observable
  String invalidPassword = "";

  @computed
  bool get hasValidEmailAndPassword =>
      _emailAddress.isValid && _password.isValid;

  @action
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    invalidEmailAddress = _emailAddress.value.fold(
      (failure) => WARNING_INVALID_EMAIL,
      (_) => "",
    );
  }

  @action
  void setPassword(String password) {
    _password = Password(password);

    invalidPassword = _password.value.fold(
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
        emailAddress: _emailAddress, password: _password);
  }
}
