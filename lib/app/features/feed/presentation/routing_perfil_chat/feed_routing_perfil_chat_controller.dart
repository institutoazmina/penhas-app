import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../chat/domain/entities/chat_channel_open_entity.dart';
import '../../../chat/domain/repositories/chat_channel_repository.dart';
import '../../../users/data/repositories/users_repository.dart';
import '../../../users/domain/entities/user_detail_entity.dart';
import '../../domain/states/feed_router_type.dart';
import '../../domain/states/feed_routing_state.dart';

part 'feed_routing_perfil_chat_controller.g.dart';

class FeedRoutingPerfilChatController
    extends _FeedRoutingPerfilChatControllerBase
    with _$FeedRoutingPerfilChatController {
  FeedRoutingPerfilChatController({
    required IUsersRepository usersRepository,
    required IChatChannelRepository channelRepository,
    required FeedRouterType routerType,
  }) : super(routerType, usersRepository, channelRepository);
}

abstract class _FeedRoutingPerfilChatControllerBase
    with Store, MapFailureMessage {
  _FeedRoutingPerfilChatControllerBase(
    this._routerType,
    this._usersRepository,
    this._channelRepository,
  ) {
    _loadRouterData();
  }

  final FeedRouterType _routerType;
  final IUsersRepository _usersRepository;
  final IChatChannelRepository _channelRepository;

  @observable
  FeedRoutingState routingState = const FeedRoutingState.initial('');

  @action
  void retry() => _loadRouterData();

  void _loadRouterData() async {
    routingState = FeedRoutingState.initial(
      _getPageTitle(),
    );

    _routerType.when(
      chat: _loadChat,
      profile: _loadProfile,
    );
  }

  String _getPageTitle() {
    return _routerType.when(
      chat: (_) => 'Chat',
      profile: (_) => 'Perfil',
    );
  }

  Future<void> _loadProfile(int clientId) async {
    final result = await _usersRepository.profileDetail(clientId.toString());
    result.fold(_handleFailure, _handleProfileDetail);
  }

  Future<void> _loadChat(int clientId) async {
    final channel = await _channelRepository.openChannel(clientId.toString());
    channel.fold(_handleFailure, _handleChatSesssion);
  }

  void _handleProfileDetail(UserDetailEntity userProfile) {
    Modular.to.pushReplacementNamed(
      '/mainboard/users/profile_from_feed',
      arguments: userProfile,
    );
  }

  void _handleChatSesssion(ChatChannelOpenEntity chat) {
    Modular.to.pushReplacementNamed(
      '/mainboard/chat_from_feed',
      arguments: chat,
    );
  }

  void _handleFailure(Failure failure) {
    routingState = FeedRoutingState.error(
      _getPageTitle(),
      mapFailureMessage(failure)!,
    );
  }
}
