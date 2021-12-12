import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';
import 'package:penhas/app/features/filters/states/filter_action_observer.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_options.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

part 'chat_main_people_controller.g.dart';

class ChatMainPeopleController extends _ChatMainPeopleControllerBase
    with _$ChatMainPeopleController {
  ChatMainPeopleController({
    required IUsersRepository usersRepository,
    required IFilterSkillRepository skillRepository,
  }) : super(usersRepository, skillRepository);
}

abstract class _ChatMainPeopleControllerBase with Store, MapFailureMessage {
  List<FilterTagEntity> _tags = List.empty();
  final IUsersRepository _usersRepository;
  final IFilterSkillRepository _skillRepository;

  _ChatMainPeopleControllerBase(
    this._usersRepository,
    this._skillRepository,
  ) {
    _init();
  }

  List<FilterTagEntity> _tags = [];
  final IUsersRepository _usersRepository;
  final IFilterSkillRepository _skillRepository;

  Future<void> _init() async {
    await loadScreen(skills: _tags);
  }

  @observable
  ChatMainTalksState currentState = const ChatMainTalksState.initial();

  @action
  Future<void> reload() async {
    await loadScreen(skills: _tags);
  }

  @action
  Future<void> profile(UserDetailProfileEntity profile) {
    final userDetail = UserDetailEntity(isMyself: false, profile: profile);
    return Modular.to.pushNamed(
      '/mainboard/users/profile',
      arguments: userDetail,
    );
  }

  @action
  Future<void> filter() async {
    final result = await _skillRepository.skills();
    result.fold(
      (failure) => handleFilterError(failure),
      (skills) => handleFilterSuccess(skills!),
    );
  }
}

extension _ChatMainPeopleControllerBasePrivate
    on _ChatMainPeopleControllerBase {
  Future<void> loadScreen({
    required List<FilterTagEntity> skills,
  }) async {
    currentState = const ChatMainTalksState.loading();

    final response = await _usersRepository.search(
      UserSearchOptions(
        rows: 100,
        skills: skills.map((e) => e.id).toList(),
      ),
    );

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  void handleLoadSession(UserSearchSessionEntity session) {
    List<ChatMainTileEntity> tiles = List.empty();

    tiles.add(ChatMainPeopleFilterCardTile(_tags.length));

    if (session.users!.isNotEmpty) {
      final channels =
          session.users!.map((e) => ChatMainPeopleCardTile(person: e)).toList();
      tiles.addAll(channels);
    }

    currentState = ChatMainTalksState.loaded(tiles);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure)!;
    currentState = ChatMainTalksState.error(message);
  }

  void handleFilterError(Failure failure) {
    final message = mapFailureMessage(failure)!;
    currentState = ChatMainTalksState.error(message);
  }

  void handleFilterSuccess(List<FilterTagEntity> skills) {
    final tags = skills
        .map(
          (e) => FilterTagEntity(
            id: e.id,
            isSelected: isSeleted(e.id),
            label: e.label,
          ),
        )
        .toList();

    Modular.to
        .pushNamed('/mainboard/filters', arguments: tags)
        .then((v) => v as FilterActionObserver?)
        .then((v) => handleFilterUpdate(v));
  }

  bool isSeleted(String id) {
    try {
      _tags.firstWhere((v) => v.id == id);
      return true;
    } catch (e) {
      logError(e);
      return false;
    }
  }

  void handleFilterUpdate(FilterActionObserver? action) {
    if (action == null) {
      return;
    }

    _tags = action.when(
      reset: () => List.empty(),
      updated: (listTags) => listTags,
    );

    loadScreen(skills: _tags);
  }
}
