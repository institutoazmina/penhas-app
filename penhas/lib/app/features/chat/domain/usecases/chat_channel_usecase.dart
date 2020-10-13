import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';

import 'package:meta/meta.dart';

class ChatChannelUseCase {
  final IChatChannelRepository _channelRepository;

  // final StreamController<FeedCache> _streamController =
  //     StreamController.broadcast();

  // Stream<FeedCache> get dataSource => _streamController.stream;
  // List<TweetTiles> _tweetCacheFetch = List<TweetTiles>();
  // Map<String, List<TweetEntity>> _tweetReplyMap = {};
  // String _nextPage;

  ChatChannelUseCase({
    @required ChatChannelOpenEntity session,
    @required IChatChannelRepository channelRepository,
  }) : this._channelRepository = channelRepository {
    initial(session);
  }

  Future<void> block() {}

  Future<void> unblock() {}

  Future<void> delete() {}

  Future<void> message() {}
}

extension ChatChannelUseCasePrivateMethods on ChatChannelUseCase {
  Future<void> initial(ChatChannelOpenEntity session) {}
}
