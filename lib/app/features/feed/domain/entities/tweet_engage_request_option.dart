class TweetEngageRequestOption {
  TweetEngageRequestOption({
    required this.tweetId,
    required this.message,
    this.dislike = false,
  });

  final String tweetId;
  final String message;
  final bool dislike;
}

class TweetCreateRequestOption {
  TweetCreateRequestOption({
    required this.message,
  });

  final String message;
}
