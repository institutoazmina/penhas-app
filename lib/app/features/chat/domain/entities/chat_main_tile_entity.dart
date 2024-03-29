import 'package:equatable/equatable.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../users/domain/entities/user_detail_profile_entity.dart';
import 'chat_channel_entity.dart';

abstract class ChatMainTileEntity extends Equatable {}

class ChatMainAssistantCardTile extends ChatMainTileEntity {
  ChatMainAssistantCardTile({
    required this.cards,
  });

  final List<ChatMainSupportTile> cards;

  @override
  List<Object?> get props => [cards];
}

class ChatMainSupportTile extends ChatMainTileEntity {
  ChatMainSupportTile({
    required this.title,
    required this.content,
    this.channel,
    this.quizSession,
  });

  final String title;
  final String content;
  final ChatChannelEntity? channel;
  final QuizSessionEntity? quizSession;

  @override
  List<dynamic> get props => [title, content, channel, quizSession];
}

class ChatMainChannelHeaderTile extends ChatMainTileEntity {
  ChatMainChannelHeaderTile({
    required this.title,
  });

  final String title;

  @override
  List<Object?> get props => [title];
}

class ChatMainChannelCardTile extends ChatMainTileEntity {
  ChatMainChannelCardTile({
    required this.channel,
  });

  final ChatChannelEntity channel;

  @override
  List<Object?> get props => [channel];
}

class ChatMainPeopleFilterCardTile extends ChatMainTileEntity {
  ChatMainPeopleFilterCardTile(
    this.totalFiltersSeleted,
  );

  final int totalFiltersSeleted;

  @override
  List<Object?> get props => [totalFiltersSeleted];
}

class ChatMainPeopleCardTile extends ChatMainTileEntity {
  ChatMainPeopleCardTile({
    required this.person,
  });

  final UserDetailProfileEntity person;

  @override
  List<Object?> get props => [person];
}
