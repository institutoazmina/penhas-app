import 'package:dartz/dartz.dart' show left, right;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/start_quiz.dart';
import 'package:penhas/app/features/quiz/presentation/quiz_start/quiz_start_page.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';

import '../../../../../utils/test_utils.dart';

class _MockStartQuizUseCase extends Mock implements StartQuizUseCase {}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _FakeQuizSessionEntity extends Fake implements QuizSessionEntity {}

void main() {
  group(QuizStartPage, () {
    late StartQuizUseCase mockStartQuiz;

    late IModularNavigator mockNavigator;

    setUp(() {
      mockStartQuiz = _MockStartQuizUseCase();
      mockNavigator = _MockModularNavigate();

      Modular.navigatorDelegate = mockNavigator;

      initModule(
        QuizModule(),
        replaceBinds: [
          Bind.factory<StartQuizUseCase>(
            (i) => mockStartQuiz,
          ),
        ],
      );
    });

    testWidgets(
      'should display failure state when start quiz fails',
      (tester) async {
        // arrange
        final failure = UnknownFailure();
        when(() => mockStartQuiz(any())).thenAnswer((_) async => left(failure));

        // act
        await tester.pumpWidget(
          buildTestableWidget(
            QuizStartPage(
              controller: Modular.get(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // assert
        expect(find.byType(SupportCenterGeneralError), findsOneWidget);
      },
    );

    testWidgets(
      'should push /quiz with success when start quiz succeeds',
      (tester) async {
        // arrange
        final session = _FakeQuizSessionEntity();
        when(() => mockStartQuiz(any()))
            .thenAnswer((_) async => right(session));
        when(() => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            )).thenAnswer((_) async => null);

        // act
        await tester.pumpWidget(
          buildTestableWidget(
            QuizStartPage(
              controller: Modular.get(),
            ),
          ),
        );

        await tester.pump();

        // assert
        verify(() => mockNavigator.pushNamed(
              any(),
              arguments: any(named: 'arguments'),
            )).called(1);
      },
    );
  });
}
