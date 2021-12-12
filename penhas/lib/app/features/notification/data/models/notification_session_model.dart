import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

class NotificationSessionModel extends NotificationSessionEntity {
  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity>? notifications;

  NotificationSessionModel({
    required this.hasMore,
    required this.nextPage,
    required this.notifications,
  }) : super(
          hasMore: hasMore,
          nextPage: nextPage,
          notifications: notifications,
        );

  factory NotificationSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final hasMore = jsonData['has_more'] == 1;
    final nextPage = jsonData['next_page'];
    final List jsonRows = jsonData['rows'];
    final notifications = jsonRows
        .map((e) => _Parse.fromJson(e))
        .toList();

    return NotificationSessionModel(
      hasMore: hasMore,
      nextPage: nextPage as String?,
      notifications: notifications,
    );
  }
}

extension _Parse on NotificationEntity {
  static NotificationEntity fromJson(Map<String, Object> jsonData) {
    final content = jsonData["content"];
    final icon = jsonData["icon"];
    final title = jsonData["title"];
    final time = DateTime.tryParse(jsonData["time"] as String);
    final name = jsonData["name"];
    final route = jsonData["expand_screen"];

    return NotificationEntity(
      name: name as String?,
      content: content as String?,
      icon: icon as String?,
      title: title as String?,
      time: time,
      route: route as String?,
    );
  }
}
