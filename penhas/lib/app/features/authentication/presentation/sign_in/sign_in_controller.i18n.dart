import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("pt_br") +
      {
        "pt_br": "Endereço de email inválido",
        "en_us": "Invalid email address",
      } +
      {
        "pt_br": "Senha inválido, favor informar uma senha válida",
        "en_us": "Invalid password, please enter a valid password",
      };

  String get i18n => localize(this, _t);
}
