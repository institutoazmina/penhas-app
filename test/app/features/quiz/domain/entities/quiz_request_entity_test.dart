// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

void main() {
  group(QuizRequestEntity, () {
    test('different entity return false', () {
      final entity1 = QuizRequestEntity(
        sessionId: '1',
        options: {'1': '1'},
      );
      final entity2 = QuizRequestEntity(
        sessionId: '2',
        options: {'2': '2'},
      );

      expect(entity1 == entity2, false);
    });
  });
}
