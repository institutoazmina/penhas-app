// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';

void main() {
  group(FilterTagModel, () {
    test('fromJson correctly creates FilterTagModel', () {
      final Map<String, dynamic> jsonData = {
        'value': 'testId',
        'label': 'testLabel',
        'default': 1,
      };

      final expectedModel = FilterTagModel(
        id: 'testId',
        label: 'testLabel',
        isSelected: true,
      );

      final resultModel = FilterTagModel.fromJson(jsonData);

      expect(resultModel, equals(expectedModel));
    });

    test('fromJson correctly handles null values', () {
      final Map<String, dynamic> jsonData = {
        'id': 'testId',
        'title': 'testLabel',
        'default': 0,
      };

      final expectedModel = FilterTagModel(
        id: 'testId',
        label: 'testLabel',
        isSelected: false,
      );

      final resultModel = FilterTagModel.fromJson(jsonData);

      expect(resultModel, equals(expectedModel));
    });

    test('fromJson returns null when argument is null', () {
      final resultModel = FilterTagModel.fromJson(null);

      expect(resultModel, isNull);
    });
  });
}
