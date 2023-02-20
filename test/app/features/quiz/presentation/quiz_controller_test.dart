import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_module.dart';

import '../../../../utils/aditional_bind_module.dart';

class MockLocationServices extends Mock implements ILocationServices {}

void main() {
  initModules([
    QuizModule(),
    AditionalBindModule(
      binds: [
        Bind.singleton((i) => MockLocationServices()),
      ],
    ),
  ]);
  // QuizController quiz;
  //
  setUp(() {
    //     quiz = QuizModule.to.get<QuizController>();
  });

  group('QuizController Test', () {
    //   test("First Test", () {
    //     expect(quiz, isInstanceOf<QuizController>());
    //   });

    //   test("Set Value", () {
    //     expect(quiz.value, equals(0));
    //     quiz.increment();
    //     expect(quiz.value, equals(1));
    //   });
  });
}
