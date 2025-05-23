import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../escape_manual/domain/entity/quiz_page_args.dart';
import '../../domain/entities/chat_channel_available_entity.dart';
import '../../domain/entities/chat_channel_entity.dart';
import '../../domain/entities/chat_channel_open_entity.dart';
import '../../domain/entities/chat_main_tile_entity.dart';
import '../../domain/entities/chat_user_entity.dart';
import '../../domain/repositories/chat_channel_repository.dart';
import '../../domain/states/chat_main_talks_state.dart';

part 'chat_main_talks_controller.g.dart';

class ChatMainTalksController = IChatMainTalksController
    with _$ChatMainTalksController;

abstract class IChatMainTalksController with Store, MapFailureMessage {
  IChatMainTalksController({
    required IChatChannelRepository chatChannelRepository,
  }) : _chatChannelRepository = chatChannelRepository;

  final IChatChannelRepository _chatChannelRepository;

  Future<void> initialize() async {
    await loadScreen();
  }

  @observable
  ObservableFuture<Either<Failure, ChatChannelAvailableEntity>>? _fetchProgress;

  @observable
  ChatMainTalksState currentState = const ChatMainTalksState.initial();

  @action
  Future<void> reload() async {
    await loadScreen();
  }

  @action
  Future<void> openChannel(ChatChannelEntity channel) async {
    final ChatChannelOpenEntity session =
        ChatChannelOpenEntity(token: channel.token);

    await forwardToChat(session);
  }

  @action
  Future<void> openAssistantCard(ChatMainSupportTile data) async {
    if (data.quizSession != null) {
      await Modular.to.pushNamed(
        '/quiz',
        arguments: QuizPageArgs(origin: 'chat', session: data.quizSession!),
      );

      return;
    }

    final ChatChannelOpenEntity session =
        ChatChannelOpenEntity(token: data.channel!.token);

    await forwardToChat(session);
  }
}

extension _ChatMainTalksControllerBasePrivate on IChatMainTalksController {
  Future<void> forwardToChat(ChatChannelOpenEntity session) async {
    return Modular.to
        .pushNamed('/mainboard/chat/${session.token}', arguments: session)
        .then(
      (value) async {
        if (value is bool && value) {
          await loadScreen();
        }
      },
    );
  }

  Future<void> loadScreen() async {
    currentState = const ChatMainTalksState.loading();
    _fetchProgress = ObservableFuture(_chatChannelRepository.listChannel());

    final Either<Failure, ChatChannelAvailableEntity> response =
        await _fetchProgress!;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  void handleLoadSession(ChatChannelAvailableEntity session) {
    final List<ChatMainTileEntity> tiles = [];
    final List<ChatMainSupportTile> cards = [];

    if (session.assistant != null) {
      cards.add(
        ChatMainSupportTile(
          title: session.assistant!.title!,
          content: session.assistant!.subtitle!,
          channel: ChatChannelEntity(
            token: null,
            lastMessageTime: null,
            lastMessageIsMime: null,
            user: ChatUserEntity(
                userId: null,
                activity: null,
                blockedMe: false,
                avatar: session.assistant!.avatar,
                nickname: session.assistant!.title,
                badges: const []),
          ),
          quizSession: session.assistant!.quizSession,
        ),
      );
    }

    if (session.support != null) {
      cards.add(
        ChatMainSupportTile(
          title: session.support!.user.nickname!,
          content: 'Fale com as adminstradoras do app',
          channel: session.support,
        ),
      );
    }

    if (cards.isNotEmpty) {
      tiles.add(ChatMainAssistantCardTile(cards: cards));
    }

    if (session.channels?.isEmpty == false) {
      final total = session.channels!.length;
      final title = total > 1 ? 'Suas conversas ($total)' : 'Sua conversa';
      tiles.add(ChatMainChannelHeaderTile(title: title));
      final channels = session.channels!
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
