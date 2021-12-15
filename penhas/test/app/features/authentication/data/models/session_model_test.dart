import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  final sessionModel = SessionModel(
    sessionToken: 'my_strong_session_token',
    deletedScheduled: false,
  );

  group('SessionModel', () {
    test('should be a subclass of SessionEntity', () {
      expect(sessionModel, isA<SessionEntity>());
    });

    group('fromJson', () {
      test('should return a valid model with a valid JSON', () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            await JsonUtil.getJson(from: 'authentication/login_success.json');
        // act
        final result = SessionModel.fromJson(jsonMap);
        // assert
        expect(result, sessionModel);
      });
    });
  });
}
