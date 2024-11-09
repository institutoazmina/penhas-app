import 'package:flutter/material.dart';

import 'styles/filled_button_style.dart';
import 'styles/rounded_filled_button_style.dart';
import 'styles/rounded_outlined_button_style.dart';
import 'styles/text_button_style.dart';

/// Um botão personalizado para ser usado em toda a aplicação.
///
/// `PenhasButton` é um widget que estende [ElevatedButton], permitindo uma
/// fácil customização e consistência de estilo para botões em toda a aplicação.
/// Este widget permite a aplicação de estilos personalizados através da interface [PenhasButtonStyle].
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   style: TextButtonStyle(),
///   child: Text('Botão Arredondado'),
///   onPressed: () { /* Faça algo aqui */ },
/// )
/// ```
///
/// Pode utilizar os métodos factory para instâncias no estilo desejado.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton.roundedFilledButton(
///   child: Text('Botão Arredondado'),
///   onPressed: () { /* Faça algo aqui */ },
/// )
/// ```
///
/// Veja também:
/// * [PenhasButtonStyle], a interface que define o estilo de botão.
/// * [FilledButtonStyle], [RoundedFilledButtonStyle], [RoundedOutlinedButtonStyle], [TextButtonStyle], as implementações de [PenhasButtonStyle].
class PenhasButton extends ElevatedButton {
  /// Cria uma nova instância de [PenhasButton].
  ///
  /// * [child] é o conteúdo do botão.
  /// * [onPressed] é a ação a ser executada ao pressionar o botão.
  /// * [style] é a implementação da interface [PenhasButtonStyle] que define o estilo do botão.
  /// * [focusNode] é o [FocusNode] opcional para o botão.
  const PenhasButton({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    required ButtonStyle style,
    FocusNode? focusNode,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          style: style,
          focusNode: focusNode,
        );

  /// Cria uma instância de [PenhasButton] com estilo [RoundedFilledButtonStyle] de botão arredondado.
  factory PenhasButton.roundedFilledButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: RoundedFilledButtonStyle(),
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [RoundedOutlinedButtonStyle] de botão arredondado.
  factory PenhasButton.roundedOutlinedButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: RoundedOutlinedButtonStyle(),
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [TextButtonStyle] de botão de texto.
  factory PenhasButton.textButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: TextButtonStyle(),
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [FilledButtonStyle] de botão plano preenchido.
  factory PenhasButton.filledButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: FilledButtonStyle(),
    );
  }
}
