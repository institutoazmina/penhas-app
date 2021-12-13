import 'package:equatable/equatable.dart';

class TweetRequestOption extends Equatable {
  final int rows;
  final String? after;
  final String? before;
  final String? parent;
  final String? replyTo;
  final String? nextPageToken;
  final String? category;
  final String? tags;

  TweetRequestOption({
    this.after,
    this.before,
    this.parent,
    this.rows = 100,
    this.replyTo,
    this.nextPageToken,
    this.category,
    this.tags,
  });

  final int rows;
  final String? after;
  final String? before;
  final String? parent;
  final String? replyTo;
  final String? nextPageToken;
  final String? category;
  final String? tags;

  @override
  List<Object?> get props =>
      [rows, after!, before!, parent!, replyTo!, nextPageToken!, category!, tags!];

  @override
  bool get stringify => true;
}
