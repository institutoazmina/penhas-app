import 'package:equatable/equatable.dart';

class NotificationSessionEntity extends Equatable {
  const NotificationSessionEntity({
    required this.hasMore,
    required this.nextPage,
    required this.notifications,
  });

  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity>? notifications;

  @override
  List<Object?> get props => [
        hasMore,
        nextPage,
        notifications,
      ];
}

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.content,
    required this.icon,
    required this.name,
    required this.time,
    required this.title,
    this.route,
  });

  final String? name;
  final DateTime? time;
  final String? icon;
  final String? title;
  final String? content;
  final String? route;

  @override
  List<Object?> get props => [
        content,
        icon,
        name,
        time,
        title,
        route,
      ];
}
