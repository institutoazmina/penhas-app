import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
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
      (failure) => handleFailure(failure),
      (session) => handleProfileDetail(session),
    );
  }

  Future<void> loadChat(int clientId) async {
    final channel = await _channelRepository.openChannel(clientId.toString());

    channel.fold(
      (failure) => handleFailure(failure),
      (session) => handleChatSesssion(session),
    );
  }

  void handleProfileDetail(UserDetailEntity userProfile) {
    Modular.to.pushReplacementNamed(
      "/mainboard/users/profile_from_feed",
      arguments: userProfile.profile,
    );
  }

  void handleFailure(Failure failure) {
    routingState = FeedRoutingState.error(
      pageTitle(),
      mapFailureMessage(failure),
    );
  }

  void handleChatSesssion(ChatChannelOpenEntity session) {
    Modular.to.pushReplacementNamed(
      "/mainboard/chat_from_feed",
      arguments: session,
    );
  }
}
