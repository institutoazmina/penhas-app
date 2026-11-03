abstract class RemoteConfigKeys {
  static const featureLoginOffline = 'feature_login_offline';
  static const featureUpdatePrompt = 'feature_update_prompt';
  static const featureApiV2Authentication = 'feature_api_v2_authentication';
  static const featureApiV2AppState = 'feature_api_v2_app_state';
  static const featureApiV2Account = 'feature_api_v2_account';
  static const featureApiV2Users = 'feature_api_v2_users';
  static const featureApiV2Feed = 'feature_api_v2_feed';
  static const featureApiV2Chat = 'feature_api_v2_chat';
  static const featureApiV2Notifications = 'feature_api_v2_notifications';
  static const featureApiV2Guardians = 'feature_api_v2_guardians';
  static const featureApiV2Audios = 'feature_api_v2_audios';
  static const featureApiV2SupportCenter = 'feature_api_v2_support_center';
  static const featureApiV2Quiz = 'feature_api_v2_quiz';
  static const featureApiV2EscapeManual = 'feature_api_v2_escape_manual';

  static const featureNewQuiz = 'feature_new_quiz';
  static const featureQuizDisabledOrigins = 'feature_new_quiz_disabled_origins';
  static const configQuizAnimationDuration = 'config_quiz_animation_duration';
  static const configRecommendedBuildAndroid =
      'config_recommended_build_android';
  static const configRecommendedBuildIos = 'config_recommended_build_ios';

  static const Map<String, dynamic> defaults = {
    featureLoginOffline: false,
    featureUpdatePrompt: false,
    featureApiV2Authentication: false,
    featureApiV2AppState: false,
    featureApiV2Account: false,
    featureApiV2Users: false,
    featureApiV2Feed: false,
    featureApiV2Chat: false,
    featureApiV2Notifications: false,
    featureApiV2Guardians: false,
    featureApiV2Audios: false,
    featureApiV2SupportCenter: false,
    featureApiV2Quiz: false,
    featureApiV2EscapeManual: false,
    configQuizAnimationDuration: 400,
    configRecommendedBuildAndroid: 0,
    configRecommendedBuildIos: 0,
  };
}
