import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_options.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

part 'chat_main_people_controller.g.dart';

class ChatMainPeopleController extends _ChatMainPeopleControllerBase
    with _$ChatMainPeopleController {
  ChatMainPeopleController({
    @required IUsersRepository usersRepository,
  }) : super(usersRepository);
}

abstract class _ChatMainPeopleControllerBase with Store, MapFailureMessage {
  final IUsersRepository _usersRepository;

  _ChatMainPeopleControllerBase(this._usersRepository) {
    _init();
  }

  Future<void> _init() async {
    await loadScreen();
  }

  @observable
  ObservableFuture<Either<Failure, UserSearchSessionEntity>> _fetchProgress;

  @observable
  ChatMainTalksState currentState = ChatMainTalksState.initial();

  @action
  Future<void> reload() {}

  @action
  Future<void> openChannel(ChatChannelEntity channel) {
    print(channel);
  }
}

extension _ChatMainPeopleControllerBasePrivate
    on _ChatMainPeopleControllerBase {
  Future<void> loadScreen() async {
    currentState = ChatMainTalksState.loading();
    _fetchProgress = ObservableFuture(
      _usersRepository.search(UserSearchOptions(rows: 100)),
    );

    final response = await _fetchProgress;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  void handleLoadSession(UserSearchSessionEntity session) {
    List<ChatMainTileEntity> tiles = List<ChatMainTileEntity>();

    tiles.add(ChatMainPeopleFilterCardTile());

    if (session.users.isNotEmpty) {
      final channels =
          session.users.map((e) => ChatMainPeopleCardTile(person: e)).toList();
      tiles.addAll(channels);
    }

    currentState = ChatMainTalksState.loaded(tiles);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = ChatMainTalksState.error(message);
  }
}
