import '../remoteconfig/i_remote_config.dart';
import 'api_feature.dart';

class ApiVersionPolicy {
  const ApiVersionPolicy({required IRemoteConfigService remoteConfig})
      : _remoteConfig = remoteConfig;

  static const headerName = 'x-api-version';
  static const versionV2 = 'v2';

  final IRemoteConfigService _remoteConfig;

  Map<String, String> headersFor(ApiFeature feature) {
    final key = switch (feature) {
      ApiFeature.authentication => RemoteConfigKeys.featureApiV2Authentication,
      ApiFeature.appState => RemoteConfigKeys.featureApiV2AppState,
      ApiFeature.account => RemoteConfigKeys.featureApiV2Account,
      ApiFeature.users => RemoteConfigKeys.featureApiV2Users,
      ApiFeature.feed => RemoteConfigKeys.featureApiV2Feed,
      ApiFeature.chat => RemoteConfigKeys.featureApiV2Chat,
      ApiFeature.notifications => RemoteConfigKeys.featureApiV2Notifications,
      ApiFeature.guardians => RemoteConfigKeys.featureApiV2Guardians,
      ApiFeature.audios => RemoteConfigKeys.featureApiV2Audios,
      ApiFeature.supportCenter => RemoteConfigKeys.featureApiV2SupportCenter,
      ApiFeature.quiz => RemoteConfigKeys.featureApiV2Quiz,
      ApiFeature.escapeManual => RemoteConfigKeys.featureApiV2EscapeManual,
    };

    return _remoteConfig.getBool(key)
        ? const {headerName: versionV2}
        : const {};
  }
}
