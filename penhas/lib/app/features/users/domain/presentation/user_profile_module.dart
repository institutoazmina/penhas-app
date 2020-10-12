import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/domain/presentation/user_profile_page.dart';

class UserProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => UserProfileController(
            person: i.args.data,
          ),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/profile', child: (_, args) => UserProfilePage()),
      ];

  static Inject get to => Inject<UserProfileModule>.of();
}
