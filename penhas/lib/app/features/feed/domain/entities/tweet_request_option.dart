import 'package:equatable/equatable.dart';

class TweetRequestOption extends Equatable {
  final String after;
  final String before;
  final String parent;
  final bool onlyMyself;
  final bool skipMyself;
  final int rows;
  final String replyTo;

  TweetRequestOption({
    this.after,
    this.before,
    this.parent,
    this.onlyMyself = false,
    this.skipMyself = false,
    this.rows = 100,
    this.replyTo,
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
      ];

  @override
  bool get stringify => true;
}
