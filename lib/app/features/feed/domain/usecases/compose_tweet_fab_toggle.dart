import '../../../../core/managers/modules_sevices.dart';
import 'escape_manual_toggle.dart';
import 'tweet_toggle_feature.dart';

class ComposeTweetFabToggleFeature {
  ComposeTweetFabToggleFeature({
    required IAppModulesServices modulesServices,
  })  : _escapeManualToggleFeature = EscapeManualToggleFeature(
          modulesServices: modulesServices,
        ),
        _tweetToggleFeature = TweetToggleFeature(
          modulesServices: modulesServices,
        );

  final EscapeManualToggleFeature _escapeManualToggleFeature;
  final TweetToggleFeature _tweetToggleFeature;

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async =>
      await _escapeManualToggleFeature.isEnabled &&
      await _tweetToggleFeature.isEnabled;
}
