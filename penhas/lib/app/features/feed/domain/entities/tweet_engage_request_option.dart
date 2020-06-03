class TweetEngageRequestOption {
  final String tweetId;
  final String message;

  TweetEngageRequestOption({
    this.tweetId,
    this.message,
  }) : assert(tweetId != null);
}
