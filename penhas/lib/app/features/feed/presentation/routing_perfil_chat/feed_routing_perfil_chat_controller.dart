import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/feed/domain/states/feed_router_type.dart';
import 'package:penhas/app/features/feed/domain/states/feed_routing_state.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';

part 'feed_routing_perfil_chat_controller.g.dart';

class FeedRoutingPerfilChatController
    extends _FeedRoutingPerfilChatControllerBase
    with _$FeedRoutingPerfilChatController {
  FeedRoutingPerfilChatController({
    @required IUsersRepository usersRepository,
    @required IChatChannelRepository channelRepository,
    @required FeedRouterType routerType,
  }) : super(routerType, usersRepository, channelRepository);
}

abstract class _FeedRoutingPerfilChatControllerBase
    with Store, MapFailureMessage {
  final FeedRouterType _routerType;
  final IUsersRepository _usersRepository;
  final IChatChannelRepository _channelRepository;

  _FeedRoutingPerfilChatControllerBase(
      this._routerType, this._usersRepository, this._channelRepository) {
    getRouterData();
    //
  }

  @observable
  FeedRoutingState routingState = FeedRoutingState.initial("");

  @action
  Future<void> retry() async {
    print("Ola mundo!");
  }
}

extension _PrivateMethod on _FeedRoutingPerfilChatControllerBase {
  Future<void> getRouterData() async {
    routingState = FeedRoutingState.initial(
      pageTitle(),
    );

    _routerType.when(
      chat: (clientId) => loadChat(clientId),
      profile: (clientId) => loadProfile(clientId),
    );
  }

  String pageTitle() {
    return _routerType.when(
      chat: (_) => "Chat",
      profile: (_) => "Perfil",
    );
  }

  Future<void> loadProfile(int clientId) async {
    final result = await _usersRepository.profileDetail(clientId.toString());
    result.fold(
      (failure) => handleError(failure),
      (session) => handleProfileDetail(session),
    );
  }

  Future<void> loadChat(int clientId) {
    print("ola mundo!");
  }

  void handleProfileDetail(UserDetailEntity userProfile) {
    // routingState = FeedRoutingState.profile(userProfile.profile);
    Modular.to.pushReplacementNamed(
      "/mainboard/users/profile",
      arguments: userProfile.profile,
    );
  }

  void handleError(Failure failure) {
    routingState = FeedRoutingState.error(
      pageTitle(),
      mapFailureMessage(failure),
    );
  }
}

/*
  @action
  Future<void> openChannel() async {
    final channel = await _channelRepository.openChannel(_person);

    channel.fold(
      (failure) => handleFailure(failure),
      (session) => handleSession(session),
    );
  }
}

extension _UserProfileControllerBasePrivate on _UserProfileControllerBase {
  void handleSession(ChatChannelOpenEntity session) {
    Modular.to.pushReplacementNamed("/mainboard/chat", arguments: session);
  }

  void handleFailure(Failure failure) {
    print(failure);
  }
}
*/
