import '../../../core/remoteconfig/i_remote_config.dart';

class QuizRemoteConfig {
  QuizRemoteConfig({
    required IRemoteConfigService remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfigService _remoteConfig;

  Duration get animationDuration {
    final durationInMs = _remoteConfig.getInt(
      RemoteConfigKeys.configQuizAnimationDuration,
    );
    return Duration(milliseconds: durationInMs);
  }
}
