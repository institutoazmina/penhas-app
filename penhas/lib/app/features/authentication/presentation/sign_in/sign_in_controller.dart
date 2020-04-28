import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'sign_in_controller.i18n.dart';
part 'sign_in_controller.g.dart';

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(IAuthenticationRepository repository) : super(repository);
}

abstract class _SignInControllerBase with Store {
  final IAuthenticationRepository repository;
  EmailAddress _emailAddress;
  Password _password;

  _SignInControllerBase(this.repository);

  @observable
  String invalidEmailAddress = "";

  @observable
  String invalidPassword = "";

  @action
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    if (_emailAddress.value.isLeft()) {
      invalidEmailAddress = "Endereço de email inválido".i18n;
    } else {
      invalidEmailAddress = "";
    }
  }

  @action
  void setPassword(String password) {
    _password = Password(password);

    if (_password.value.isLeft()) {
      invalidPassword = "Senha inválido, favor informar uma senha válida".i18n;
    } else {
      invalidPassword = "";
    }
  }
}
