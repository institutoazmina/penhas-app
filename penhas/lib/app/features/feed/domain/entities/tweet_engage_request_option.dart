class TweetEngageRequestOption {
  final String tweetId;
  final String message;

  TweetEngageRequestOption({
    this.tweetId,
    this.message,
  }) : assert(tweetId != null);
}

class TweetCreateRequestOption {
  final String message;

  TweetCreateRequestOption(this.message);
}
