// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/main_menu/data/model/account_preference_model.dart';

void main() {
  group(AccountPreferenceModel, () {
    test('fromJson correctly creates AccountPreferenceModel', () {
      final Map<String, dynamic> jsonData = {
        'key': 'testKey',
        'label': 'testLabel',
        'value': '1',
      };

      final expectedModel = AccountPreferenceModel(
        key: 'testKey',
        label: 'testLabel',
        value: true,
      );

      final resultModel = AccountPreferenceModel.fromJson(jsonData);

      expect(resultModel, equals(expectedModel));
    });
  });

  group(AccountPreferenceSessionModel, () {
    test('fromJson correctly creates AccountPreferenceSessionModel', () {
      final Map<String, dynamic> jsonData = {
        'preferences': [
          {
            'key': 'testKey',
            'label': 'testLabel',
            'value': '1',
          }
        ],
      };

      final expectedPreferenceModel = AccountPreferenceModel(
        key: 'testKey',
        label: 'testLabel',
        value: true,
      );

      final expectedSessionModel = AccountPreferenceSessionModel(
        preferences: [expectedPreferenceModel],
      );

      final resultSessionModel =
          AccountPreferenceSessionModel.fromJson(jsonData);

      expect(resultSessionModel, equals(expectedSessionModel));
    });
  });
}
