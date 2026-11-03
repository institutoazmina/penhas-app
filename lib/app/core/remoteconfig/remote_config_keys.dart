abstract class RemoteConfigKeys {
  static const featureLoginOffline = 'feature_login_offline';
  static const featureUpdatePrompt = 'feature_update_prompt';

  static const featureNewQuiz = 'feature_new_quiz';
  static const featureQuizDisabledOrigins = 'feature_new_quiz_disabled_origins';
  static const configQuizAnimationDuration = 'config_quiz_animation_duration';
  static const configRecommendedBuildAndroid =
      'config_recommended_build_android';
  static const configRecommendedBuildIos = 'config_recommended_build_ios';

  static const Map<String, dynamic> defaults = {
    featureLoginOffline: false,
    featureUpdatePrompt: false,
    configQuizAnimationDuration: 400,
    configRecommendedBuildAndroid: 0,
    configRecommendedBuildIos: 0,
  };
}
