import 'package:equatable/equatable.dart';

class NotificationSessionEntity extends Equatable {
  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity>? notifications;

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

  @override
  bool get stringify => true;
}

class NotificationEntity extends Equatable {
  final String? name;
  final DateTime? time;
  final String? icon;
  final String? title;
  final String? content;
  final String? route;

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

  @override
  bool get stringify => true;
}
