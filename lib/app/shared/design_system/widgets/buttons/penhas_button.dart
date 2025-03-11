import 'package:flutter/material.dart';

import 'styles/filled_button_style.dart';
import 'styles/rounded_filled_button_style.dart';
import 'styles/rounded_outlined_button_style.dart';
import 'styles/text_button_style.dart';

/// Um botão personalizado para ser usado em toda a aplicação.
///
/// `PenhasButton` é um widget que estende [ElevatedButton], permitindo fácil
/// customização e consistência de estilo para botões em toda a aplicação.
/// Este widget facilita a aplicação de estilos personalizados através do
/// [ButtonStyle], além de fornecer métodos factory para criar botões
/// com estilos específicos.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   style: TextButtonStyle(),
///   child: Text('Botão de Texto'),
///   onPressed: () { /* Ação do botão */ },
/// )
/// ```
///
/// Ou utilizando os métodos factory para criar instâncias com os estilos desejados:
/// ```dart
/// PenhasButton.roundedFilled(
///   child: Text('Botão Arredondado Preenchido'),
///   onPressed: () { /* Ação do botão */ },
/// )
/// ```
///
/// ### Métodos Factory:
/// - [PenhasButton.roundedFilled]: Cria um botão com estilo arredondado e preenchido.
/// - [PenhasButton.roundedOutlined]: Cria um botão com estilo arredondado e delineado.
/// - [PenhasButton.text]: Cria um botão com estilo de botão de texto.
/// - [PenhasButton.filled]: Cria um botão com estilo de botão plano preenchido.
///
/// Veja também:
/// * [FilledButtonStyle], [RoundedFilledButtonStyle], [RoundedOutlinedButtonStyle], [TextButtonStyle], as implementações de [ButtonStyle].

class PenhasButton extends ElevatedButton {
  /// Cria uma nova instância de [PenhasButton].
  ///
  /// * [child] é o conteúdo do botão.
  /// * [onPressed] é a ação a ser executada ao pressionar o botão.
  /// * [style] define o estilo do botão e deve ser uma implementação de [ButtonStyle].
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

  /// Cria uma instância de [PenhasButton] com estilo [RoundedFilledButtonStyle] (botão arredondado preenchido).
  factory PenhasButton.roundedFilled({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
    String? text,
  }) {
    return PenhasButton(
      onPressed: onPressed,
      focusNode: focusNode,
      style: RoundedFilledButtonStyle(),
      child: child,
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [RoundedOutlinedButtonStyle] (botão arredondado delineado).
  factory PenhasButton.roundedOutlined({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      onPressed: onPressed,
      focusNode: focusNode,
      style: RoundedOutlinedButtonStyle(),
      child: child,
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [TextButtonStyle] (botão de texto).
  factory PenhasButton.text({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      onPressed: onPressed,
      focusNode: focusNode,
      style: TextButtonStyle(),
      child: child,
    );
  }

  /// Cria uma instância de [PenhasButton] com estilo [FilledButtonStyle] (botão plano preenchido).
  factory PenhasButton.filled({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      onPressed: onPressed,
      focusNode: focusNode,
      style: FilledButtonStyle(),
      child: child,
    );
  }
}
