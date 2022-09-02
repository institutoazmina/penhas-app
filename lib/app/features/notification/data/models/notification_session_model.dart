import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

class NotificationSessionModel extends NotificationSessionEntity {
  const NotificationSessionModel({
    required bool hasMore,
    required String? nextPage,
    required List<NotificationEntity>? notifications,
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
      nextPage: nextPage,
      notifications: notifications,
    );
  }
}

extension _Parse on NotificationEntity {
  static NotificationEntity fromJson(Map<String, dynamic> jsonData) {
    final content = jsonData['content'];
    final icon = jsonData['icon'];
    final title = jsonData['title'];
    final time = DateTime.tryParse(jsonData['time'] as String);
    final name = jsonData['name'];
    final route = jsonData['expand_screen'];

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
