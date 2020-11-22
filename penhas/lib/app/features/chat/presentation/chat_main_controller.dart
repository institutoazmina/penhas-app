import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_tab_item.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';

part 'chat_main_controller.g.dart';

class ChatMainController extends _ChatMainControllerBase
    with _$ChatMainController {
  ChatMainController({
    @required ChatPrivateToggleFeature chatToggleFeature,
  }) : super(chatToggleFeature);
}

abstract class _ChatMainControllerBase with Store {
  final ChatPrivateToggleFeature _chatToggleFeature;

  _ChatMainControllerBase(this._chatToggleFeature) {
    _init();
  }

  Future<void> _init() async {
    List<ChatTabItem> items = [ChatTabItem(headerName: "Conversas")];
    tabItems = items.asObservable();

    if (await _chatToggleFeature.isEnabled) {
      items.add(ChatTabItem(headerName: "Pessoas"));
      tabItems = items.asObservable();
    }
  }

  @observable
  ObservableList<ChatTabItem> tabItems = ObservableList<ChatTabItem>();
}
