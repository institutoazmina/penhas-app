import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/extension/safely_parser.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entities/notification_session_entity.dart';
import '../models/notification_session_model.dart';

abstract class INotificationRepository {
  Future<Either<Failure, ValidField>> unread();
  Future<Either<Failure, NotificationSessionModel>> notifications();
}

class NotificationRepository implements INotificationRepository {
  NotificationRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, ValidField>> unread() async {
    const endPoint = '/me/unread-notif-count';

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
      );
      return right(parseUnread(bodyResponse));
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, NotificationSessionModel>> notifications() async {
    const endPoint = '/me/notifications';
    final Map<String, String> parameters = {
      'rows': '1000',
    };

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
        parameters: parameters,
      );
      return right(
          parseNotifications(bodyResponse) as NotificationSessionModel);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _ParsePrivate on NotificationRepository {
  ValidField parseUnread(String body) {
    final Map<String, dynamic> jsonData = jsonDecode(body);
    final count = "${jsonData["count"]}".safeParseInt();
    return ValidField(message: count.toString());
  }

  NotificationSessionEntity parseNotifications(String body) {
    final jsonData = jsonDecode(body);
    return NotificationSessionModel.fromJson(jsonData);
  }
}
