import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_controller.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_page.dart';

class ChatMainModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ChatMainController(
            chatToggleFeature: i.get<ChatToggleFeature>(),
          ),
        ),
        Bind<ChatToggleFeature>(
          (i) => ChatToggleFeature(
            modulesServices: i.get<IAppModulesServices>(),
          ),
        ),
      ];

  static Inject get to => Inject<ChatMainModule>.of();

  @override
  Widget get view => ChatMainPage();
}
