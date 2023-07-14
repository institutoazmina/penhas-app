import 'package:mobx/mobx.dart';

import '../domain/entities/chat_tab_item.dart';
import '../domain/states/chat_main_security_state.dart';
import '../domain/usecases/chat_toggle_feature.dart';

part 'chat_main_controller.g.dart';

class ChatMainController extends _ChatMainControllerBase
    with _$ChatMainController {
  ChatMainController({
    required ChatPrivateToggleFeature chatToggleFeature,
  }) : super(chatToggleFeature);
}

abstract class _ChatMainControllerBase with Store {
  _ChatMainControllerBase(this._chatToggleFeature) {
    _init();
  }

  final ChatPrivateToggleFeature _chatToggleFeature;

  Future<void> _init() async {
    final List<ChatTabItem> items = [
      ChatTabItem.talks,
    ];

    if (await _chatToggleFeature.isEnabled) {
      securityState = const ChatMainSecurityState.supportAndPrivate();
      items.add(ChatTabItem.people);
    }

    tabItems = items.toList().asObservable();
  }

  @observable
  ChatMainSecurityState securityState = const ChatMainSecurityState.onlySupport();

  @observable
  ObservableList<ChatTabItem> tabItems = ObservableList<ChatTabItem>();
}
