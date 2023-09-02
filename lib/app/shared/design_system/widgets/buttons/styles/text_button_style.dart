import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';
import 'penhas_button_style.dart';

/// Uma implementação personalizada do [PenhasButtonStyle] para botões de texto.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão de texto dentro da aplicação.
///
/// Usa cores e textos de [PenhasColors] e [PenhasTextStyle] para manter
/// a consistência visual.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   onPressed: () {},
///   style: TextButtonStyle(),
///   child: Text('Botão de Texto'),
/// )
/// ```
///
/// Veja também:
/// * [PenhasButtonStyle], a interface que esta classe implementa.
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.
class TextButtonStyle implements PenhasButtonStyle {
  @override

  /// Retorna um [ButtonStyle] personalizado para botões de texto.
  ///
  /// O estilo define as seguintes propriedades:
  /// * Cor de primeiro plano para [PenhasColors.black]
  /// * Cor de fundo para [Colors.transparent]
  /// * Elevação para `0.0` (sem sombra)
  /// * Estilo de texto para uma cópia de [PenhasTextStyle.bodyMedium] com a cor ajustada para [PenhasColors.white]
  ButtonStyle get buttonStyle => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.black),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0.0),
        textStyle: MaterialStateProperty.all<TextStyle>(
          PenhasTextStyle.bodyMedium.copyWith(
            color: PenhasColors.white,
          ),
        ),
      );
}
