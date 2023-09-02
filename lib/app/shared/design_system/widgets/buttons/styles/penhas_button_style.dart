import 'package:flutter/material.dart';

/// Define a configuração visual para o [PenhasButton]
///
/// [PenhasButton] recebe uma implementação de [PenhasButtonStyle] com as
/// propriedades de estilo visual adequado que vai sobrescrever o previamente
/// definido no [ElevatedButton].
abstract class PenhasButtonStyle {
  /// Aplica o estilo no botão
  ButtonStyle get buttonStyle;
}
