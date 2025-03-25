import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';

/// Uma implementação personalizada de [ButtonStyle] para botões delineados com cantos arredondados.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão delineado com cantos arredondados dentro da aplicação.
///
/// Utiliza cores e estilos de texto de [PenhasColors] e [PenhasTextStyle]
/// para manter a consistência visual.
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
/// Propriedades definidas:
/// * Cor de primeiro plano: [PenhasColors.white]
/// * Cor de fundo: [Colors.transparent]
/// * Forma: [RoundedRectangleBorder] com um raio de 20.0 e borda na cor [PenhasColors.white]
/// * Elevação: `0.0` (sem sombra)
/// * Estilo de texto: cópia de [PenhasTextStyle.labelLarge] com cor ajustada para [PenhasColors.white]
///
/// Veja também:
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.

class RoundedOutlinedButtonStyle extends ButtonStyle {
  RoundedOutlinedButtonStyle()
      : super(
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              return states.contains(WidgetState.disabled)
                  ? PenhasColors.disabledBackground
                  : PenhasColors.white;
            },
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
            (Set<WidgetState> states) {
              return RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                side: BorderSide(
                  color: states.contains(WidgetState.disabled)
                      ? PenhasColors.disabledBackground
                      : PenhasColors.lightPurple,
                ),
              );
            },
          ),
          elevation: WidgetStateProperty.all<double>(0.0),
          textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              return PenhasTextStyle.labelLarge.copyWith(
                color: states.contains(WidgetState.disabled)
                    ? PenhasColors.disabledBackground
                    : PenhasColors.white,
              );
            },
          ),
        );
}
