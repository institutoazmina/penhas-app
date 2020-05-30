import 'package:meta/meta.dart';

class TootEntity {
  final String userName;
  final String time;
  final String content;
  final TootEntity reply;

  TootEntity({
    @required this.userName,
    @required this.time,
    @required this.content,
    this.reply,
  });
}
