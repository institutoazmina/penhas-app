import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
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
import 'package:penhas/app/shared/logger/log.dart';

abstract class IChatChannelRepository {
  Future<Either<Failure, ChatChannelAvailableEntity>> listChannel();
  Future<Either<Failure, ChatChannelOpenEntity>> openChannel(String clientId);
  Future<Either<Failure, ChatChannelSessionEntity>> getMessages(
    ChatChannelRequest option,
  );
  Future<Either<Failure, ChatSentMessageResponseEntity>> sentMessage(
    ChatChannelRequest option,
  );
  Future<Either<Failure, ValidField>> blockChannel(ChatChannelRequest option);
  Future<Either<Failure, ValidField>> deleteChannel(ChatChannelRequest option);
}

class ChatChannelRepository implements IChatChannelRepository {
  ChatChannelRepository({
    required IApiProvider? apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider? _apiProvider;

  @override
  Future<Either<Failure, ChatChannelAvailableEntity>> listChannel() async {
    const endPoint = '/me/chats';

    try {
      final response = await _apiProvider!.get(path: endPoint).parseSession();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatChannelOpenEntity>> openChannel(
    String clientId,
  ) async {
    const endPoint = '/me/chats-session';
    final parameters = {
      'prefetch': '1',
      'cliente_id': clientId,
    };

    try {
      final response = await _apiProvider!
          .post(
            path: endPoint,
            parameters: parameters,
          )
          .parseOpenChannel();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatChannelSessionEntity>> getMessages(
    ChatChannelRequest option,
  ) async {
    const endPoint = '/me/chats-messages';
    final parameters = {
      'chat_auth': option.token,
      'pagination': option.pagination,
      'rows': '${option.rows}'
    };

    try {
      final response = await _apiProvider!
          .get(
            path: endPoint,
            parameters: parameters,
          )
          .parseSessionChannel();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ChatSentMessageResponseEntity>> sentMessage(
    ChatChannelRequest option,
  ) async {
    const endPoint = '/me/chats-messages';
    final parameters = {
      'chat_auth': option.token,
    };

    final bodyContent = 'message=${Uri.encodeComponent(option.message!)}';

    try {
      final response = await _apiProvider!
          .post(
            path: endPoint,
            parameters: parameters,
            body: bodyContent,
          )
          .then((v) => jsonDecode(v) as Map<String, dynamic>)
          .then((v) => ChatSentMessageResponseEntity.fromJson(v));
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> blockChannel(
    ChatChannelRequest option,
  ) async {
    const endPoint = '/me/manage-blocks';
    final parameters = {
      'block': option.block! ? '1' : '0',
      'cliente_id': option.clientId,
    };

    try {
      await _apiProvider!.post(
        path: endPoint,
        parameters: parameters,
      );
      return right(const ValidField());
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> deleteChannel(
    ChatChannelRequest option,
  ) async {
    const endPoint = '/me/chats-session';
    final parameters = {'chat_auth': option.token};

    try {
      await _apiProvider!.delete(
        path: endPoint,
        parameters: parameters,
      );
      return right(const ValidField());
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _ChatChannelRepository<T extends String> on Future<T> {
  Future<ChatChannelAvailableEntity> parseSession() async {
    return then((v) => jsonDecode(v) as Map<String, dynamic>)
        .then((v) => ChatChannelAvailableModel.fromJson(v));
  }

  Future<ChatChannelOpenEntity> parseOpenChannel() async {
    return then((v) => jsonDecode(v) as Map<String, dynamic>)
        .then((v) => ChatChannelOpenModel.fromJson(v));
  }

  Future<ChatChannelSessionEntity> parseSessionChannel() async {
    return then((v) => jsonDecode(v) as Map<String, dynamic>)
        .then((v) => ChatChannelSessionModel.fromJson(v));
  }
}
