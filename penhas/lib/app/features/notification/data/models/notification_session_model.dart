import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';
import 'package:meta/meta.dart';

class NotificationSessionModel extends NotificationSessionEntity {
  final bool hasMore;
  final String nextPage;
  final List<NotificationEntity> notifications;

  NotificationSessionModel({
    @required this.hasMore,
    @required this.nextPage,
    @required this.notifications,
  }) : super(
          hasMore: hasMore,
          nextPage: nextPage,
          notifications: notifications,
        );

  factory NotificationSessionModel.fromJson(Map<String, Object> jsonData) {
    final hasMore = jsonData["has_more"] == 1 ?? false;
    final nextPage = jsonData["next_page"];
    final jsonRows = jsonData["rows"] as List<Object>;
    final notifications = jsonRows
        .map((e) => e as Map<String, Object>)
        .map((e) => _Parse.fromJson(e))
        .toList();

    return NotificationSessionModel(
      hasMore: hasMore,
      nextPage: nextPage,
      notifications: notifications,
    );
  }
}

extension _Parse on NotificationEntity {
  static NotificationEntity fromJson(Map<String, Object> jsonData) {
    final content = jsonData["content"];
    final icon = jsonData["icon"];
    final title = jsonData["title"];
    final time = DateTime.tryParse(jsonData["time"]);
    final name = jsonData["name"];
    final route = jsonData["expand_screen"];

    return NotificationEntity(
      name: name,
      content: content,
      icon: icon,
      title: title,
      time: time,
      route: route,
    );
  }
}
