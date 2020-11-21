import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NotificationSessionEntity extends Equatable {
  final bool hasMore;
  final String nextPage;
  final List<NotificationEntity> notifications;

  NotificationSessionEntity({
    @required this.hasMore,
    @required this.nextPage,
    @required this.notifications,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}

class NotificationEntity extends Equatable {
  final String name;
  final String time;
  final String icon;
  final String title;
  final String content;

  NotificationEntity({
    @required this.content,
    @required this.icon,
    @required this.name,
    @required this.time,
    @required this.title,
  });

  @override
  List<Object> get props => [
        this.content,
        this.icon,
        this.name,
        this.time,
        this.title,
      ];
}
