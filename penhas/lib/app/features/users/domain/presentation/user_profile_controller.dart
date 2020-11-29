import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/states/user_profile_state.dart';

part 'user_profile_controller.g.dart';

class UserProfileController extends _UserProfileControllerBase
    with _$UserProfileController {
  UserProfileController({
    @required UserDetailProfileEntity person,
    @required IChatChannelRepository channelRepository,
  }) : super(person, channelRepository);
}

abstract class _UserProfileControllerBase with Store {
  final UserDetailProfileEntity _person;
  final IChatChannelRepository _channelRepository;

  _UserProfileControllerBase(this._person, this._channelRepository) {
    _init();
  }

  void _init() {
    currentState = UserProfileState.loaded(_person);
  }

  @observable
  UserProfileState currentState = UserProfileState.initial();

  @action
  Future<void> openChannel() async {
    final channel = await _channelRepository.openChannel(
      _person.clientId.toString(),
    );

    channel.fold(
      (failure) => handleFailure(failure),
      (session) => handleSession(session),
    );
  }
}

extension _UserProfileControllerBasePrivate on _UserProfileControllerBase {
  void handleSession(ChatChannelOpenEntity session) {
    Modular.to.pushReplacementNamed(
      "/mainboard/chat",
      arguments: session,
    );
  }

  void handleFailure(Failure failure) {
    print(failure);
  }
}
