import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_controller.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_page.dart';

class ZodiacModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ZodiacController(userProfileStore: i.get<IUserProfileStore>()),
        ),
      ];

  static Inject get to => Inject<ZodiacModule>.of();

  @override
  Widget get view => ZodiacPage();
}
