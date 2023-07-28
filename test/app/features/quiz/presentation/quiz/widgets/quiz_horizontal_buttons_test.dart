import 'package:flutter/material.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_horizontal_buttons.dart';

void main() {
  group(QuizHorizontalButtonsWidget, () {
    testWidgets(
      'should show buttons',
      (tester) async {
        // act
        await tester.pumpWidget(
          buildTestableWidget(
            QuizHorizontalButtonsWidget(
              reference: 'reference',
              options: const [
                QuizMessageChoiceOption(index: 'Y', display: 'Sim'),
                QuizMessageChoiceOption(index: 'N', display: 'Não'),
                QuizMessageChoiceOption(index: 'M', display: 'Talvez'),
              ],
              onPressed: (_) {},
            ),
          ),
        );

        // assert
        expect(find.widgetWithText(RaisedButton, 'SIM'), findsOneWidget);
        expect(find.widgetWithText(RaisedButton, 'NÃO'), findsOneWidget);
        expect(find.widgetWithText(RaisedButton, 'TALVEZ'), findsOneWidget);
      },
    );

    testWidgets(
      'should call onPressed when button is pressed',
      (tester) async {
        // arrange
        final onPressed = MockOnPressed();

        await tester.pumpWidget(
          buildTestableWidget(
            QuizHorizontalButtonsWidget(
              reference: 'reference',
              options: const [
                QuizMessageChoiceOption(index: 'Y', display: 'Sim'),
                QuizMessageChoiceOption(index: 'N', display: 'Não'),
                QuizMessageChoiceOption(index: 'M', display: 'Talvez'),
              ],
              onPressed: onPressed,
            ),
          ),
        );

        // act
        await tester.tap(find.widgetWithText(RaisedButton, 'SIM'));

        // assert
        verify(() => onPressed.call({'reference': 'Y'})).called(1);
      },
    );
  });
}

abstract class IUserReaction {
  void call(Map<String, String> reaction);
}

class MockOnPressed extends Mock implements IUserReaction {}
