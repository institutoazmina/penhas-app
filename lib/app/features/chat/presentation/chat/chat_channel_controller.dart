import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_state.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_channel_usecase.dart';
import 'package:penhas/app/features/chat/presentation/chat/chat_channel_compose_type.dart';

part 'chat_channel_controller.g.dart';

class ChatChannelController extends _ChatChannelControllerBase
    with _$ChatChannelController {
  ChatChannelController({required ChatChannelUseCase useCase}) : super(useCase);
}

abstract class _ChatChannelControllerBase with Store, MapFailureMessage {
  _ChatChannelControllerBase(this._useCase) {
    _streamDatasource = _useCase.dataSource.listen(parseStream);
  }

  final ChatChannelUseCase _useCase;
  late StreamSubscription _streamDatasource;

  @observable
  ChatChannelState currentState = const ChatChannelState.initial();

  @observable
  ChatUserEntity user = ChatUserEntity.empty();

  @observable
  ChatChannelSessionMetadataEntity metadata =
      ChatChannelSessionMetadataEntity.empty();

  @observable
  ObservableList<ChatChannelMessage> channelMessages =
      ObservableList<ChatChannelMessage>();

  @computed
  ChatChannelComposerType get composerType {
    if (metadata.canSendMessage == false &&
        metadata.didBlocked == false &&
        metadata.isBlockable) {
      return ChatChannelComposerType.blockedByOwner;
    }

    if (metadata.canSendMessage == false &&
        metadata.didBlocked &&
        metadata.isBlockable) {
      return ChatChannelComposerType.blockedByMe;
    }

    return ChatChannelComposerType.sentMessage;
  }

  @action
  Future<void> blockChat() async {
    await _useCase.block();
  }

  @action
  Future<void> unBlockChat() async {
    await _useCase.unblock();
  }

  @action
  Future<void> deleteSession() async {
    await _useCase.delete();
    Modular.to.pop(true);
  }

  @action
  Future<void> sentMessage(String message) async {
    await _useCase.sentMessage(message);
  }

  void dispose() {
    cancelStreamSource();
  }
}

extension _ChatChannelControllerBasePrivate on _ChatChannelControllerBase {
  void parseStream(ChatChannelUseCaseEvent event) {
    event.when(
      updateUser: (u) => user = u,
      updateMetada: (m) => metadata = m,
      initial: () => currentState = const ChatChannelState.initial(),
      loaded: () => currentState = const ChatChannelState.loaded(),
      errorOnLoading: (m) => currentState = ChatChannelState.error(m),
      updateMessage: (m) => channelMessages = m.asObservable(),
    );
  }

  void cancelStreamSource() {
    _streamDatasource.cancel();

    _useCase.dispose();
  }
}
