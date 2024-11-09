import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';

/// Uma implementação personalizada de [ButtonStyle] para botões de texto.
///
/// Este estilo de botão define uma série de propriedades para personalizar
/// a aparência e o comportamento de um botão de texto dentro da aplicação.
///
/// Utiliza cores e estilos de texto de [PenhasColors] e [PenhasTextStyle]
/// para manter a consistência visual.
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
/// Propriedades definidas:
/// * Cor de primeiro plano: [PenhasColors.black]
/// * Cor de fundo: [Colors.transparent]
/// * Elevação: `0.0` (sem sombra)
/// * Estilo de texto: cópia de [PenhasTextStyle.bodyMedium] com cor ajustada para [PenhasColors.white]
///
/// Veja também:
/// * [PenhasColors], onde as cores usadas são definidas.
/// * [PenhasTextStyle], onde os estilos de texto usados são definidos.

class TextButtonStyle extends ButtonStyle {
  TextButtonStyle()
      : super(
          foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0.0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            PenhasTextStyle.labelLarge.copyWith(
              color: PenhasColors.white,
            ),
          ),
        );
}
