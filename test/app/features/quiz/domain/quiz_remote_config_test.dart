import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/quiz/domain/quiz_remote_config.dart';

void main() {
  group(QuizRemoteConfig, () {
    late QuizRemoteConfig sut;

    late IRemoteConfigService mockRemoteConfig;

    setUp(() {
      mockRemoteConfig = _MockRemoteConfigService();

      sut = QuizRemoteConfig(
        remoteConfig: mockRemoteConfig,
      );

      when(() => mockRemoteConfig.getBool(any())).thenAnswer(
        (invocation) =>
            RemoteConfigKeys.defaults[invocation.positionalArguments.first],
      );
      when(() => mockRemoteConfig.getInt(any())).thenAnswer(
        (invocation) =>
            RemoteConfigKeys.defaults[invocation.positionalArguments.first],
      );
      when(() => mockRemoteConfig.getList<String>(any())).thenAnswer(
        (invocation) =>
            RemoteConfigKeys.defaults[invocation.positionalArguments.first],
      );
    });

    test('given animation duration should be 400 by default', () {
      expect(sut.animationDuration, const Duration(milliseconds: 400));
    });
  });
}

class _MockRemoteConfigService extends Mock implements IRemoteConfigService {}
