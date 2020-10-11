import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';

import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';

part 'chat_main_talks_controller.g.dart';

class ChatMainTalksController extends _ChatMainTalksControllerBase
    with _$ChatMainTalksController {
  ChatMainTalksController({
    @required IChatChannelRepository chatChannelRepository,
  }) : super(chatChannelRepository);
}

abstract class _ChatMainTalksControllerBase with Store, MapFailureMessage {
  final IChatChannelRepository _chatChannelRepository;

  _ChatMainTalksControllerBase(this._chatChannelRepository) {
    _init();
  }

  Future<void> _init() async {
    await loadScreen();
  }

  @observable
  ObservableFuture<Either<Failure, ChatChannelAvailableEntity>> _fetchProgress;

  @observable
  ChatMainTalksState currentState = ChatMainTalksState.initial();

  @action
  Future<void> reload() {}

  @action
  Future<void> openChannel(ChatChannelEntity channel) {
    print(channel);
  }
}

extension _ChatMainTalksControllerBasePrivate on _ChatMainTalksControllerBase {
  Future<void> loadScreen() async {
    currentState = ChatMainTalksState.loading();
    _fetchProgress = ObservableFuture(_chatChannelRepository.listChannel());

    final response = await _fetchProgress;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  void handleLoadSession(ChatChannelAvailableEntity session) {
    List<ChatMainTileEntity> tiles = List<ChatMainTileEntity>();
    List<ChatMainSupportTile> cards = List<ChatMainSupportTile>();

    if (session.support != null) {
      cards.add(
        ChatMainSupportTile(
          title: session.support.user.nickname,
          content: "Fale com as adminstradoras do app",
          channel: session.support,
        ),
      );
    }

    if (cards.isNotEmpty) {
      tiles.add(ChatMainAssistantCardTile(cards: cards));
    }

    if (session.channels.isNotEmpty) {
      final total = session.channels.length;
      final title = total > 1 ? "Suas conversas ($total)" : "Sua conversa";
      tiles.add(ChatMainChannelHeaderTile(title: title));
      final channels = session.channels
          .map((e) => ChatMainChannelCardTile(channel: e))
          .toList();
      tiles.addAll(channels);
    }

    currentState = ChatMainTalksState.loaded(tiles);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = ChatMainTalksState.error(message);
  }
}

/*
                ChatAssistantCard(
                  title: "Assistente PenhaS",
                  description: "Entenda se você está em situação de violência",
                  icon: Image.asset(
                    "assets/images/chat/penhasAssistant/penhasAssistant.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                ChatAssistantCard(
                  title: "Contato PenhaS",
                  description: "Fale com as adminstradoras do app",
                  icon: Image.asset(
                    "assets/images/chat/penhasContact/penhasContact.png",
                    width: 40,
                    height: 40,
                  ),
                )
*/
