import '../../../core/remoteconfig/i_remote_config.dart';

class QuizRemoteConfig {
  QuizRemoteConfig({
    required IRemoteConfigService remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfigService _remoteConfig;

  bool get isEnabled => _remoteConfig.getBool(
        RemoteConfigKeys.featureNewQuiz,
      );

  Duration get animationDuration {
    final durationInMs = _remoteConfig.getInt(
      RemoteConfigKeys.configQuizAnimationDuration,
    );
    return Duration(milliseconds: durationInMs);
  }

  List<String> get _disabledOrigins => _remoteConfig.getList<String>(
        RemoteConfigKeys.featureQuizDisabledOrigins,
      );

  bool isEnabledForOrigin(String? origin) {
    if (origin == null || _disabledOrigins.isEmpty) isEnabled;
    return isEnabled && !_disabledOrigins.contains(origin);
  }
}
