import 'package:meta/meta.dart';

class TweetEngageRequestOption {
  final String tweetId;
  final String message;
  final bool dislike;

  TweetEngageRequestOption({
    this.tweetId,
    this.message,
    this.dislike = false,
  }) : assert(tweetId != null);
}

class TweetCreateRequestOption {
  final String message;

  TweetCreateRequestOption({
    @required this.message,
  });
}
