import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

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

class ChatMainChannelHeaderTile extends ChatMainTileEntity {
  final String title;

  ChatMainChannelHeaderTile({
    @required this.title,
  });

  @override
  List<Object> get props => [title];
}

class ChatMainChannelCardTile extends ChatMainTileEntity {
  final ChatChannelEntity channel;

  ChatMainChannelCardTile({
    @required this.channel,
  });

  @override
  List<Object> get props => [channel];
}

class ChatMainPeopleFilterCardTile extends ChatMainTileEntity {
  final int totalFiltersSeleted;

  ChatMainPeopleFilterCardTile(
    this.totalFiltersSeleted,
  );

  @override
  List<Object> get props => [totalFiltersSeleted];
}

class ChatMainPeopleCardTile extends ChatMainTileEntity {
  final UserDetailProfileEntity person;

  ChatMainPeopleCardTile({
    @required this.person,
  });

  @override
  List<Object> get props => [person];
}
