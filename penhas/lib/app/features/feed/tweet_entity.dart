import 'package:meta/meta.dart';

class TweetEntity {
  final String userName;
  final String time;
  final String content;
  final TweetEntity reply;

  TweetEntity({
    @required this.userName,
    @required this.time,
    @required this.content,
    this.reply,
  });
}
