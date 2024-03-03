abstract class RemoteConfigKeys {
  static const featureLoginOffline = 'feature_login_offline';

  static const featureNewQuiz = 'feature_new_quiz';
  static const featureQuizDisabledOrigins = 'feature_new_quiz_disabled_origins';
  static const configQuizAnimationDuration = 'config_quiz_animation_duration';

  static const Map<String, dynamic> defaults = {
    featureLoginOffline: false,
    featureNewQuiz: false,
    featureQuizDisabledOrigins: '[]',
    configQuizAnimationDuration: 400,
  };
}
