import 'escape_manual_toggle.dart';
import 'tweet_toggle_feature.dart';

class ComposeTweetFabToggleFeature {
  ComposeTweetFabToggleFeature({
    required EscapeManualToggleFeature escapeManualToggleFeature,
    required TweetToggleFeature tweetToggleFeature,
  })  : _escapeManualToggleFeature = escapeManualToggleFeature,
        _tweetToggleFeature = tweetToggleFeature;

  final EscapeManualToggleFeature _escapeManualToggleFeature;
  final TweetToggleFeature _tweetToggleFeature;

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async =>
      await _escapeManualToggleFeature.isEnabled &&
      await _tweetToggleFeature.isEnabled;
}
