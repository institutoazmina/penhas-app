import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_feature.dart';
import 'package:penhas/app/core/network/api_version_policy.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';

class _MockRemoteConfigService extends Mock implements IRemoteConfigService {}

void main() {
  late _MockRemoteConfigService remoteConfig;
  late ApiVersionPolicy sut;

  setUp(() {
    remoteConfig = _MockRemoteConfigService();
    sut = ApiVersionPolicy(remoteConfig: remoteConfig);
  });

  test('maps every API feature to its Remote Config flag', () {
    const flags = {
      ApiFeature.authentication: 'feature_api_v2_authentication',
      ApiFeature.appState: 'feature_api_v2_app_state',
      ApiFeature.account: 'feature_api_v2_account',
      ApiFeature.users: 'feature_api_v2_users',
      ApiFeature.feed: 'feature_api_v2_feed',
      ApiFeature.chat: 'feature_api_v2_chat',
      ApiFeature.notifications: 'feature_api_v2_notifications',
      ApiFeature.guardians: 'feature_api_v2_guardians',
      ApiFeature.audios: 'feature_api_v2_audios',
      ApiFeature.supportCenter: 'feature_api_v2_support_center',
      ApiFeature.quiz: 'feature_api_v2_quiz',
      ApiFeature.escapeManual: 'feature_api_v2_escape_manual',
    };

    for (final entry in flags.entries) {
      when(() => remoteConfig.getBool(entry.value)).thenReturn(true);

      expect(
        sut.headersFor(entry.key),
        const {ApiVersionPolicy.headerName: ApiVersionPolicy.versionV2},
      );
      verify(() => remoteConfig.getBool(entry.value)).called(1);
    }
  });

  test('reads Remote Config again for every request decision', () {
    var enabled = false;
    when(() => remoteConfig.getBool(RemoteConfigKeys.featureApiV2Feed))
        .thenAnswer((_) => enabled);

    expect(sut.headersFor(ApiFeature.feed), isEmpty);

    enabled = true;

    expect(
      sut.headersFor(ApiFeature.feed),
      const {ApiVersionPolicy.headerName: ApiVersionPolicy.versionV2},
    );
    verify(() => remoteConfig.getBool(RemoteConfigKeys.featureApiV2Feed))
        .called(2);
  });
}
