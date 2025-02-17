import 'package:flutter/widgets.dart';

/// Uma classe de estilo de texto personalizado para gerenciar estilos de tipografia.
///
/// `PenhasTextStyle` encapsula uma variedade de objetos [TextStyle]
/// que podem ser comumente usados em toda a aplicação.
///
/// Exemplo de uso:
/// ```dart
/// Text(
///   'Olá Mundo',
///   style: PenhasTextStyle.displayLarge,
/// )
/// ```
///
/// Nota: Esta classe não tem a intenção de ser instanciada ou estendida;
/// esta classe é uma classe utilitária.
class PenhasTextStyle {
  PenhasTextStyle._();

  static const String _fontFamily = 'Lato';

  /// Estilo para destacar textos e número em tela grande, maior estilo do **Display**
  ///
  /// Tamanho de fonte 57, altura da linha 64 com estilo regular
  ///
  /// [Estilo Display](https://m3.material.io/styles/typography/applying-type#fea95f28-348c-42ae-95e1-1c5bfd819524)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 64 / 57,
    letterSpacing: -0.25,
  );

  /// Estilo para destacar textos e número em telas grandes, tamanho médio do **Display**
  ///
  /// Tamanho de fonte 45, altura da linha 52 com estilo regular
  ///
  /// [Estilo Display](https://m3.material.io/styles/typography/applying-type#fea95f28-348c-42ae-95e1-1c5bfd819524)
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 52 / 45,
  );

  /// Estilo para destacar textos e número em telas grandes, tamanho pequeno do **Display**
  ///
  /// Tamanho de fonte 36, altura da linha 44 com estilo regular
  ///
  /// [Estilo Display](https://m3.material.io/styles/typography/applying-type#fea95f28-348c-42ae-95e1-1c5bfd819524)
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 44 / 36,
  );

  /// Estilo para enfatizar texto em tela menor, destacando região importante de conteúdo, tamanho grande do **Headline**
  ///
  /// Tamanho de fonte 32, altura da linha 40 com estilo regular
  ///
  /// [Estilo Headline](https://m3.material.io/styles/typography/applying-type#43511b5a-fe60-4125-ac0c-571c4e6f0642)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 40 / 32,
  );

  /// Estilo para enfatizar texto em tela menor, destacando região importante de conteúdo, tamanho médio do **Headline**
  ///
  /// Tamanho de fonte 28, altura da linha 36 com estilo regular
  /// [Estilo Headline](https://m3.material.io/styles/typography/applying-type#43511b5a-fe60-4125-ac0c-571c4e6f0642)
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 36 / 28,
  );

  /// Estilo para enfatizar texto em tela menor, destacando região importante de conteúdo, tamanho pequeno do **Headline**
  ///
  /// Tamanho de fonte 24, altura da linha 32 com estilo regular
  ///
  /// [Estilo Headline](https://m3.material.io/styles/typography/applying-type#43511b5a-fe60-4125-ac0c-571c4e6f0642)
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 32 / 24,
  );

  /// Estilo para divisão de conteúdo secundário or região secundária de conteúdo, tamanho grande do **Title**
  ///
  /// Tamanho de fonte 22, altura da linha 28 com estilo regular
  ///
  /// [Estilo Title](https://m3.material.io/styles/typography/applying-type#e9e0cea3-10cb-405d-98a9-cf6a90758967)
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 28 / 22,
  );

  /// Estilo para divisão de conteúdo secundário or região secundária de conteúdo, tamanho médio do **Title**
  ///
  /// Tamanho de fonte 16, altura da linha 24 com estilo medium
  ///
  /// [Estilo Title](https://m3.material.io/styles/typography/applying-type#e9e0cea3-10cb-405d-98a9-cf6a90758967)
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.15,
    height: 24 / 16,
  );

  /// Estilo para divisão de conteúdo secundário or região secundária de conteúdo, tamanho pequeno do **Title**
  ///
  /// Tamanho de fonte 14, altura da linha 20 com estilo medium
  ///
  /// [Estilo Title](https://m3.material.io/styles/typography/applying-type#e9e0cea3-10cb-405d-98a9-cf6a90758967)
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.1,
    height: 20 / 14,
  );

  /// Estilo para longos conteúdo de texto, tamanho grande do **Body**
  ///
  /// Tamanho de fonte 16, altura da linha 24 com estilo regular
  ///
  /// [Estilo Body](https://m3.material.io/styles/typography/applying-type#19205dc2-64ec-4954-a95c-6e6b214c707e)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    letterSpacing: 0.5,
    height: 24 / 16,
  );

  /// Estilo para longos conteúdo de texto, tamanho médio do **Body**
  ///
  /// Tamanho de fonte 14, altura da linha 20 com estilo regular
  ///
  /// [Estilo Body](https://m3.material.io/styles/typography/applying-type#19205dc2-64ec-4954-a95c-6e6b214c707e)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  /// Estilo para longos conteúdo de texto, tamanho pequeno do **Body**
  ///
  /// Tamanho de fonte 12, altura da linha 16 com estilo regular
  ///
  /// [Estilo Body](https://m3.material.io/styles/typography/applying-type#19205dc2-64ec-4954-a95c-6e6b214c707e)
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    letterSpacing: 0.4,
    height: 16 / 12,
  );

  /// Estilo para texto dentro de componentes, tamanho grande do **Label**
  ///
  /// Tamanho de fonte 14, altura da linha 20 com estilo medium
  ///
  /// [Estilo Label](https://m3.material.io/styles/typography/applying-type#af6eb002-9cbb-4b64-bce6-1315d2252364)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.1,
    height: 20 / 14,
  );

  /// Estilo para texto dentro de componentes, tamanho médio do **Label**
  ///
  /// Tamanho de fonte 12, altura da linha 16 com estilo medium
  ///
  /// [Estilo Label](https://m3.material.io/styles/typography/applying-type#af6eb002-9cbb-4b64-bce6-1315d2252364)
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.5,
    height: 16 / 12,
  );

  /// Estilo para texto dentro de componentes, tamanho pequeno do **Label**
  ///
  /// Tamanho de fonte 11, altura da linha 16 com estilo medium
  ///
  /// [Estilo Label](https://m3.material.io/styles/typography/applying-type#af6eb002-9cbb-4b64-bce6-1315d2252364)
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    height: 16 / 11,
  );
}

class _PenhasFontWeight {
  static const FontWeight medium = FontWeight.w700;
  static const FontWeight regular = FontWeight.w400;
}
