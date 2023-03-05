import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../chat/domain/entities/chat_channel_open_entity.dart';
import '../../chat/domain/usecases/get_chat_channel_token_usecase.dart';
import '../domain/entities/user_detail_entity.dart';
import 'user_profile_state.dart';

part 'user_profile_controller.g.dart';

class UserProfileController extends _UserProfileControllerBase
    with _$UserProfileController {
  UserProfileController({
    required UserDetailEntity person,
    required GetChatChannelTokenUseCase getChatChannelToken,
  }) : super(person, getChatChannelToken);
}

abstract class _UserProfileControllerBase with Store, MapFailureMessage {
  _UserProfileControllerBase(
    this._person,
    this._getChatChannelToken,
  ) {
    _init();
  }

  final UserDetailEntity _person;
  final GetChatChannelTokenUseCase _getChatChannelToken;

  @observable
  UserProfileState state = const UserProfileState.initial();

  @observable
  UserProfileReaction? reaction;

  void _init() {
    state = UserProfileState.loaded(_person);
  }

  @action
  Future<void> openChannel() async {
    final channel = await _getChatChannelToken(_person.profile.clientId!);
    reaction = channel.fold(_handleFailure, _handleChatChannelSuccess);
  }

  UserProfileReaction? _handleChatChannelSuccess(ChatChannelOpenEntity chat) {
    Modular.to.pushReplacementNamed(
      '/mainboard/chat/${chat.token}',
      arguments: chat,
    );
    return null;
  }

  UserProfileReaction? _handleFailure(Failure error) {
    final errorMessage = mapFailureMessage(error);
    return errorMessage != null
        ? UserProfileReaction.showSnackBar(errorMessage)
        : null;
  }
}
