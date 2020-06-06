import 'package:equatable/equatable.dart';

class TweetRequestOption extends Equatable {
  final String after;
  final String before;
  final bool onlyMyself;
  final bool skipMyself;
  final int rows;
  final String replyTo;

  TweetRequestOption({
    this.after,
    this.before,
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
        onlyMyself,
        skipMyself,
        rows,
        replyTo,
      ];

  @override
  bool get stringify => true;
}
