import 'package:equatable/equatable.dart';

class NotificationSessionEntity extends Equatable {
  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity>? notifications;

  NotificationSessionEntity({
    required this.hasMore,
    required this.nextPage,
    required this.notifications,
  });

  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity>? notifications;

  @override
  List<Object> get props => [
        this.hasMore,
        this.nextPage!,
        this.notifications!,
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

  NotificationEntity({
    required this.content,
    required this.icon,
    required this.name,
    required this.time,
    required this.title,
    required this.route,
  });

  final String? name;
  final DateTime? time;
  final String? icon;
  final String? title;
  final String? content;
  final String? route;

  @override
  List<Object> get props => [
        this.content!,
        this.icon!,
        this.name!,
        this.time!,
        this.title!,
        this.route!,
      ];

  @override
  bool get stringify => true;
}
