import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';
import 'penhas_button_style.dart';

/// Uma implementação personalizada do [PenhasButtonStyle] para botão plano preenchido.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão plano dentro da aplicação.
///
/// Usa cores e textos de [PenhasColors] e [PenhasTextStyle] para manter
/// a consistência visual.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   onPressed: () {},
///   style: FilledButtonStyle(),
///   child: Text('Botão Plano'),
/// )
/// ```
///
/// Veja também:
/// * [PenhasButtonStyle], a interface que esta classe implementa.
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.
class FilledButtonStyle implements PenhasButtonStyle {
  @override

  /// Retorna um [ButtonStyle] personalizado para botão plano preenchido.
  ///
  /// O estilo define as seguintes propriedades:
  /// * Cor de fundo para [PenhasColors.lightPurple]
  /// * Cor do texto para [PenhasColors.white]
  /// * Elevação para `0.0` (sem sombra)
  /// * Estilo de texto para uma cópia de [PenhasTextStyle.labelLarge] com a cor ajustada para [PenhasColors.white]
  ButtonStyle get buttonStyle => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(PenhasColors.lightPurple),
        elevation: MaterialStateProperty.all<double>(0.0),
        textStyle: MaterialStateProperty.all<TextStyle>(
          PenhasTextStyle.labelLarge.copyWith(
            color: PenhasColors.white,
          ),
        ),
      );
}
