import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';
import 'penhas_button_style.dart';

/// Uma implementação personalizada do [PenhasButtonStyle] para botão delineado com cantos arredondados.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão delineado com cantos arredondados dentro da aplicação.
///
/// Usa cores e textos de [PenhasColors] e [PenhasTextStyle] para manter
/// a consistência visual.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   onPressed: () {},
///   style: RoundedOutlinedButtonStyle(),
///   child: Text('Botão Arredondado'),
/// )
/// ```
///
/// Veja também:
/// * [PenhasButtonStyle], a interface que esta classe implementa.
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.
class RoundedOutlinedButtonStyle implements PenhasButtonStyle {
  /// Retorna um [ButtonStyle] personalizado para botão delineado com cantos arredondados.
  ///
  /// O estilo define as seguintes propriedades:
  /// * Cor de primeiro plano para [PenhasColors.white]
  /// * Cor de fundo para [PenhasColors.lightPurple]
  /// * Forma para um retângulo arredondado com um raio de 20.0 e borda na cor [PenhasColors.lightPurple]
  /// * Elevação para `0.0` (sem sombra)
  /// * Estilo de texto para uma cópia de [PenhasTextStyle.labelLarge] com a cor ajustada para [PenhasColors.white]
  @override
  ButtonStyle get buttonStyle => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            side: BorderSide(color: PenhasColors.white),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(0.0),
        textStyle: MaterialStateProperty.all<TextStyle>(
          PenhasTextStyle.labelLarge.copyWith(
            color: PenhasColors.white,
          ),
        ),
      );
}
