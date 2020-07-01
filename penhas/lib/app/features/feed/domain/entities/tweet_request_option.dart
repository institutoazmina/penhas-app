import 'package:equatable/equatable.dart';

class TweetRequestOption extends Equatable {
  final int rows;
  final String after;
  final String before;
  final String parent;
  final String replyTo;
  final String nextPageToken;
  final bool onlyMyself;
  final bool skipMyself;
  final String category;
  final String tags;

  TweetRequestOption({
    this.after,
    this.before,
    this.parent,
    this.onlyMyself = false,
    this.skipMyself = false,
    this.rows = 100,
    this.replyTo,
    this.nextPageToken,
    this.category = 'all',
    this.tags,
  })  : assert(rows != null),
        assert(onlyMyself != null),
        assert(skipMyself != null);

  @override
  List<Object> get props => [
        after,
        before,
        parent,
        onlyMyself,
        skipMyself,
        rows,
        replyTo,
        category,
      ];

  @override
  bool get stringify => true;
}
