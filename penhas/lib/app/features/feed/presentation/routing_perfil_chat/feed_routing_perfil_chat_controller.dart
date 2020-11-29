import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_router_option.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

part 'feed_routing_perfil_chat_controller.g.dart';

class FeedRoutingPerfilChatController
    extends _FeedRoutingPerfilChatControllerBase
    with _$FeedRoutingPerfilChatController {
  FeedRoutingPerfilChatController({
    @required IUsersRepository usersRepository,
    @required IChatChannelRepository channelRepository,
    @required TweetRouterOption routerOption,
  }) : super(routerOption, usersRepository, channelRepository);
}

abstract class _FeedRoutingPerfilChatControllerBase with Store {
  final TweetRouterOption routerOption;
  final IUsersRepository _usersRepository;
  final IChatChannelRepository _channelRepository;

  _FeedRoutingPerfilChatControllerBase(
      this.routerOption, this._usersRepository, this._channelRepository);
}
