import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';

/// Uma implementação personalizada de [ButtonStyle] para botões preenchidos com cantos arredondados.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão preenchido com cantos arredondados dentro da aplicação.
///
/// Utiliza cores e estilos de texto de [PenhasColors] e [PenhasTextStyle]
/// para manter a consistência visual.
///
/// Exemplo de uso:
/// ```dart
/// PenhasButton(
///   onPressed: () {},
///   style: RoundedFilledButtonStyle(),
///   child: Text('Botão Arredondado'),
/// )
/// ```
///
/// Propriedades definidas:
/// * Cor de primeiro plano: [PenhasColors.white]
/// * Cor de fundo: [PenhasColors.lightPurple]
/// * Forma: [RoundedRectangleBorder] com um raio de 20.0 e borda na cor [PenhasColors.lightPurple]
/// * Elevação: `0.0` (sem sombra)
/// * Estilo de texto: cópia de [PenhasTextStyle.labelLarge] com cor ajustada para [PenhasColors.white]
///
/// Veja também:
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.

class RoundedFilledButtonStyle extends ButtonStyle {
  RoundedFilledButtonStyle()
      : super(
          foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.white),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              return states.contains(MaterialState.disabled)
                  ? PenhasColors.disabledBackground
                  : PenhasColors.lightPurple;
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                side: BorderSide(
                  color: states.contains(MaterialState.disabled)
                      ? PenhasColors.disabledBackground
                      : PenhasColors.lightPurple,
                ),
              );
            },
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            PenhasTextStyle.labelLarge.copyWith(
              color: PenhasColors.white,
            ),
          ),
        );
}
