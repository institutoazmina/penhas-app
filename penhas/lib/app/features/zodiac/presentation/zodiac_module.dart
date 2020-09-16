import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_controller.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_page.dart';

class ZodiacModule extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((i) => ZodiacController())];

  static Inject get to => Inject<ZodiacModule>.of();

  @override
  Widget get view => ZodiacPage();
}
