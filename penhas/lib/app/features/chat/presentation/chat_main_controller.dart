import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';

part 'chat_main_controller.g.dart';

class ChatMainController extends _ChatMainControllerBase
    with _$ChatMainController {
  ChatMainController({
    @required ChatToggleFeature chatToggleFeature,
  }) : super(chatToggleFeature);
}

abstract class _ChatMainControllerBase with Store {
  final ChatToggleFeature _chatToggleFeature;

  _ChatMainControllerBase(this._chatToggleFeature) {
    _init();
  }

  Future<void> _init() async {
    showPeopleScreen = await _chatToggleFeature.isEnabled;
  }

  @observable
  bool showPeopleScreen = false;
}
