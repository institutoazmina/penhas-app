import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("pt_br") +
      {
        "pt_br": "ENTRAR",
        "en_us": "Login",
      } +
      {
        "pt_br": "Esqueci minha senha",
        "en_us": "I forgot my password",
      } +
      {
        "pt_br": "Cadastrar",
        "en_us": "Register",
      } +
      {
        "pt_br": "Senha",
        "en_us": "Password",
      } +
      {
        "pt_br": "Digite sua senha",
        "en_us": "Type your password",
      } +
      {
        "pt_br": "E-mail",
      } +
      {
        "pt_br": "Digite seu e-mail",
        "en_us": "Type your e-mail",
      };

  String get i18n => localize(this, _t);
}

/*
  static var _t = Translations("pt_br") +
      {
        "pt_br": "ENTRAR",
        "en_us": "Login",
      } +
      {
        "pt_br": "Esqueci minha senha",
        "en_us": "I forgot my password",
      } +
      {
        "pt_br": "Cadastrar",
        "en_us": "Register",
      } +
      {
        "pt_br": "Senha",
        "en_us": "Password",
      } +
      {
        "pt_br": "Digite sua senha",
        "en_us": "Type your password",
      } +
      {
        "pt_br": "E-mail",
      } +
      {
        "pt_br": "Digite seu e-mail",
        "en_us": "Type your e-mail",
      } +
      {
        "pt_br": "Endereço de email inválido",
        "en_us": "Invalid email address",
      } +
      {
        "pt_br": "Senha inválido, favor informar uma senha válida",
        "en_us": "Invalid password, please enter a valid password",
      };
*/
