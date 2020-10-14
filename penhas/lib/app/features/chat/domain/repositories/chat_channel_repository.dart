import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_available_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_open_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_sent_message_response_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

abstract class IChatChannelRepository {
  Future<Either<Failure, ChatChannelAvailableEntity>> listChannel();
  Future<Either<Failure, ChatChannelOpenEntity>> openChannel(
      UserDetailProfileEntity user);
  Future<Either<Failure, ChatChannelSessionEntity>> getMessages(
      ChatChannelRequest option);
  Future<Either<Failure, ChatSentMessageResponseEntity>> sentMessage(
      ChatChannelRequest option);
}

class ChatChannelRepository implements IChatChannelRepository {
  final IApiProvider _apiProvider;

  ChatChannelRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, ChatChannelAvailableEntity>> listChannel() async {
    final endPoint = "/me/chats";

    try {
      final response = await _apiProvider.get(path: endPoint).parseSession();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatChannelOpenEntity>> openChannel(
      UserDetailProfileEntity user) async {
    final endPoint = "/me/chats-session";
    final parameters = {
      'prefetch': '1',
      'cliente_id': "${user.clientId}",
    };

    try {
      final response = await _apiProvider
          .post(
            path: endPoint,
            parameters: parameters,
          )
          .parseOpenChannel();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatChannelSessionEntity>> getMessages(
      ChatChannelRequest option) async {
    final endPoint = "/me/chats-messages";
    final parameters = {
      'chat_auth': option.token,
      'pagination': option.pagination,
      'rows': "${option.rows}"
    };

    try {
      final response = await _apiProvider
          .get(
            path: endPoint,
            parameters: parameters,
          )
          .parseSessionChannel();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatSentMessageResponseEntity>> sentMessage(
      ChatChannelRequest option) async {
    final endPoint = "/me/chats-messages";
    final parameters = {
      'chat_auth': option.token,
    };

    final bodyContent = Uri.encodeComponent(option.message);

    try {
      final response = await _apiProvider
          .post(
            path: endPoint,
            parameters: parameters,
            body: 'message=$bodyContent',
          )
          .then((v) => jsonDecode(v) as Map<String, Object>)
          .then((v) => ChatSentMessageResponseEntity.fromJson(v));
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _ChatChannelRepository<T extends String> on Future<T> {
  Future<ChatChannelAvailableEntity> parseSession() async {
    return this
        .then((v) => jsonDecode(v) as Map<String, Object>)
        .then((v) => ChatChannelAvailableModel.fromJson(v));
  }

  Future<ChatChannelOpenEntity> parseOpenChannel() async {
    return this
        .then((v) => jsonDecode(v) as Map<String, Object>)
        .then((v) => ChatChannelOpenModel.fromJson(v));
  }

  Future<ChatChannelSessionEntity> parseSessionChannel() async {
    return this
        .then((v) => jsonDecode(v) as Map<String, Object>)
        .then((v) => ChatChannelSessionModel.fromJson(v));
  }
}
