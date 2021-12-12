<<<<<<< HEAD
=======

>>>>>>> Fix code syntax
class TweetEngageRequestOption {
  final String tweetId;
  final String? message;
  final bool dislike;

  TweetEngageRequestOption({
    required this.tweetId,
    this.message,
    this.dislike = false,
  });

  final String tweetId;
  final String? message;
  final bool dislike;
}

class TweetCreateRequestOption {
  final String? message;

  TweetCreateRequestOption({
    required this.message,
  });

  final String? message;
}
