import 'dart:async';

import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_state.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_channel_usecase.dart';

part 'chat_channel_controller.g.dart';

class ChatChannelController extends _ChatChannelControllerBase
    with _$ChatChannelController {
  ChatChannelController({@required ChatChannelUseCase useCase})
      : super(useCase);
}

abstract class _ChatChannelControllerBase with Store, MapFailureMessage {
  final ChatChannelUseCase _useCase;
  StreamSubscription _streamDatasource;

  _ChatChannelControllerBase(this._useCase) {
    registerStreamSource();
  }

  @observable
  ChatChannelState currentState = ChatChannelState.initial();

  @action
  void blockChat() {}

  @action
  void deleteSession() {}

  void dispose() {
    cancelStreamSource();
  }
}

extension _ChatChannelControllerBasePrivate on _ChatChannelControllerBase {
  void registerStreamSource() {
    _streamDatasource = _useCase.dataSource.listen((event) {});
  }

  void parseStream(ChatChannelUseCaseEvent event) {
    print(event);
  }

  void cancelStreamSource() {
    if (_streamDatasource != null) {
      _streamDatasource.cancel();
      _streamDatasource = null;
    }

    _useCase.dispose();
  }
}
