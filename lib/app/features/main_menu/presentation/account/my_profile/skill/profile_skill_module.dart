import 'package:flutter_modular/flutter_modular.dart';

import 'profile_skill_controller.dart';
import 'profile_skill_page.dart';

class ProfileSkillModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => ProfileSkillController(tags: i.args.data),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ProfileSkillPage(
            controller: Modular.get<ProfileSkillController>(),
          ),
        )
      ];
}
