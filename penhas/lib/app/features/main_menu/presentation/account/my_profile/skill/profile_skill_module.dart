import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/profile_skill_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/skill/profile_skill_page.dart';

class ProfileSkillModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ProfileSkillController(tags: i.args.data),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (context, args) => ProfileSkillPage(),
        )
      ];

  static Inject get to => Inject<ProfileSkillModule>.of();
}
