import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_channel_entity.dart';

abstract class ChatMainTileEntity extends Equatable {}

class ChatMainAssistantCardTile extends ChatMainTileEntity {
  final List<ChatMainSupportTile> cards;

  ChatMainAssistantCardTile({
    @required this.cards,
  });

  @override
  List<Object> get props => [cards];
}

class ChatMainSupportTile extends ChatMainTileEntity {
  final String title;
  final String content;
  final ChatChannelEntity channel;

  ChatMainSupportTile({
    @required this.title,
    @required this.content,
    @required this.channel,
  });

  @override
  List<Object> get props => [title];
}
